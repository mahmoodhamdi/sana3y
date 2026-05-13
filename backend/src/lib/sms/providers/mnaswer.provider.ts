import axios from 'axios';
import { config } from '@config/index';
import { logger } from '@utils/logger';
import { SmsProvider, SmsResult } from '../types';

export class MnaswerSmsProvider implements SmsProvider {
  readonly name = 'mnaswer';

  isConfigured(): boolean {
    return Boolean(config.mnaswer.apiKey);
  }

  async send(phone: string, message: string): Promise<SmsResult> {
    if (!this.isConfigured()) {
      return { success: false, error: 'Mnaswer not configured', provider: this.name };
    }
    try {
      const response = await axios.post(
        'https://www.mnaswer.com/api/Sms/SendSms',
        {
          ApiKey: config.mnaswer.apiKey,
          Sender: config.mnaswer.senderName,
          Numbers: phone.replace('+', ''),
          Message: message,
        },
        { headers: { 'Content-Type': 'application/json' } }
      );
      logger.info(`[SMS Mnaswer] sent ${phone}`);
      return {
        success: true,
        messageId: String(response.data?.id ?? Date.now()),
        provider: this.name,
      };
    } catch (error) {
      const msg = error instanceof Error ? error.message : 'Mnaswer error';
      logger.error(`[SMS Mnaswer] failed: ${msg}`);
      return { success: false, error: msg, provider: this.name };
    }
  }
}
