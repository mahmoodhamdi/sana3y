import { getSmsProvider, SmsResult } from '@/lib/sms';

export type { SmsResult } from '@/lib/sms';

export const sendSms = async (phone: string, message: string): Promise<SmsResult> => {
  const formattedPhone = formatEgyptPhone(phone);
  return getSmsProvider().send(formattedPhone, message);
};

export const sendOtpSms = (phone: string, code: string): Promise<SmsResult> =>
  sendSms(phone, `كود التحقق الخاص بك في صنايعي: ${code}\nصالح لمدة 5 دقائق.`);

export const sendWelcomeSms = (phone: string, name: string): Promise<SmsResult> =>
  sendSms(phone, `مرحباً ${name}! تم تسجيلك بنجاح في صنايعي. ابدأ الآن في استكشاف خدماتنا.`);

export const sendPasswordResetSms = (phone: string, code: string): Promise<SmsResult> =>
  sendSms(phone, `كود إعادة تعيين كلمة المرور في صنايعي: ${code}\nصالح لمدة 5 دقائق.`);

export const sendJobNotificationSms = (
  phone: string,
  customerName: string,
  serviceName: string
): Promise<SmsResult> =>
  sendSms(phone, `طلب جديد! ${customerName} يحتاج ${serviceName}. افتح التطبيق للتفاصيل.`);

export const formatEgyptPhone = (phone: string): string => {
  const cleaned = phone.replace(/\D/g, '');
  if (cleaned.startsWith('20')) return `+${cleaned}`;
  if (cleaned.startsWith('0')) return `+20${cleaned.slice(1)}`;
  if (cleaned.length === 10) return `+20${cleaned}`;
  return phone;
};

export const isValidEgyptPhone = (phone: string): boolean => {
  const formatted = formatEgyptPhone(phone);
  return /^\+20(10|11|12|15)[0-9]{8}$/.test(formatted);
};
