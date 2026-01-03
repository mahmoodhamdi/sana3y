import { config } from '@config/index';
import { logger } from '@utils/logger';

export interface SmsResult {
  success: boolean;
  messageId?: string;
  error?: string;
}

/**
 * Send SMS via configured provider
 * Currently uses console logging in development
 * In production, integrate with Twilio, Firebase, or local SMS gateway
 */
export const sendSms = async (phone: string, message: string): Promise<SmsResult> => {
  try {
    // In development, just log the SMS
    if (config.env === 'development') {
      logger.info(`[SMS DEV] To: ${phone}`);
      logger.info(`[SMS DEV] Message: ${message}`);
      return { success: true, messageId: `dev-${Date.now()}` };
    }

    // TODO: Implement actual SMS sending
    // Options:
    // 1. Twilio
    // 2. Firebase Phone Auth
    // 3. Local Egyptian SMS Gateway (e.g., VictoryLink, Unifonic)

    logger.warn('SMS provider not configured. Message not sent.');
    return { success: true, messageId: `mock-${Date.now()}` };
  } catch (error) {
    const errorMessage = error instanceof Error ? error.message : 'Unknown error';
    logger.error(`SMS sending failed: ${errorMessage}`);
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
