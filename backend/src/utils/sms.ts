import { config } from '@config/index';
import { logger } from '@utils/logger';
import axios from 'axios';

export interface SmsResult {
  success: boolean;
  messageId?: string;
  error?: string;
}

/**
 * Send SMS via configured provider
 * Supports: Twilio, Unifonic (Egypt), or console logging in development
 */
export const sendSms = async (phone: string, message: string): Promise<SmsResult> => {
  try {
    const formattedPhone = formatEgyptPhone(phone);

    // In development, just log the SMS
    if (config.env === 'development') {
      logger.info(`[SMS DEV] To: ${formattedPhone}`);
      logger.info(`[SMS DEV] Message: ${message}`);
      return { success: true, messageId: `dev-${Date.now()}` };
    }

    // Check for Twilio configuration
    if (config.twilio?.accountSid && config.twilio?.authToken) {
      return sendViaTwilio(formattedPhone, message);
    }

    // Check for Unifonic configuration (Egyptian SMS Gateway)
    if (config.unifonic?.appSid) {
      return sendViaUnifonic(formattedPhone, message);
    }

    // Fallback: log warning and return success for graceful degradation
    logger.warn(`SMS provider not configured. Message to ${formattedPhone} not sent.`);
    return { success: true, messageId: `mock-${Date.now()}` };
  } catch (error) {
    const errorMessage = error instanceof Error ? error.message : 'Unknown error';
    logger.error(`SMS sending failed: ${errorMessage}`);
    return { success: false, error: errorMessage };
  }
};

/**
 * Send SMS via Twilio
 */
const sendViaTwilio = async (phone: string, message: string): Promise<SmsResult> => {
  try {
    const { accountSid, authToken, phoneNumber } = config.twilio!;
    const url = `https://api.twilio.com/2010-04-01/Accounts/${accountSid}/Messages.json`;

    const response = await axios.post(
      url,
      new URLSearchParams({
        To: phone,
        From: phoneNumber!,
        Body: message,
      }),
      {
        auth: { username: accountSid!, password: authToken! },
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      }
    );

    logger.info(`[SMS Twilio] Sent to ${phone}, SID: ${response.data.sid}`);
    return { success: true, messageId: response.data.sid };
  } catch (error) {
    const errorMessage = error instanceof Error ? error.message : 'Twilio error';
    logger.error(`[SMS Twilio] Failed: ${errorMessage}`);
    return { success: false, error: errorMessage };
  }
};

/**
 * Send SMS via Unifonic (Egyptian SMS Gateway)
 */
const sendViaUnifonic = async (phone: string, message: string): Promise<SmsResult> => {
  try {
    const { appSid, senderId } = config.unifonic!;
    const url = 'https://el.cloud.unifonic.com/rest/SMS/messages';

    const response = await axios.post(
      url,
      {
        AppSid: appSid,
        SenderID: senderId || 'Sana3y',
        Recipient: phone.replace('+', ''),
        Body: message,
      },
      {
        headers: { 'Content-Type': 'application/json' },
      }
    );

    if (response.data.success) {
      logger.info(`[SMS Unifonic] Sent to ${phone}, ID: ${response.data.data?.MessageID}`);
      return { success: true, messageId: response.data.data?.MessageID };
    }

    throw new Error(response.data.message || 'Unifonic API error');
  } catch (error) {
    const errorMessage = error instanceof Error ? error.message : 'Unifonic error';
    logger.error(`[SMS Unifonic] Failed: ${errorMessage}`);
    return { success: false, error: errorMessage };
  }
};

/**
 * Send OTP SMS
 */
export const sendOtpSms = async (phone: string, code: string): Promise<SmsResult> => {
  const message = `كود التحقق الخاص بك في صنايعي: ${code}\nصالح لمدة 5 دقائق.`;
  return sendSms(phone, message);
};

/**
 * Send welcome SMS
 */
export const sendWelcomeSms = async (phone: string, name: string): Promise<SmsResult> => {
  const message = `مرحباً ${name}! تم تسجيلك بنجاح في صنايعي. ابدأ الآن في استكشاف خدماتنا.`;
  return sendSms(phone, message);
};

/**
 * Send password reset SMS
 */
export const sendPasswordResetSms = async (phone: string, code: string): Promise<SmsResult> => {
  const message = `كود إعادة تعيين كلمة المرور في صنايعي: ${code}\nصالح لمدة 5 دقائق.`;
  return sendSms(phone, message);
};

/**
 * Send job notification SMS
 */
export const sendJobNotificationSms = async (
  phone: string,
  customerName: string,
  serviceName: string
): Promise<SmsResult> => {
  const message = `طلب جديد! ${customerName} يحتاج ${serviceName}. افتح التطبيق للتفاصيل.`;
  return sendSms(phone, message);
};

/**
 * Format Egyptian phone number
 */
export const formatEgyptPhone = (phone: string): string => {
  // Remove all non-digits
  const cleaned = phone.replace(/\D/g, '');

  // Handle different formats
  if (cleaned.startsWith('20')) {
    return `+${cleaned}`;
  } else if (cleaned.startsWith('0')) {
    return `+20${cleaned.slice(1)}`;
  } else if (cleaned.length === 10) {
    return `+20${cleaned}`;
  }

  return phone;
};

/**
 * Validate Egyptian phone number
 */
export const isValidEgyptPhone = (phone: string): boolean => {
  const formatted = formatEgyptPhone(phone);
  // Egyptian mobile: +20 followed by 10 digits starting with 1
  const regex = /^\+20(10|11|12|15)[0-9]{8}$/;
  return regex.test(formatted);
};
