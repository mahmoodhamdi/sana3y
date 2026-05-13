import axios from 'axios';
import { config } from '@config/index';
import { logger } from '@utils/logger';
import { SmsProvider, SmsResult } from '../types';

export class VictoryLinkSmsProvider implements SmsProvider {
  readonly name = 'victorylink';

  isConfigured(): boolean {
    return Boolean(config.victorylink.username && config.victorylink.password);
  }

  async send(phone: string, message: string): Promise<SmsResult> {
    if (!this.isConfigured()) {
      return { success: false, error: 'VictoryLink not configured', provider: this.name };
    }
    try {
      const params = new URLSearchParams({
        UserName: config.victorylink.username,
        Password: config.victorylink.password,
        SMSText: message,
        SMSLang: 'A',
        SMSSender: config.victorylink.senderName,
        SMSReceiver: phone.replace('+', ''),
      });
      const response = await axios.post(
        'https://smsvas.vlserv.com/SMSServices/Clients/Prof/RestSingleSMS_General/SendSMS',
        params.toString(),
        { headers: { 'Content-Type': 'application/x-www-form-urlencoded' } }
      );
      logger.info(`[SMS VictoryLink] sent ${phone}`);
      return { success: true, messageId: String(response.data ?? Date.now()), provider: this.name };
    } catch (error) {
      const msg = error instanceof Error ? error.message : 'VictoryLink error';
      logger.error(`[SMS VictoryLink] failed: ${msg}`);
      return { success: false, error: msg, provider: this.name };
    }
  }
}
