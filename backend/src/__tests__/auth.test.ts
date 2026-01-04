import jwt from 'jsonwebtoken';
import { generateOtpCode, hashOtp, verifyOtpHash, isOtpExpired, generateOtp } from '../utils/otp';

// Mock environment variables
const TEST_JWT_SECRET = 'test-secret-key';
const TEST_REFRESH_SECRET = 'test-refresh-secret';
const TEST_OTP_SECRET = 'test-otp-secret';

process.env.JWT_SECRET = TEST_JWT_SECRET;
process.env.JWT_REFRESH_SECRET = TEST_REFRESH_SECRET;
process.env.OTP_SECRET = TEST_OTP_SECRET;

interface DecodedToken {
  userId: string;
  role: string;
  iat: number;
  exp: number;
}

describe('OTP Utils', () => {
  const testPhone = '+201012345678';

  test('should generate 6-digit OTP code', () => {
    const code = generateOtpCode();
    expect(code).toBeDefined();
    expect(code.length).toBe(6);
    expect(/^\d{6}$/.test(code)).toBe(true);
  });

  test('should generate OTP of specified length', () => {
    const code = generateOtpCode(4);
    expect(code.length).toBe(4);
    expect(/^\d{4}$/.test(code)).toBe(true);
  });

  test('should generate unique OTPs', () => {
    const otps = new Set();
    for (let i = 0; i < 100; i++) {
      otps.add(generateOtpCode());
    }
    // Most should be unique (statistically)
    expect(otps.size).toBeGreaterThan(90);
  });

  test('should hash OTP correctly', () => {
    const code = '123456';
    const hash = hashOtp(code, testPhone);
    expect(hash).toBeDefined();
    expect(hash.length).toBe(64); // SHA-256 produces 64 hex characters
  });

  test('should verify correct OTP hash', () => {
    const code = '123456';
    const hash = hashOtp(code, testPhone);
    const isValid = verifyOtpHash(code, testPhone, hash);
    expect(isValid).toBe(true);
  });

  test('should reject incorrect OTP', () => {
    const code = '123456';
    const hash = hashOtp(code, testPhone);
    const isValid = verifyOtpHash('654321', testPhone, hash);
    expect(isValid).toBe(false);
  });

  test('should generate complete OTP result', () => {
    const result = generateOtp(testPhone);
    expect(result.code).toBeDefined();
    expect(result.hash).toBeDefined();
    expect(result.expiresAt).toBeInstanceOf(Date);
    expect(result.expiresAt.getTime()).toBeGreaterThan(Date.now());
  });

  test('should detect expired OTP', () => {
    const pastDate = new Date(Date.now() - 10000);
    expect(isOtpExpired(pastDate)).toBe(true);
  });

  test('should not mark future OTP as expired', () => {
    const futureDate = new Date(Date.now() + 60000);
    expect(isOtpExpired(futureDate)).toBe(false);
  });
});

describe('JWT Token Generation', () => {
  const mockPayload = {
    userId: 'test-user-id',
    role: 'customer',
  };

  test('should generate valid access token', () => {
    const token = jwt.sign(mockPayload, TEST_JWT_SECRET, {
      expiresIn: '1h',
    });
    expect(token).toBeDefined();
    expect(token.split('.').length).toBe(3);
  });

  test('should decode token correctly', () => {
    const token = jwt.sign(mockPayload, TEST_JWT_SECRET, {
      expiresIn: '1h',
    });
    const decoded = jwt.verify(token, TEST_JWT_SECRET) as DecodedToken;
    expect(decoded.userId).toBe(mockPayload.userId);
    expect(decoded.role).toBe(mockPayload.role);
  });

  test('should reject invalid token', () => {
    expect(() => {
      jwt.verify('invalid-token', TEST_JWT_SECRET);
    }).toThrow();
  });

  test('should reject token with wrong secret', () => {
    const token = jwt.sign(mockPayload, TEST_JWT_SECRET, {
      expiresIn: '1h',
    });
    expect(() => {
      jwt.verify(token, 'wrong-secret');
    }).toThrow();
  });
});

describe('Phone Number Validation', () => {
  const EGYPT_PHONE_REGEX = /^\+20(10|11|12|15)\d{8}$/;

  test('should validate correct Egyptian phone numbers', () => {
    const validPhones = [
      '+201012345678',
      '+201112345678',
      '+201212345678',
      '+201512345678',
    ];

    validPhones.forEach((phone) => {
      expect(EGYPT_PHONE_REGEX.test(phone)).toBe(true);
    });
  });

  test('should reject invalid phone numbers', () => {
    const invalidPhones = [
      '01012345678', // Missing +20
      '+20101234567', // Too short
      '+2010123456789', // Too long
      '+201312345678', // Invalid prefix (13)
      '+201412345678', // Invalid prefix (14)
      '+1234567890', // Not Egyptian
    ];

    invalidPhones.forEach((phone) => {
      expect(EGYPT_PHONE_REGEX.test(phone)).toBe(false);
    });
  });
});

describe('Request Status Flow', () => {
  const validStatuses = [
    'pending',
    'quoted',
    'accepted',
    'in_progress',
    'completed',
    'cancelled',
    'disputed',
  ];

  const statusTransitions: Record<string, string[]> = {
    pending: ['quoted', 'cancelled'],
    quoted: ['accepted', 'cancelled', 'quoted'], // Can receive more quotes
    accepted: ['in_progress', 'cancelled'],
    in_progress: ['completed', 'disputed'],
    completed: [],
    cancelled: [],
    disputed: ['completed', 'cancelled'],
  };

  test('should have all statuses defined', () => {
    validStatuses.forEach((status) => {
      expect(statusTransitions[status]).toBeDefined();
    });
  });

  test('completed and cancelled should be terminal states', () => {
    expect(statusTransitions.completed.length).toBe(0);
    expect(statusTransitions.cancelled.length).toBe(0);
  });

  test('pending should transition to quoted or cancelled', () => {
    expect(statusTransitions.pending).toContain('quoted');
    expect(statusTransitions.pending).toContain('cancelled');
  });
});
