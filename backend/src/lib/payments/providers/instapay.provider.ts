import { logger } from '@utils/logger';
import {
  PaymentProvider,
  PaymentInitInput,
  PaymentInitResult,
  PaymentWebhookInput,
  PaymentWebhookResult,
} from '../types';

/**
 * InstaPay — Egyptian bank-to-bank instant transfer network. There is no public REST
 * integration for end-merchants yet, so we expose this as a manual-reference provider:
 * we generate a payment reference, show the platform's IPN address, and rely on
 * admin reconciliation (or a future bank API) to mark the payment as completed.
 */
export class InstaPayPaymentProvider implements PaymentProvider {
  readonly name = 'instapay';
  readonly displayNameAr = 'إنستا باي';

  isConfigured(): boolean {
    return Boolean(process.env.INSTAPAY_IPA && process.env.INSTAPAY_BANK_ACCOUNT);
  }

  async initialize(input: PaymentInitInput): Promise<PaymentInitResult> {
    if (!this.isConfigured()) {
      return {
        success: false,
        provider: this.name,
        paymentId: '',
        error: 'InstaPay not configured (set INSTAPAY_IPA + INSTAPAY_BANK_ACCOUNT)',
      };
    }
    const reference = `IP-${input.requestId.slice(-6).toUpperCase()}-${Date.now().toString(36).toUpperCase()}`;
    logger.info(`[InstaPay] generated reference=${reference} amount=${input.amount}`);
    return {
      success: true,
      provider: this.name,
      paymentId: reference,
      reference,
      instructions: `حوّل ${input.amount} جنيه على إنستا باي إلى: ${process.env.INSTAPAY_IPA}\nاكتب الكود ${reference} في خانة "غرض التحويل" عشان نقدر نطابق الدفعة على طلبك.`,
    };
  }

  async handleWebhook(input: PaymentWebhookInput): Promise<PaymentWebhookResult> {
    const body = (input.body as Record<string, unknown>) || {};
    const reference = body.reference != null ? String(body.reference) : undefined;
    const verified = Boolean(body.adminConfirmed) && typeof reference === 'string';
    return {
      verified,
      paymentId: reference,
      status: verified ? 'succeeded' : 'pending',
      amount: typeof body.amount === 'number' ? body.amount : undefined,
      raw: body,
    };
  }
}
