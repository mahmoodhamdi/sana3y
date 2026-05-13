import axios from 'axios';
import crypto from 'crypto';
import { config } from '@config/index';
import { logger } from '@utils/logger';
import {
  PaymentProvider,
  PaymentInitInput,
  PaymentInitResult,
  PaymentWebhookInput,
  PaymentWebhookResult,
} from '../types';

const PAYMOB_BASE_URL = 'https://accept.paymob.com/api';

export class PaymobPaymentProvider implements PaymentProvider {
  readonly name = 'paymob';
  readonly displayNameAr = 'باي موب';

  isConfigured(): boolean {
    return Boolean(
      config.paymob.apiKey && config.paymob.integrationId && config.paymob.hmacSecret
    );
  }

  async initialize(input: PaymentInitInput): Promise<PaymentInitResult> {
    if (!this.isConfigured()) {
      return {
        success: false,
        provider: this.name,
        paymentId: '',
        error: 'Paymob not configured',
      };
    }
    try {
      const authToken = await this.getAuthToken();
      const orderId = await this.createOrder(authToken, input.amount, input.requestId);
      const paymentKey = await this.getPaymentKey(authToken, orderId, input.amount, input.customer);
      return {
        success: true,
        provider: this.name,
        paymentId: String(orderId),
        iframeUrl: `https://accept.paymob.com/api/acceptance/iframes/${config.paymob.iframeId}?payment_token=${paymentKey}`,
      };
    } catch (error) {
      const msg = error instanceof Error ? error.message : 'Paymob error';
      logger.error(`[Paymob] init failed: ${msg}`);
      return { success: false, provider: this.name, paymentId: '', error: msg };
    }
  }

  async handleWebhook(input: PaymentWebhookInput): Promise<PaymentWebhookResult> {
    try {
      const body = (input.body as Record<string, unknown>) || {};
      const obj = (body.obj as Record<string, unknown>) || {};
      const hmacReceived = (input.headers['hmac'] as string) || (body.hmac as string) || '';
      const computedHmac = this.computeHmac(obj);
      const verified = Boolean(hmacReceived) && hmacReceived === computedHmac;
      const success = Boolean(obj.success);
      return {
        verified,
        paymentId: obj.id != null ? String(obj.id) : undefined,
        status: success ? 'succeeded' : 'failed',
        amount:
          typeof obj.amount_cents === 'number' ? Number(obj.amount_cents) / 100 : undefined,
        raw: body,
      };
    } catch (error) {
      const msg = error instanceof Error ? error.message : 'Paymob webhook error';
      return { verified: false, status: 'unknown', error: msg };
    }
  }

  private async getAuthToken(): Promise<string> {
    const res = await axios.post<{ token: string }>(`${PAYMOB_BASE_URL}/auth/tokens`, {
      api_key: config.paymob.apiKey,
    });
    return res.data.token;
  }

  private async createOrder(
    authToken: string,
    amount: number,
    merchantOrderId: string
  ): Promise<number> {
    const res = await axios.post<{ id: number }>(`${PAYMOB_BASE_URL}/ecommerce/orders`, {
      auth_token: authToken,
      delivery_needed: false,
      amount_cents: Math.round(amount * 100),
      currency: 'EGP',
      merchant_order_id: `${merchantOrderId}-${Date.now()}`,
      items: [],
    });
    return res.data.id;
  }

  private async getPaymentKey(
    authToken: string,
    orderId: number,
    amount: number,
    customer: PaymentInitInput['customer']
  ): Promise<string> {
    const res = await axios.post<{ token: string }>(`${PAYMOB_BASE_URL}/acceptance/payment_keys`, {
      auth_token: authToken,
      amount_cents: Math.round(amount * 100),
      expiration: 3600,
      order_id: orderId,
      billing_data: {
        apartment: 'NA',
        email: customer.email,
        floor: 'NA',
        first_name: customer.firstName,
        street: 'NA',
        building: 'NA',
        phone_number: customer.phone,
        shipping_method: 'NA',
        postal_code: 'NA',
        city: 'NA',
        country: 'EG',
        last_name: customer.lastName,
        state: 'NA',
      },
      currency: 'EGP',
      integration_id: config.paymob.integrationId,
    });
    return res.data.token;
  }

  private computeHmac(obj: Record<string, unknown>): string {
    const concat = [
      obj.amount_cents,
      obj.created_at,
      obj.currency,
      obj.error_occured,
      obj.has_parent_transaction,
      obj.id,
      obj.integration_id,
      obj.is_3d_secure,
      obj.is_auth,
      obj.is_capture,
      obj.is_refunded,
      obj.is_standalone_payment,
      obj.is_voided,
      obj.order?.['id' as keyof typeof obj.order],
      obj.owner,
      obj.pending,
      obj.source_data?.['pan' as keyof typeof obj.source_data],
      obj.source_data?.['sub_type' as keyof typeof obj.source_data],
      obj.source_data?.['type' as keyof typeof obj.source_data],
      obj.success,
    ]
      .map((v) => (v == null ? '' : String(v)))
      .join('');
    return crypto.createHmac('sha512', config.paymob.hmacSecret).update(concat).digest('hex');
  }
}
