import { Resend } from 'resend';
import { logger } from '@utils/logger';

const resend = new Resend(process.env.RESEND_API_KEY);

interface SendEmailOptions {
  to: string;
  subject: string;
  html: string;
}

interface SendOTPOptions {
  to: string;
  otp: string;
  type: 'verification' | 'reset';
}

class EmailService {
  private from = process.env.RESEND_FROM_EMAIL || 'onboarding@resend.dev';

  async sendEmail({ to, subject, html }: SendEmailOptions) {
    try {
      const response = await resend.emails.send({
        from: `صنايعي <${this.from}>`,
        to,
        subject,
        html,
      });
      logger.info(`Email sent to ${to}:`, response);
      return response;
    } catch (error) {
      logger.error('Email error:', error);
      throw error;
    }
  }

  async sendOTP({ to, otp, type }: SendOTPOptions) {
    const subject = type === 'verification'
      ? 'تفعيل حسابك في صنايعي'
      : 'إعادة تعيين كلمة المرور';

    const title = type === 'verification'
      ? 'مرحباً بك في صنايعي! 👋'
      : 'إعادة تعيين كلمة المرور 🔐';

    const message = type === 'verification'
      ? 'شكراً لتسجيلك في صنايعي. استخدم الكود التالي لتفعيل حسابك:'
      : 'استخدم الكود التالي لإعادة تعيين كلمة المرور:';

    const html = `
      <!DOCTYPE html>
      <html dir="rtl" lang="ar">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          body { font-family: 'Segoe UI', Tahoma, Arial, sans-serif; background: #f5f5f5; padding: 20px; margin: 0; }
          .container { max-width: 500px; margin: 0 auto; background: white; border-radius: 16px; padding: 40px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
          .logo { text-align: center; font-size: 32px; font-weight: bold; color: #2563eb; margin-bottom: 20px; }
          h1 { color: #1f2937; text-align: center; margin-bottom: 10px; font-size: 24px; }
          p { color: #6b7280; text-align: center; line-height: 1.6; margin: 10px 0; }
          .otp-box { background: linear-gradient(135deg, #2563eb, #1d4ed8); color: white; font-size: 36px; font-weight: bold; letter-spacing: 12px; text-align: center; padding: 20px 30px; border-radius: 12px; margin: 30px 0; }
          .footer { text-align: center; color: #9ca3af; font-size: 12px; margin-top: 30px; border-top: 1px solid #e5e7eb; padding-top: 20px; }
          .warning { background: #fef3c7; color: #92400e; padding: 12px; border-radius: 8px; text-align: center; font-size: 14px; margin-top: 20px; }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="logo">🔧 صنايعي</div>
          <h1>${title}</h1>
          <p>${message}</p>
          <div class="otp-box">${otp}</div>
          <div class="warning">
            ⚠️ هذا الكود صالح لمدة 10 دقائق فقط. لا تشاركه مع أي شخص.
          </div>
          <div class="footer">
            <p>إذا لم تطلب هذا الكود، يمكنك تجاهل هذا البريد.</p>
            <p>© 2025 صنايعي - جميع الحقوق محفوظة</p>
          </div>
        </div>
      </body>
      </html>
    `;

    return this.sendEmail({ to, subject, html });
  }

  async sendWelcome(to: string, name: string) {
    const html = `
      <!DOCTYPE html>
      <html dir="rtl" lang="ar">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          body { font-family: 'Segoe UI', Tahoma, Arial, sans-serif; background: #f5f5f5; padding: 20px; margin: 0; }
          .container { max-width: 500px; margin: 0 auto; background: white; border-radius: 16px; padding: 40px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
          .logo { text-align: center; font-size: 32px; font-weight: bold; color: #2563eb; margin-bottom: 20px; }
          h1 { color: #1f2937; text-align: center; font-size: 24px; }
          p { color: #6b7280; text-align: center; line-height: 1.8; }
          .features { background: #f0f9ff; padding: 20px; border-radius: 12px; margin: 20px 0; }
          .feature { display: flex; align-items: center; margin: 10px 0; color: #1f2937; }
          .feature-icon { margin-left: 10px; font-size: 20px; }
          .cta { display: block; background: #2563eb; color: white; text-decoration: none; padding: 15px 30px; border-radius: 8px; text-align: center; margin: 20px auto; font-weight: bold; }
          .footer { text-align: center; color: #9ca3af; font-size: 12px; margin-top: 30px; }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="logo">🔧 صنايعي</div>
          <h1>أهلاً ${name}! 🎉</h1>
          <p>تم تفعيل حسابك بنجاح. يمكنك الآن استخدام التطبيق للعثور على أفضل الصنايعية في منطقتك.</p>

          <div class="features">
            <div class="feature">
              <span class="feature-icon">🔍</span>
              <span>ابحث عن أفضل الصنايعية في منطقتك</span>
            </div>
            <div class="feature">
              <span class="feature-icon">⭐</span>
              <span>اقرأ تقييمات العملاء الحقيقية</span>
            </div>
            <div class="feature">
              <span class="feature-icon">💬</span>
              <span>تواصل مباشرة مع الصنايعي</span>
            </div>
            <div class="feature">
              <span class="feature-icon">🔒</span>
              <span>ضمان جودة الخدمة</span>
            </div>
          </div>

          <p>ابدأ الآن واستمتع بخدماتنا!</p>

          <div class="footer">
            <p>© 2025 صنايعي - جميع الحقوق محفوظة</p>
          </div>
        </div>
      </body>
      </html>
    `;

    return this.sendEmail({
      to,
      subject: 'مرحباً بك في صنايعي! 🎉',
      html,
    });
  }

  async sendPasswordChanged(to: string, name: string) {
    const html = `
      <!DOCTYPE html>
      <html dir="rtl" lang="ar">
      <head>
        <meta charset="UTF-8">
        <style>
          body { font-family: 'Segoe UI', Tahoma, Arial, sans-serif; background: #f5f5f5; padding: 20px; }
          .container { max-width: 500px; margin: 0 auto; background: white; border-radius: 16px; padding: 40px; }
          .logo { text-align: center; font-size: 32px; font-weight: bold; color: #2563eb; margin-bottom: 20px; }
          h1 { color: #1f2937; text-align: center; }
          p { color: #6b7280; text-align: center; line-height: 1.6; }
          .warning { background: #fef2f2; color: #991b1b; padding: 15px; border-radius: 8px; margin: 20px 0; }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="logo">🔧 صنايعي</div>
          <h1>تم تغيير كلمة المرور ✅</h1>
          <p>مرحباً ${name}،</p>
          <p>تم تغيير كلمة مرور حسابك بنجاح.</p>
          <div class="warning">
            ⚠️ إذا لم تقم بهذا التغيير، يرجى التواصل معنا فوراً.
          </div>
        </div>
      </body>
      </html>
    `;

    return this.sendEmail({
      to,
      subject: 'تم تغيير كلمة المرور - صنايعي',
      html,
    });
  }
}

export const emailService = new EmailService();
