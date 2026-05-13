import { config } from '@config/index';
import { logger } from '@utils/logger';
import { SmsProvider, SmsResult } from './types';
import { MockSmsProvider } from './providers/mock.provider';
import { TwilioSmsProvider } from './providers/twilio.provider';
import { UnifonicSmsProvider } from './providers/unifonic.provider';
import { VictoryLinkSmsProvider } from './providers/victorylink.provider';
import { MnaswerSmsProvider } from './providers/mnaswer.provider';

const providers: Record<string, SmsProvider> = {
  mock: new MockSmsProvider(),
  twilio: new TwilioSmsProvider(),
  unifonic: new UnifonicSmsProvider(),
  victorylink: new VictoryLinkSmsProvider(),
  mnaswer: new MnaswerSmsProvider(),
};

let activeProvider: SmsProvider | null = null;

export const getSmsProvider = (): SmsProvider => {
  if (activeProvider) return activeProvider;
  const selected = config.smsProvider;
  const provider = providers[selected];
  if (!provider) {
    logger.warn(`SMS provider "${selected}" unknown; falling back to mock`);
    activeProvider = providers.mock;
    return activeProvider;
  }
  if (!provider.isConfigured() && selected !== 'mock') {
    logger.warn(`SMS provider "${selected}" not configured; falling back to mock`);
    activeProvider = providers.mock;
    return activeProvider;
  }
  activeProvider = provider;
  logger.info(`SMS provider selected: ${provider.name}`);
  return activeProvider;
};

/** For testing — reset the cached provider so the next call re-reads config. */
export const __resetSmsProviderForTests = (): void => {
  activeProvider = null;
};

export const sendSms = (phone: string, message: string): Promise<SmsResult> =>
  getSmsProvider().send(phone, message);

export type { SmsResult, SmsProvider } from './types';
