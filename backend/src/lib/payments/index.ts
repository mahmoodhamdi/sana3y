import { config } from '@config/index';
import { logger } from '@utils/logger';
import { PaymentProvider } from './types';
import { MockPaymentProvider } from './providers/mock.provider';
import { PaymobPaymentProvider } from './providers/paymob.provider';
import { FawryPaymentProvider } from './providers/fawry.provider';
import { VodafoneCashPaymentProvider } from './providers/vodafone_cash.provider';
import { InstaPayPaymentProvider } from './providers/instapay.provider';

const providers: Record<string, PaymentProvider> = {
  mock: new MockPaymentProvider(),
  paymob: new PaymobPaymentProvider(),
  fawry: new FawryPaymentProvider(),
  vodafone_cash: new VodafoneCashPaymentProvider(),
  instapay: new InstaPayPaymentProvider(),
};

let activeProvider: PaymentProvider | null = null;

export const getPaymentProvider = (override?: string): PaymentProvider => {
  if (override && providers[override]) return providers[override];
  if (activeProvider) return activeProvider;
  const selected = config.paymentProvider;
  const provider = providers[selected];
  if (!provider) {
    logger.warn(`Payment provider "${selected}" unknown; falling back to mock`);
    activeProvider = providers.mock;
    return activeProvider;
  }
  if (!provider.isConfigured() && selected !== 'mock') {
    logger.warn(`Payment provider "${selected}" not configured; falling back to mock`);
    activeProvider = providers.mock;
    return activeProvider;
  }
  activeProvider = provider;
  logger.info(`Payment provider selected: ${provider.name}`);
  return activeProvider;
};

export const listAvailablePaymentProviders = (): Array<{
  name: string;
  displayNameAr: string;
  configured: boolean;
}> =>
  Object.values(providers).map((p) => ({
    name: p.name,
    displayNameAr: p.displayNameAr,
    configured: p.isConfigured(),
  }));

/** For testing. */
export const __resetPaymentProviderForTests = (): void => {
  activeProvider = null;
};

export type {
  PaymentProvider,
  PaymentInitInput,
  PaymentInitResult,
  PaymentWebhookInput,
  PaymentWebhookResult,
} from './types';
