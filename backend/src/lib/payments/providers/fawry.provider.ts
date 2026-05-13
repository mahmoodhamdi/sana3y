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

/**
 * Fawry — Egyptian cash-collection provider. Customers pay at outlets using a reference
 * code. Important for the segment of Egyptian users without cards or wallet apps.
 */
export class FawryPaymentProvider implements PaymentProvider {
  readonly name = 'fawry';
  readonly displayNameAr = 'فوري';

  isConfigured(): boolean {
    return Boolean(config.fawry.merchantCode && config.fawry.securityKey);
  }

  async initialize(input: PaymentInitInput): Promise<PaymentInitResult> {
    if (!this.isConfigured()) {
      return {
        success: false,
        provider: this.name,
        paymentId: '',
        error: 'Fawry not configured',
      };
    }
    try {
      const merchantRefNum = `${input.requestId}-${Date.now()}`;
      const signaturePayload = [
        config.fawry.merchantCode,
        merchantRefNum,
        input.customer.phone,
        input.customer.email,
        input.amount.toFixed(2),
        config.fawry.securityKey,
      ].join('');
      const signature = crypto.createHash('sha256').update(signaturePayload).digest('hex');
      const requestBody = {
        merchantCode: config.fawry.merchantCode,
        merchantRefNum,
        customerProfileId: input.userId,
        customerName: `${input.customer.firstName} ${input.customer.lastName}`,
        customerMobile: input.customer.phone,
        customerEmail: input.customer.email,
        paymentMethod: 'PAYATFAWRY',
        amount: Number(input.amount.toFixed(2)),
        currencyCode: input.currency,
        description: input.description ?? 'Sana3y service payment',
        signature,
      };
      const res = await axios.post(`${config.fawry.baseUrl}/ECommerceWeb/Fawry/payments/charge`, requestBody);
      const data = res.data as Record<string, unknown>;
      if (data.statusCode !== 200) {
        throw new Error(String(data.statusDescription ?? 'Fawry rejected the request'));
      }
      return {
        success: true,
        provider: this.name,
        paymentId: String(data.referenceNumber ?? merchantRefNum),
        reference: String(data.referenceNumber ?? merchantRefNum),
        instructions: 'استخدم رقم الإيصال في أي فرع فوري لإتمام الدفع. صلاحية الإيصال 48 ساعة.',
      };
    } catch (error) {
      const msg = error instanceof Error ? error.message : 'Fawry error';
      logger.error(`[Fawry] init failed: ${msg}`);
      return { success: false, provider: this.name, paymentId: '', error: msg };
    }
  }

  async handleWebhook(input: PaymentWebhookInput): Promise<PaymentWebhookResult> {
    const body = (input.body as Record<string, unknown>) || {};
    const referenceNumber = body.referenceNumber != null ? String(body.referenceNumber) : undefined;
    const signaturePayload = [
      String(body.fawryRefNumber ?? ''),
      String(body.merchantRefNumber ?? ''),
      String(body.paymentAmount ?? ''),
      String(body.orderAmount ?? ''),
      String(body.orderStatus ?? ''),
      String(body.paymentMethod ?? ''),
      String(body.paymentReferenceNumber ?? ''),
      config.fawry.securityKey,
    ].join('');
    const computed = crypto.createHash('sha256').update(signaturePayload).digest('hex');
    const verified = body.messageSignature === computed;
    const status =
      body.orderStatus === 'PAID' ? 'succeeded' : body.orderStatus === 'EXPIRED' ? 'failed' : 'pending';
    return {
      verified,
      paymentId: referenceNumber,
      status,
      amount: typeof body.paymentAmount === 'number' ? body.paymentAmount : undefined,
      raw: body,
    };
  }
}
