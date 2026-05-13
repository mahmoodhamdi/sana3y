import request from 'supertest';
import mongoose from 'mongoose';
import createApp from '../app';
import { MongoMemoryServer } from 'mongodb-memory-server';

let mongoServer: MongoMemoryServer;

beforeAll(async () => {
  mongoServer = await MongoMemoryServer.create();
  await mongoose.connect(mongoServer.getUri());
});

afterAll(async () => {
  await mongoose.disconnect();
  await mongoServer.stop();
});

describe('Health endpoints', () => {
  const app = createApp();

  test('GET /health returns 200', async () => {
    const res = await request(app).get('/health');
    expect(res.status).toBe(200);
    expect(res.body.success).toBe(true);
    expect(res.body.message).toMatch(/running/i);
  });

  test('GET /health/ready returns 200 when DB is connected', async () => {
    const res = await request(app).get('/health/ready');
    expect(res.status).toBe(200);
    expect(res.body.success).toBe(true);
    expect(res.body.checks.database.healthy).toBe(true);
    expect(res.body.checks.database.status).toBe('connected');
    expect(res.body.checks.smsProvider.configured).toBeDefined();
    expect(res.body.checks.paymentProvider.configured).toBeDefined();
  });

  test('GET /health/version returns version info', async () => {
    const res = await request(app).get('/health/version');
    expect(res.status).toBe(200);
    expect(res.body.version).toBeDefined();
    expect(res.body.commit).toBeDefined();
    expect(res.body.node).toMatch(/^v\d+/);
  });
});
