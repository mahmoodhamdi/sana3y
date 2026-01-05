import axios from 'axios';
import crypto from 'crypto';
import config from '@config/index';
import Transaction from '@models/Transaction';
import { BadRequestError } from '@utils/errors';
import logger from '@utils/logger';

const PAYMOB_BASE_URL = 'https://accept.paymob.com/api';

interface PaymentOrderData {
  userId: string;
  requestId: string;
  amount: number;
  customerName: string;
  customerEmail: string;
  customerPhone?: string;
}

interface PaymobAuthResponse {
  token: string;
}

interface PaymobOrderResponse {
  id: number;
}

interface PaymobPaymentKeyResponse {
  token: string;
}

class PaymentService {
  private apiKey: string;
  private integrationId: string;
  private iframeId: string;
  private hmacSecret: string;

  constructor() {
    this.apiKey = config.paymob?.apiKey || '';
    this.integrationId = config.paymob?.integrationId || '';
    this.iframeId = config.paymob?.iframeId || '';
    this.hmacSecret = config.paymob?.hmacSecret || '';
  }

  /**
   * Get authentication token from Paymob
   */
  private async getAuthToken(): Promise<string> {
    try {
      const response = await axios.post<PaymobAuthResponse>(
        `${PAYMOB_BASE_URL}/auth/tokens`,
        { api_key: this.apiKey }
      );
      return response.data.token;
    } catch (error) {
      logger.error('Paymob auth error:', error);
      throw new BadRequestError('فشل في الاتصال ببوابة الدفع');
    }
  }

  /**
   * Create order on Paymob
   */
  private async createOrder(
    authToken: string,
    amount: number,
    merchantOrderId: string
  ): Promise<number> {
    try {
      const response = await axios.post<PaymobOrderResponse>(
        `${PAYMOB_BASE_URL}/ecommerce/orders`,
        {
          auth_token: authToken,
          delivery_needed: false,
          amount_cents: Math.round(amount * 100), // Convert to cents
          currency: 'EGP',
          merchant_order_id: merchantOrderId,
          items: [],
        }
      );
      return response.data.id;
    } catch (error) {
      logger.error('Paymob order creation error:', error);
      throw new BadRequestError('فشل في إنشاء طلب الدفع');
    }
  }

  /**
   * Get payment key for iframe
   */
  private async getPaymentKey(
    authToken: string,
    orderId: number,
    amount: number,
    billingData: {
      firstName: string;
      lastName: string;
      email: string;
      phone: string;
    }
  ): Promise<string> {
    try {
      const response = await axios.post<PaymobPaymentKeyResponse>(
        `${PAYMOB_BASE_URL}/acceptance/payment_keys`,
        {
          auth_token: authToken,
          amount_cents: Math.round(amount * 100),
          expiration: 3600,
          order_id: orderId,
          billing_data: {
            apartment: 'NA',
            email: billingData.email,
            floor: 'NA',
            first_name: billingData.firstName,
            street: 'NA',
            building: 'NA',
            phone_number: billingData.phone || '01000000000',
            shipping_method: 'NA',
            postal_code: 'NA',
            city: 'NA',
            country: 'EG',
            last_name: billingData.lastName,
            state: 'NA',
          },
          currency: 'EGP',
          integration_id: parseInt(this.integrationId, 10),
        }
      );
      return response.data.token;
    } catch (error) {
      logger.error('Paymob payment key error:', error);
      throw new BadRequestError('فشل في إنشاء مفتاح الدفع');
    }
  }

  /**
   * Initialize a payment for a service request
   */
  async initializePayment(data: PaymentOrderData): Promise<{
    paymentUrl: string;
    transactionId: string;
    orderId: number;
  }> {
    // Create transaction record
    const transaction = await Transaction.create({
      fromUserId: data.userId,
      type: 'job_payment' as const,
      amount: data.amount,
      fee: 0,
      netAmount: data.amount,
      notes: `دفع للطلب #${data.requestId}`,
      status: 'pending' as const,
      paymentMethod: 'card',
    });

    const merchantOrderId = transaction._id.toString();

    // Get auth token
    const authToken = await this.getAuthToken();

    // Create order
    const orderId = await this.createOrder(authToken, data.amount, merchantOrderId);

    // Parse customer name
    const nameParts = data.customerName.split(' ');
    const firstName = nameParts[0] || 'Customer';
    const lastName = nameParts.slice(1).join(' ') || 'NA';

    // Get payment key
    const paymentKey = await this.getPaymentKey(authToken, orderId, data.amount, {
      firstName,
      lastName,
      email: data.customerEmail,
      phone: data.customerPhone || '',
    });

    // Update transaction with payment details
    await Transaction.findByIdAndUpdate(transaction._id, {
      paymentId: String(orderId),
    });

    // Generate payment URL
    const paymentUrl = `https://accept.paymob.com/api/acceptance/iframes/${this.iframeId}?payment_token=${paymentKey}`;

    return {
      paymentUrl,
      transactionId: transaction._id.toString(),
      orderId,
    };
  }

  /**
   * Verify webhook callback from Paymob
   */
  verifyWebhookSignature(
    data: Record<string, unknown>,
    receivedHmac: string
  ): boolean {
    // Paymob HMAC calculation
    const hmacFields = [
      'amount_cents',
      'created_at',
      'currency',
      'error_occured',
      'has_parent_transaction',
      'id',
      'integration_id',
      'is_3d_secure',
      'is_auth',
      'is_capture',
      'is_refunded',
      'is_standalone_payment',
      'is_voided',
      'order.id',
      'owner',
      'pending',
      'source_data.pan',
      'source_data.sub_type',
      'source_data.type',
      'success',
    ];

    const concatenatedValues = hmacFields
      .map((field) => {
        const keys = field.split('.');
        let value: unknown = data;
        for (const key of keys) {
          value = (value as Record<string, unknown>)?.[key];
        }
        return String(value ?? '');
      })
      .join('');

    const calculatedHmac = crypto
      .createHmac('sha512', this.hmacSecret)
      .update(concatenatedValues)
      .digest('hex');

    return calculatedHmac === receivedHmac;
  }

  /**
   * Handle payment callback/webhook
   */
  async handlePaymentCallback(data: {
    obj: {
      id: number;
      success: boolean;
      order: { id: number; merchant_order_id: string };
      amount_cents: number;
      pending: boolean;
    };
    hmac: string;
  }): Promise<{ success: boolean; transactionId?: string }> {
    const { obj, hmac } = data;

    // Verify HMAC signature
    if (!this.verifyWebhookSignature(obj as unknown as Record<string, unknown>, hmac)) {
      logger.warn('Invalid Paymob webhook signature');
      return { success: false };
    }

    const transactionId = obj.order.merchant_order_id;
    const transaction = await Transaction.findById(transactionId);

    if (!transaction) {
      logger.warn(`Transaction not found: ${transactionId}`);
      return { success: false };
    }

    // Update transaction status
    if (obj.success && !obj.pending) {
      transaction.status = 'completed';
      transaction.paymentId = String(obj.id);
      transaction.processedAt = new Date();
    } else if (!obj.success) {
      transaction.status = 'failed';
      transaction.paymentId = String(obj.id);
    }

    await transaction.save();

    return { success: obj.success, transactionId };
  }

  /**
   * Get transaction status
   */
  async getTransactionStatus(transactionId: string): Promise<{
    status: string;
    amount: number;
    createdAt: Date;
  } | null> {
    const transaction = await Transaction.findById(transactionId);
    if (!transaction) {
      return null;
    }

    return {
      status: transaction.status,
      amount: transaction.amount,
      createdAt: transaction.createdAt,
    };
  }

  /**
   * Initialize wallet payment (Vodafone Cash, Orange Money, etc.)
   */
  async initializeWalletPayment(
    data: PaymentOrderData,
    walletPhone: string
  ): Promise<{
    redirectUrl: string;
    transactionId: string;
  }> {
    // Create transaction record
    const transaction = await Transaction.create({
      fromUserId: data.userId,
      type: 'job_payment' as const,
      amount: data.amount,
      fee: 0,
      netAmount: data.amount,
      notes: `دفع للطلب #${data.requestId} (محفظة إلكترونية)`,
      status: 'pending' as const,
      paymentMethod: 'wallet',
    });

    const merchantOrderId = transaction._id.toString();

    // Get auth token
    const authToken = await this.getAuthToken();

    // Create order
    const orderId = await this.createOrder(authToken, data.amount, merchantOrderId);

    // Parse customer name
    const nameParts = data.customerName.split(' ');
    const firstName = nameParts[0] || 'Customer';
    const lastName = nameParts.slice(1).join(' ') || 'NA';

    // Get payment key for wallet
    const paymentKey = await this.getPaymentKey(authToken, orderId, data.amount, {
      firstName,
      lastName,
      email: data.customerEmail,
      phone: walletPhone,
    });

    // Send wallet payment request
    try {
      const response = await axios.post(
        `${PAYMOB_BASE_URL}/acceptance/payments/pay`,
        {
          source: {
            identifier: walletPhone,
            subtype: 'WALLET',
          },
          payment_token: paymentKey,
        }
      );

      // Update transaction with payment details
      await Transaction.findByIdAndUpdate(transaction._id, {
        paymentId: String(orderId),
      });

      return {
        redirectUrl: response.data.redirect_url || '',
        transactionId: transaction._id.toString(),
      };
    } catch (error) {
      logger.error('Wallet payment error:', error);
      // Update transaction as failed
      await Transaction.findByIdAndUpdate(transaction._id, {
        status: 'failed',
      });
      throw new BadRequestError('فشل في معالجة الدفع بالمحفظة');
    }
  }
}

export default new PaymentService();
