import { config } from '@config/index';
import { logger } from '@utils/logger';
import {
  PaymentProvider,
  PaymentInitInput,
  PaymentInitResult,
  PaymentWebhookInput,
  PaymentWebhookResult,
} from '../types';
import { PaymobPaymentProvider } from './paymob.provider';

/**
 * Vodafone Cash via Paymob's wallet integration. Falls back to Paymob's pay-with-mobile-wallet
 * flow under the hood; we expose it as a separate provider so the UI can present a
 * Vodafone-Cash-branded option to customers.
 */
export class VodafoneCashPaymentProvider implements PaymentProvider {
  readonly name = 'vodafone_cash';
  readonly displayNameAr = 'فودافون كاش';

  private readonly inner = new PaymobPaymentProvider();

  isConfigured(): boolean {
    return this.inner.isConfigured() && Boolean(config.paymob.integrationId);
  }

  async initialize(input: PaymentInitInput): Promise<PaymentInitResult> {
    const result = await this.inner.initialize(input);
    if (!result.success) return { ...result, provider: this.name };
    logger.info(`[VodafoneCash] forwarded via Paymob paymentId=${result.paymentId}`);
    return {
      ...result,
      provider: this.name,
      instructions:
        'ادخل رقم محفظة فودافون كاش، هتوصلك OTP — أكدّه عشان نخلّص الدفع.',
    };
  }

  async handleWebhook(input: PaymentWebhookInput): Promise<PaymentWebhookResult> {
    const result = await this.inner.handleWebhook(input);
    return result;
  }
}
