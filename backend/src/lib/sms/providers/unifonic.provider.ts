import axios from 'axios';
import { config } from '@config/index';
import { logger } from '@utils/logger';
import { SmsProvider, SmsResult } from '../types';

export class UnifonicSmsProvider implements SmsProvider {
  readonly name = 'unifonic';

  isConfigured(): boolean {
    return Boolean(config.unifonic.appSid);
  }

  async send(phone: string, message: string): Promise<SmsResult> {
    if (!this.isConfigured()) {
      return { success: false, error: 'Unifonic not configured', provider: this.name };
    }
    try {
      const response = await axios.post(
        'https://el.cloud.unifonic.com/rest/SMS/messages',
        {
          AppSid: config.unifonic.appSid,
          SenderID: config.unifonic.senderId || 'Sana3y',
          Recipient: phone.replace('+', ''),
          Body: message,
        },
        { headers: { 'Content-Type': 'application/json' } }
      );
      if (response.data?.success) {
        const messageId = response.data?.data?.MessageID;
        logger.info(`[SMS Unifonic] sent ${phone} id=${messageId}`);
        return { success: true, messageId, provider: this.name };
      }
      throw new Error(response.data?.message || 'Unifonic API error');
    } catch (error) {
      const msg = error instanceof Error ? error.message : 'Unifonic error';
      logger.error(`[SMS Unifonic] failed: ${msg}`);
      return { success: false, error: msg, provider: this.name };
    }
  }
}
