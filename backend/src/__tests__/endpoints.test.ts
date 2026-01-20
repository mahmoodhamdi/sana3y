/**
 * API Endpoints Existence Tests
 * Tests that all expected endpoints exist and respond correctly
 */

import request from 'supertest';
import express, { Express, Request, Response, NextFunction } from 'express';
import mongoose, { Types } from 'mongoose';
import { MongoMemoryServer } from 'mongodb-memory-server';
import jwt from 'jsonwebtoken';

// Routes
import routes from '@routes/index';

let app: Express;
let mongoServer: MongoMemoryServer;
let adminToken: string;
let customerToken: string;
let craftsmanToken: string;

const JWT_SECRET = 'test-secret-key-for-testing';

// Create test users
const createTokens = () => {
  const adminId = new Types.ObjectId();
  const customerId = new Types.ObjectId();
  const craftsmanId = new Types.ObjectId();

  adminToken = jwt.sign({ userId: adminId.toString(), role: 'admin' }, JWT_SECRET, { expiresIn: '1h' });
  customerToken = jwt.sign({ userId: customerId.toString(), role: 'customer' }, JWT_SECRET, { expiresIn: '1h' });
  craftsmanToken = jwt.sign({ userId: craftsmanId.toString(), role: 'craftsman' }, JWT_SECRET, { expiresIn: '1h' });
};

// Setup express app with minimal middleware
const setupApp = () => {
  const testApp = express();
  testApp.use(express.json());

  // Mock authenticate middleware
  testApp.use((req: any, _res: Response, next: NextFunction) => {
    const authHeader = req.headers.authorization;
    if (authHeader && authHeader.startsWith('Bearer ')) {
      const token = authHeader.substring(7);
      try {
        const decoded = jwt.verify(token, JWT_SECRET) as any;
        req.user = {
          _id: new Types.ObjectId(decoded.userId),
          role: decoded.role,
        };
      } catch (e) {
        // Invalid token
      }
    }
    next();
  });

  testApp.use(routes);

  // Error handler
  testApp.use((err: any, _req: Request, res: Response, _next: NextFunction) => {
    res.status(err.statusCode || 500).json({
      success: false,
      message: err.message || 'Internal Server Error',
    });
  });

  return testApp;
};

describe('API Endpoints Existence', () => {
  beforeAll(async () => {
    mongoServer = await MongoMemoryServer.create();
    const mongoUri = mongoServer.getUri();
    await mongoose.connect(mongoUri);

    app = setupApp();
    createTokens();
  });

  afterAll(async () => {
    await mongoose.disconnect();
    await mongoServer.stop();
  });

  describe('Health & Info Endpoints', () => {
    it('GET /health should return health status', async () => {
      const res = await request(app).get('/health');
      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
    });

    it('GET /api/v1 should return API info', async () => {
      const res = await request(app).get('/api/v1');
      expect(res.status).toBe(200);
      expect(res.body.endpoints).toBeDefined();
    });
  });

  describe('Auth Endpoints', () => {
    const authEndpoints = [
      { method: 'post', path: '/api/v1/auth/send-verification-otp', body: { email: 'test@test.com' } },
      { method: 'post', path: '/api/v1/auth/verify-otp', body: { email: 'test@test.com', code: '123456' } },
      { method: 'post', path: '/api/v1/auth/register', body: { name: 'Test', email: 'test@test.com', password: 'pass123' } },
      { method: 'post', path: '/api/v1/auth/login', body: { email: 'test@test.com', password: 'pass123' } },
      { method: 'post', path: '/api/v1/auth/refresh', body: { refreshToken: 'token' } },
      { method: 'get', path: '/api/v1/auth/me', auth: 'customer' },
      { method: 'put', path: '/api/v1/auth/me', auth: 'customer', body: { name: 'New Name' } },
    ];

    authEndpoints.forEach(({ method, path, auth, body }) => {
      it(`${method.toUpperCase()} ${path} should respond`, async () => {
        let req = (request(app) as any)[method](path);

        if (auth === 'customer') {
          req = req.set('Authorization', `Bearer ${customerToken}`);
        } else if (auth === 'admin') {
          req = req.set('Authorization', `Bearer ${adminToken}`);
        }

        if (body) {
          req = req.send(body);
        }

        const res = await req;
        // Should not return 404 (route not found)
        expect(res.status).not.toBe(404);
      });
    });
  });

  describe('Categories Endpoints', () => {
    it('GET /api/v1/categories should respond', async () => {
      const res = await request(app).get('/api/v1/categories');
      expect(res.status).not.toBe(404);
    });
  });

  describe('Craftsmen Endpoints', () => {
    const craftsmenEndpoints = [
      { method: 'get', path: '/api/v1/craftsmen/public' },
      { method: 'get', path: '/api/v1/craftsmen/featured' },
      { method: 'get', path: '/api/v1/craftsmen/nearby', query: { lat: 30.4522, lng: 30.9667 } },
      { method: 'get', path: '/api/v1/craftsmen/me', auth: 'craftsman' },
      { method: 'post', path: '/api/v1/craftsmen/profile', auth: 'craftsman', body: {} },
      { method: 'put', path: '/api/v1/craftsmen/profile', auth: 'craftsman', body: {} },
      { method: 'put', path: '/api/v1/craftsmen/online', auth: 'craftsman', body: { isOnline: true } },
      { method: 'put', path: '/api/v1/craftsmen/availability', auth: 'craftsman', body: { isAvailable: true } },
      { method: 'get', path: '/api/v1/craftsmen/earnings', auth: 'craftsman' },
    ];

    craftsmenEndpoints.forEach(({ method, path, auth, body, query }) => {
      it(`${method.toUpperCase()} ${path} should respond`, async () => {
        let req = (request(app) as any)[method](path);

        if (auth === 'craftsman') {
          req = req.set('Authorization', `Bearer ${craftsmanToken}`);
        }

        if (query) {
          req = req.query(query);
        }

        if (body) {
          req = req.send(body);
        }

        const res = await req;
        expect(res.status).not.toBe(404);
      });
    });
  });

  describe('Requests Endpoints', () => {
    const requestEndpoints = [
      { method: 'get', path: '/api/v1/requests/statuses' },
      { method: 'get', path: '/api/v1/requests/my', auth: 'customer' },
      { method: 'get', path: '/api/v1/requests/available', auth: 'craftsman' },
      { method: 'get', path: '/api/v1/requests/my-jobs/active', auth: 'craftsman' },
      { method: 'get', path: '/api/v1/requests/my-jobs/completed', auth: 'craftsman' },
    ];

    requestEndpoints.forEach(({ method, path, auth }) => {
      it(`${method.toUpperCase()} ${path} should respond`, async () => {
        let req = (request(app) as any)[method](path);

        if (auth === 'customer') {
          req = req.set('Authorization', `Bearer ${customerToken}`);
        } else if (auth === 'craftsman') {
          req = req.set('Authorization', `Bearer ${craftsmanToken}`);
        }

        const res = await req;
        expect(res.status).not.toBe(404);
      });
    });
  });

  describe('Chat Endpoints', () => {
    const chatEndpoints = [
      { method: 'get', path: '/api/v1/chat/conversations', auth: 'customer' },
      { method: 'get', path: '/api/v1/chat/unread-count', auth: 'customer' },
    ];

    chatEndpoints.forEach(({ method, path, auth }) => {
      it(`${method.toUpperCase()} ${path} should respond`, async () => {
        let req = (request(app) as any)[method](path);

        if (auth === 'customer') {
          req = req.set('Authorization', `Bearer ${customerToken}`);
        }

        const res = await req;
        expect(res.status).not.toBe(404);
      });
    });
  });

  describe('Notifications Endpoints', () => {
    const notificationEndpoints = [
      { method: 'get', path: '/api/v1/notifications', auth: 'customer' },
      { method: 'get', path: '/api/v1/notifications/unread-count', auth: 'customer' },
      { method: 'put', path: '/api/v1/notifications/read-all', auth: 'customer' },
    ];

    notificationEndpoints.forEach(({ method, path, auth }) => {
      it(`${method.toUpperCase()} ${path} should respond`, async () => {
        let req = (request(app) as any)[method](path);

        if (auth === 'customer') {
          req = req.set('Authorization', `Bearer ${customerToken}`);
        }

        const res = await req;
        expect(res.status).not.toBe(404);
      });
    });
  });

  describe('Customer Endpoints', () => {
    const customerEndpoints = [
      { method: 'get', path: '/api/v1/customers/me', auth: 'customer' },
      { method: 'get', path: '/api/v1/customers/addresses', auth: 'customer' },
      { method: 'post', path: '/api/v1/customers/addresses', auth: 'customer', body: {} },
      { method: 'get', path: '/api/v1/customers/favorites', auth: 'customer' },
    ];

    customerEndpoints.forEach(({ method, path, auth, body }) => {
      it(`${method.toUpperCase()} ${path} should respond`, async () => {
        let req = (request(app) as any)[method](path);

        if (auth === 'customer') {
          req = req.set('Authorization', `Bearer ${customerToken}`);
        }

        if (body) {
          req = req.send(body);
        }

        const res = await req;
        expect(res.status).not.toBe(404);
      });
    });
  });

  describe('Admin Endpoints', () => {
    const adminEndpoints = [
      { method: 'get', path: '/api/v1/admin/dashboard' },
      { method: 'get', path: '/api/v1/admin/customers' },
      { method: 'get', path: '/api/v1/admin/craftsmen' },
      { method: 'get', path: '/api/v1/admin/craftsmen/pending' },
      { method: 'get', path: '/api/v1/admin/requests' },
      { method: 'get', path: '/api/v1/admin/transactions' },
      { method: 'get', path: '/api/v1/admin/transactions/stats' },
      { method: 'get', path: '/api/v1/admin/zones' },
      { method: 'post', path: '/api/v1/admin/zones', body: {} },
      { method: 'get', path: '/api/v1/admin/settings' },
      { method: 'put', path: '/api/v1/admin/settings', body: {} },
      { method: 'get', path: '/api/v1/admin/notifications' },
      { method: 'post', path: '/api/v1/admin/notifications', body: {} },
    ];

    adminEndpoints.forEach(({ method, path, body }) => {
      it(`${method.toUpperCase()} ${path} should respond`, async () => {
        let req = (request(app) as any)[method](path);
        req = req.set('Authorization', `Bearer ${adminToken}`);

        if (body) {
          req = req.send(body);
        }

        const res = await req;
        expect(res.status).not.toBe(404);
      });
    });
  });

  describe('Upload Endpoints', () => {
    it('POST /api/v1/upload should respond', async () => {
      const res = await request(app)
        .post('/api/v1/upload')
        .set('Authorization', `Bearer ${customerToken}`);

      expect(res.status).not.toBe(404);
    });
  });

  describe('Payments Endpoints', () => {
    it('POST /api/v1/payments/initialize should respond', async () => {
      const res = await request(app)
        .post('/api/v1/payments/initialize')
        .set('Authorization', `Bearer ${customerToken}`)
        .send({ requestId: 'test', amount: 100 });

      expect(res.status).not.toBe(404);
    });

    it('POST /api/v1/payments/webhook should respond', async () => {
      const res = await request(app)
        .post('/api/v1/payments/webhook')
        .send({});

      expect(res.status).not.toBe(404);
    });
  });

  describe('Reviews Endpoints', () => {
    it('GET /api/v1/reviews should respond', async () => {
      const res = await request(app).get('/api/v1/reviews');
      expect(res.status).not.toBe(404);
    });
  });
});

describe('Endpoint Response Format', () => {
  beforeAll(async () => {
    mongoServer = await MongoMemoryServer.create();
    const mongoUri = mongoServer.getUri();
    await mongoose.connect(mongoUri);

    app = setupApp();
    createTokens();
  });

  afterAll(async () => {
    await mongoose.disconnect();
    await mongoServer.stop();
  });

  it('should return consistent success response format', async () => {
    const res = await request(app).get('/health');

    expect(res.body).toHaveProperty('success');
    expect(typeof res.body.success).toBe('boolean');
  });

  it('should return proper error format for validation errors', async () => {
    const res = await request(app)
      .post('/api/v1/auth/register')
      .send({});

    expect(res.body).toHaveProperty('success');
    expect(res.body.success).toBe(false);
  });

  it('should return 401 for protected routes without token', async () => {
    const res = await request(app).get('/api/v1/auth/me');

    expect(res.status).toBe(401);
  });
});
