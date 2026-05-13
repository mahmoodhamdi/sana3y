import { logger } from '@utils/logger';
import { PaymentProvider, PaymentInitInput, PaymentInitResult, PaymentWebhookInput, PaymentWebhookResult } from '../types';

let counter = 0;

/**
 * MockPaymentProvider — succeeds instantly. Used in dev/CI/demo when there is no real
 * provider configured, so customer/craftsman flows can be exercised end-to-end without
 * hitting Paymob/Fawry/Vodafone Cash.
 */
export class MockPaymentProvider implements PaymentProvider {
  readonly name = 'mock';
  readonly displayNameAr = 'وضع التجربة';

  isConfigured(): boolean {
    return true;
  }

  async initialize(input: PaymentInitInput): Promise<PaymentInitResult> {
    counter += 1;
    const paymentId = `mock-${Date.now()}-${counter}`;
    logger.info(
      `[Payment Mock] init paymentId=${paymentId} amount=${input.amount} ${input.currency} request=${input.requestId}`
    );
    return {
      success: true,
      provider: this.name,
      paymentId,
      redirectUrl: `mock://payment/${paymentId}?amount=${input.amount}`,
      iframeUrl: `data:text/html,<h3>Mock payment for ${input.amount} ${input.currency}</h3>`,
      instructions: 'هذه عملية دفع تجريبية لعرض المنصة. لن يتم خصم أي مبلغ.',
    };
  }

  async handleWebhook(input: PaymentWebhookInput): Promise<PaymentWebhookResult> {
    const body = (input.body as Record<string, unknown>) || {};
    const paymentId =
      typeof body.paymentId === 'string'
        ? body.paymentId
        : typeof body.id === 'string'
          ? body.id
          : undefined;
    return {
      verified: true,
      paymentId,
      status: 'succeeded',
      amount: typeof body.amount === 'number' ? body.amount : undefined,
      raw: body,
    };
  }
}
