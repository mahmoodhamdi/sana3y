import axios from 'axios';
import { config } from '@config/index';
import { logger } from '@utils/logger';
import { SmsProvider, SmsResult } from '../types';

export class TwilioSmsProvider implements SmsProvider {
  readonly name = 'twilio';

  isConfigured(): boolean {
    return Boolean(config.twilio.accountSid && config.twilio.authToken && config.twilio.phoneNumber);
  }

  async send(phone: string, message: string): Promise<SmsResult> {
    if (!this.isConfigured()) {
      return { success: false, error: 'Twilio not configured', provider: this.name };
    }
    try {
      const { accountSid, authToken, phoneNumber } = config.twilio;
      const url = `https://api.twilio.com/2010-04-01/Accounts/${accountSid}/Messages.json`;
      const response = await axios.post(
        url,
        new URLSearchParams({ To: phone, From: phoneNumber, Body: message }),
        {
          auth: { username: accountSid, password: authToken },
          headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        }
      );
      logger.info(`[SMS Twilio] sent ${phone} sid=${response.data.sid}`);
      return { success: true, messageId: response.data.sid, provider: this.name };
    } catch (error) {
      const msg = error instanceof Error ? error.message : 'Twilio error';
      logger.error(`[SMS Twilio] failed: ${msg}`);
      return { success: false, error: msg, provider: this.name };
    }
  }
}
