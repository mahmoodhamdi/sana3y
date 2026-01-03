import crypto from 'crypto';

// OTP defaults
const DEFAULTS = {
  OTP_LENGTH: 6,
  OTP_EXPIRATION_MINUTES: 5,
} as const;

export interface OtpResult {
  code: string;
  hash: string;
  expiresAt: Date;
}

/**
 * Generate a random OTP code
 */
export const generateOtpCode = (length: number = DEFAULTS.OTP_LENGTH): string => {
  const digits = '0123456789';
  let code = '';

  for (let i = 0; i < length; i++) {
    const randomIndex = crypto.randomInt(0, digits.length);
    code += digits[randomIndex];
  }

  return code;
};

/**
 * Hash an OTP code for secure storage
 */
export const hashOtp = (code: string, phone: string): string => {
  return crypto
    .createHmac('sha256', process.env.OTP_SECRET || 'otp-secret-key')
    .update(`${phone}:${code}`)
    .digest('hex');
};

/**
 * Generate OTP with hash and expiration
 */
export const generateOtp = (phone: string): OtpResult => {
  const code = generateOtpCode();
  const hash = hashOtp(code, phone);
  const expiresAt = new Date(Date.now() + DEFAULTS.OTP_EXPIRATION_MINUTES * 60 * 1000);

  return { code, hash, expiresAt };
};

/**
 * Verify an OTP code against its hash
 */
export const verifyOtpHash = (code: string, phone: string, hash: string): boolean => {
  const expectedHash = hashOtp(code, phone);
  return crypto.timingSafeEqual(
    Buffer.from(expectedHash),
    Buffer.from(hash)
  );
};

/**
 * Check if OTP is expired
 */
export const isOtpExpired = (expiresAt: Date): boolean => {
  return new Date() > new Date(expiresAt);
};

/**
 * Generate a development/test OTP (always 123456)
 */
export const generateDevOtp = (phone: string): OtpResult => {
  const code = '123456';
  const hash = hashOtp(code, phone);
  const expiresAt = new Date(Date.now() + DEFAULTS.OTP_EXPIRATION_MINUTES * 60 * 1000);

  return { code, hash, expiresAt };
};
