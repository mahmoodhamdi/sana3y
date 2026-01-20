import { MongoMemoryServer } from 'mongodb-memory-server';
import mongoose from 'mongoose';
import jwt from 'jsonwebtoken';
import { Types } from 'mongoose';

let mongoServer: MongoMemoryServer;

// Test user data factory
export const createTestUser = (overrides = {}) => ({
  _id: new Types.ObjectId(),
  name: 'Test User',
  email: 'test@example.com',
  role: 'customer' as const,
  isActive: true,
  isVerified: true,
  ...overrides,
});

export const createTestAdmin = (overrides = {}) =>
  createTestUser({ role: 'admin', ...overrides });

export const createTestCraftsman = (overrides = {}) =>
  createTestUser({ role: 'craftsman', ...overrides });

// Generate test JWT token
export const generateTestToken = (user: ReturnType<typeof createTestUser>) => {
  const secret = process.env.JWT_SECRET || 'test-secret-key-for-testing';
  return jwt.sign(
    {
      userId: user._id.toString(),
      role: user.role,
    },
    secret,
    { expiresIn: '1h' }
  );
};

// Database setup for tests
export const setupTestDB = async () => {
  mongoServer = await MongoMemoryServer.create();
  const mongoUri = mongoServer.getUri();
  await mongoose.connect(mongoUri);
};

export const teardownTestDB = async () => {
  if (mongoose.connection.readyState !== 0) {
    await mongoose.disconnect();
  }
  if (mongoServer) {
    await mongoServer.stop();
  }
};

export const clearTestDB = async () => {
  const collections = mongoose.connection.collections;
  for (const key in collections) {
    await collections[key].deleteMany({});
  }
};

// Global setup for jest
beforeAll(async () => {
  // Set test environment variables
  process.env.NODE_ENV = 'test';
  process.env.JWT_SECRET = 'test-secret-key-for-testing';
  process.env.JWT_REFRESH_SECRET = 'test-refresh-secret-for-testing';
  process.env.OTP_SECRET = 'test-otp-secret-for-testing';
});

afterAll(async () => {
  await teardownTestDB();
});
