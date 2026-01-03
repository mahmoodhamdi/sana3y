import rateLimit, { Options } from 'express-rate-limit';
import { config } from '@config/index';

interface RateLimiterOptions {
  windowMs?: number;
  max?: number;
  message?: string;
  skipSuccessfulRequests?: boolean;
  skipFailedRequests?: boolean;
}

/**
 * Create a rate limiter with custom options
 */
export const rateLimiter = (options: RateLimiterOptions = {}) => {
  const rateLimitOptions: Partial<Options> = {
    windowMs: options.windowMs || config.rateLimit.windowMs,
    max: options.max || config.rateLimit.maxRequests,
    message: {
      success: false,
      message: options.message || 'تم تجاوز الحد المسموح من الطلبات. حاول مرة أخرى لاحقاً',
    },
    standardHeaders: true,
    legacyHeaders: false,
    skipSuccessfulRequests: options.skipSuccessfulRequests || false,
    skipFailedRequests: options.skipFailedRequests || false,
  };

  return rateLimit(rateLimitOptions);
};

/**
 * Global rate limiter for all routes
 */
export const globalRateLimiter = rateLimiter({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // 100 requests per 15 minutes
});

/**
 * Strict rate limiter for sensitive operations
 */
export const strictRateLimiter = rateLimiter({
  windowMs: 60 * 60 * 1000, // 1 hour
  max: 5, // 5 requests per hour
  message: 'تم تجاوز الحد المسموح. حاول مرة أخرى بعد ساعة',
});

/**
 * OTP rate limiter
 */
export const otpRateLimiter = rateLimiter({
  windowMs: 60 * 1000, // 1 minute
  max: 3, // 3 OTP requests per minute
  message: 'تم تجاوز الحد المسموح لإرسال الكود. انتظر دقيقة',
});

/**
 * Auth rate limiter for login/register
 */
export const authRateLimiter = rateLimiter({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 10, // 10 auth attempts per 15 minutes
  skipSuccessfulRequests: true, // Only count failed attempts
  message: 'تم تجاوز عدد محاولات تسجيل الدخول. حاول مرة أخرى لاحقاً',
});

/**
 * Upload rate limiter
 */
export const uploadRateLimiter = rateLimiter({
  windowMs: 60 * 60 * 1000, // 1 hour
  max: 20, // 20 uploads per hour
  message: 'تم تجاوز الحد المسموح للرفع. حاول مرة أخرى لاحقاً',
});
