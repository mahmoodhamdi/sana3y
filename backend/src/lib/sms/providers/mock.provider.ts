import { logger } from '@utils/logger';
import { SmsProvider, SmsResult } from '../types';

export class MockSmsProvider implements SmsProvider {
  readonly name = 'mock';

  async send(phone: string, message: string): Promise<SmsResult> {
    logger.info(`[SMS MOCK] To: ${phone}`);
    logger.info(`[SMS MOCK] Message: ${message}`);
    return { success: true, messageId: `mock-${Date.now()}`, provider: this.name };
  }

  isConfigured(): boolean {
    return true;
  }
}
