import request from 'supertest';
import express, { Express, Request, Response, NextFunction } from 'express';
import mongoose, { Types } from 'mongoose';
import { MongoMemoryServer } from 'mongodb-memory-server';
import { generateAccessToken } from '@utils/jwt';

// Mock models
import User from '@models/User';
import Customer from '@models/Customer';
import Craftsman from '@models/Craftsman';
import ServiceRequest from '@models/ServiceRequest';
import ServiceCategory from '@models/ServiceCategory';
import Zone from '@models/Zone';
import Setting from '@models/Setting';
import Notification from '@models/Notification';

// Controllers
import {
  getDashboardStats,
  getCustomers,
  getCraftsmenAdmin,
  getPendingCraftsmenAdmin,
  updateCraftsmanStatusAdmin,
  approveCraftsman,
  getZones,
  createZone,
  updateZone,
  deleteZone,
  getSettings,
  updateSettings,
  sendBroadcastNotification,
} from '@controllers/admin.controller';

let app: Express;
let mongoServer: MongoMemoryServer;
let adminToken: string;
let adminUser: any;
let testCategory: any;

// Setup express app for testing
const setupApp = () => {
  const testApp = express();
  testApp.use(express.json());

  // Mock admin auth middleware
  const mockAdminAuth = (req: any, res: Response, next: NextFunction) => {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return res.status(401).json({ success: false, message: 'الرجاء تسجيل الدخول' });
    }
    const token = authHeader.substring(7);
    try {
      const decoded = JSON.parse(Buffer.from(token.split('.')[1], 'base64').toString());
      if (decoded.role !== 'admin') {
        return res.status(403).json({ success: false, message: 'غير مصرح لك بالوصول' });
      }
      req.user = {
        _id: new Types.ObjectId(decoded.userId),
        userId: decoded.userId,
        role: decoded.role,
        email: decoded.email,
      };
      next();
    } catch {
      return res.status(401).json({ success: false, message: 'جلسة غير صالحة' });
    }
  };

  // Admin routes with mock auth
  testApp.get('/api/v1/admin/dashboard', mockAdminAuth, getDashboardStats);
  testApp.get('/api/v1/admin/customers', mockAdminAuth, getCustomers);
  testApp.get('/api/v1/admin/craftsmen', mockAdminAuth, getCraftsmenAdmin);
  testApp.get('/api/v1/admin/craftsmen/pending', mockAdminAuth, getPendingCraftsmenAdmin);
  testApp.put('/api/v1/admin/craftsmen/:id/status', mockAdminAuth, updateCraftsmanStatusAdmin);
  testApp.post('/api/v1/admin/craftsmen/:id/approve', mockAdminAuth, approveCraftsman);
  testApp.get('/api/v1/admin/zones', mockAdminAuth, getZones);
  testApp.post('/api/v1/admin/zones', mockAdminAuth, createZone);
  testApp.put('/api/v1/admin/zones/:id', mockAdminAuth, updateZone);
  testApp.delete('/api/v1/admin/zones/:id', mockAdminAuth, deleteZone);
  testApp.get('/api/v1/admin/settings', mockAdminAuth, getSettings);
  testApp.put('/api/v1/admin/settings', mockAdminAuth, updateSettings);
  testApp.post('/api/v1/admin/notifications', mockAdminAuth, sendBroadcastNotification);

  // Error handler
  testApp.use((err: any, _req: Request, res: Response, _next: NextFunction) => {
    res.status(err.statusCode || 500).json({
      success: false,
      message: err.message || 'Internal Server Error',
    });
  });

  return testApp;
};

describe('Admin Routes', () => {
  beforeAll(async () => {
    mongoServer = await MongoMemoryServer.create();
    const mongoUri = mongoServer.getUri();
    await mongoose.connect(mongoUri);

    app = setupApp();

    // Create admin user
    adminUser = await User.create({
      name: 'Admin User',
      email: 'admin@test.com',
      password: 'hashedpassword',
      role: 'admin',
      isActive: true,
      isVerified: true,
    });

    adminToken = generateAccessToken({
      userId: adminUser._id.toString(),
      role: 'admin',
      email: adminUser.email,
    });

    // Create test category
    testCategory = await ServiceCategory.create({
      name: 'Plumbing',
      nameAr: 'سباكة',
      slug: 'plumbing',
      icon: 'plumbing',
      isActive: true,
    });
  });

  afterAll(async () => {
    await mongoose.disconnect();
    await mongoServer.stop();
  });

  beforeEach(async () => {
    // Clear collections except admin user and category
    await User.deleteMany({ email: { $ne: 'admin@test.com' } });
    await Customer.deleteMany({});
    await Craftsman.deleteMany({});
    await ServiceRequest.deleteMany({});
    await Zone.deleteMany({});
    await Setting.deleteMany({});
    await Notification.deleteMany({});
  });

  describe('GET /api/v1/admin/dashboard', () => {
    it('should return dashboard stats for admin', async () => {
      const res = await request(app)
        .get('/api/v1/admin/dashboard')
        .set('Authorization', `Bearer ${adminToken}`);

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
      expect(res.body.data).toHaveProperty('totalRequests');
      expect(res.body.data).toHaveProperty('totalCraftsmen');
      expect(res.body.data).toHaveProperty('totalCustomers');
    });

    it('should reject unauthenticated request', async () => {
      const res = await request(app).get('/api/v1/admin/dashboard');

      expect(res.status).toBe(401);
    });
  });

  describe('GET /api/v1/admin/customers', () => {
    beforeEach(async () => {
      // Create test customers
      const customerUser = await User.create({
        name: 'Customer Test',
        email: 'customer@test.com',
        role: 'customer',
        isActive: true,
      });

      await Customer.create({
        userId: customerUser._id,
        addresses: [],
      });
    });

    it('should return paginated customers', async () => {
      const res = await request(app)
        .get('/api/v1/admin/customers')
        .set('Authorization', `Bearer ${adminToken}`);

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
      expect(res.body.data).toBeInstanceOf(Array);
      expect(res.body.meta).toHaveProperty('page');
      expect(res.body.meta).toHaveProperty('total');
    });

    it('should support search query', async () => {
      const res = await request(app)
        .get('/api/v1/admin/customers')
        .query({ search: 'Customer' })
        .set('Authorization', `Bearer ${adminToken}`);

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
    });
  });

  describe('GET /api/v1/admin/craftsmen', () => {
    beforeEach(async () => {
      const craftsmanUser = await User.create({
        name: 'Craftsman Test',
        email: 'craftsman@test.com',
        role: 'craftsman',
        isActive: true,
      });

      await Craftsman.create({
        userId: craftsmanUser._id,
        displayName: craftsmanUser.name,
        services: [{
          categoryId: testCategory._id,
          subcategories: [],
          experience: 5,
        }],
        status: 'approved',
        bio: 'Test bio',
        location: {
          type: 'Point',
          coordinates: [30.9667, 30.4522],
        },
      });
    });

    it('should return paginated craftsmen', async () => {
      const res = await request(app)
        .get('/api/v1/admin/craftsmen')
        .set('Authorization', `Bearer ${adminToken}`);

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
      expect(res.body.data).toBeInstanceOf(Array);
    });

    it('should filter by status', async () => {
      const res = await request(app)
        .get('/api/v1/admin/craftsmen')
        .query({ status: 'approved' })
        .set('Authorization', `Bearer ${adminToken}`);

      expect(res.status).toBe(200);
      expect(res.body.data.length).toBeGreaterThan(0);
    });
  });

  describe('GET /api/v1/admin/craftsmen/pending', () => {
    beforeEach(async () => {
      const pendingUser = await User.create({
        name: 'Pending Craftsman',
        email: 'pending@test.com',
        role: 'craftsman',
        isActive: true,
      });

      await Craftsman.create({
        userId: pendingUser._id,
        displayName: pendingUser.name,
        services: [{
          categoryId: testCategory._id,
          subcategories: [],
          experience: 3,
        }],
        status: 'pending',
        bio: 'Pending approval',
        location: {
          type: 'Point',
          coordinates: [30.9667, 30.4522],
        },
      });
    });

    it('should return pending craftsmen', async () => {
      const res = await request(app)
        .get('/api/v1/admin/craftsmen/pending')
        .set('Authorization', `Bearer ${adminToken}`);

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
      expect(res.body.data.every((c: any) => c.status === 'pending')).toBe(true);
    });
  });

  describe('PUT /api/v1/admin/craftsmen/:id/status', () => {
    let craftsmanId: string;

    beforeEach(async () => {
      const craftsmanUser = await User.create({
        name: 'Status Test Craftsman',
        email: 'statustest@test.com',
        role: 'craftsman',
        isActive: true,
      });

      const craftsman = await Craftsman.create({
        userId: craftsmanUser._id,
        displayName: craftsmanUser.name,
        services: [{
          categoryId: testCategory._id,
          subcategories: [],
          experience: 2,
        }],
        status: 'pending',
        bio: 'Test',
        location: {
          type: 'Point',
          coordinates: [30.9667, 30.4522],
        },
      });

      craftsmanId = craftsman._id.toString();
    });

    it('should approve craftsman', async () => {
      const res = await request(app)
        .put(`/api/v1/admin/craftsmen/${craftsmanId}/status`)
        .set('Authorization', `Bearer ${adminToken}`)
        .send({ status: 'approved' });

      expect(res.status).toBe(200);
      expect(res.body.data.status).toBe('approved');

      // Check notification was created
      const notification = await Notification.findOne({
        type: 'system',
      });
      expect(notification).toBeTruthy();
    });

    it('should reject craftsman with reason', async () => {
      const res = await request(app)
        .put(`/api/v1/admin/craftsmen/${craftsmanId}/status`)
        .set('Authorization', `Bearer ${adminToken}`)
        .send({ status: 'rejected', reason: 'Incomplete profile' });

      expect(res.status).toBe(200);
      expect(res.body.data.status).toBe('rejected');
    });

    it('should require reason for rejection', async () => {
      const res = await request(app)
        .put(`/api/v1/admin/craftsmen/${craftsmanId}/status`)
        .set('Authorization', `Bearer ${adminToken}`)
        .send({ status: 'rejected' });

      expect(res.status).toBe(400);
    });
  });

  describe('POST /api/v1/admin/craftsmen/:id/approve', () => {
    let craftsmanId: string;

    beforeEach(async () => {
      const craftsmanUser = await User.create({
        name: 'Approve Test',
        email: 'approvetest@test.com',
        role: 'craftsman',
        isActive: true,
      });

      const craftsman = await Craftsman.create({
        userId: craftsmanUser._id,
        displayName: craftsmanUser.name,
        services: [{
          categoryId: testCategory._id,
          subcategories: [],
          experience: 2,
        }],
        status: 'pending',
        bio: 'Test',
        location: {
          type: 'Point',
          coordinates: [30.9667, 30.4522],
        },
      });

      craftsmanId = craftsman._id.toString();
    });

    it('should approve craftsman via convenience endpoint', async () => {
      const res = await request(app)
        .post(`/api/v1/admin/craftsmen/${craftsmanId}/approve`)
        .set('Authorization', `Bearer ${adminToken}`);

      expect(res.status).toBe(200);
      expect(res.body.data.status).toBe('approved');
    });
  });

  describe('Zones Management', () => {
    describe('GET /api/v1/admin/zones', () => {
      beforeEach(async () => {
        await Zone.create({
          name: 'Test Zone',
          nameAr: 'منطقة اختبار',
          type: 'circle',
          center: {
            type: 'Point',
            coordinates: [30.9667, 30.4522],
          },
          radius: 5000,
          isActive: true,
        });
      });

      it('should return zones list', async () => {
        const res = await request(app)
          .get('/api/v1/admin/zones')
          .set('Authorization', `Bearer ${adminToken}`);

        expect(res.status).toBe(200);
        expect(res.body.data).toBeInstanceOf(Array);
        expect(res.body.data.length).toBeGreaterThan(0);
      });
    });

    describe('POST /api/v1/admin/zones', () => {
      it('should create circle zone', async () => {
        const res = await request(app)
          .post('/api/v1/admin/zones')
          .set('Authorization', `Bearer ${adminToken}`)
          .send({
            name: 'New Zone',
            nameAr: 'منطقة جديدة',
            type: 'circle',
            center: {
              type: 'Point',
              coordinates: [30.9667, 30.4522],
            },
            radius: 10000,
            serviceFee: 10,
          });

        expect(res.status).toBe(201);
        expect(res.body.data.name).toBe('New Zone');
      });

      it('should validate required fields', async () => {
        const res = await request(app)
          .post('/api/v1/admin/zones')
          .set('Authorization', `Bearer ${adminToken}`)
          .send({
            name: 'Incomplete',
          });

        expect(res.status).toBe(400);
      });
    });

    describe('PUT /api/v1/admin/zones/:id', () => {
      let zoneId: string;

      beforeEach(async () => {
        const zone = await Zone.create({
          name: 'Update Zone',
          nameAr: 'منطقة تحديث',
          type: 'circle',
          center: {
            type: 'Point',
            coordinates: [30.9667, 30.4522],
          },
          radius: 5000,
          isActive: true,
        });
        zoneId = zone._id.toString();
      });

      it('should update zone', async () => {
        const res = await request(app)
          .put(`/api/v1/admin/zones/${zoneId}`)
          .set('Authorization', `Bearer ${adminToken}`)
          .send({ name: 'Updated Zone Name' });

        expect(res.status).toBe(200);
        expect(res.body.data.name).toBe('Updated Zone Name');
      });
    });

    describe('DELETE /api/v1/admin/zones/:id', () => {
      let zoneId: string;

      beforeEach(async () => {
        const zone = await Zone.create({
          name: 'Delete Zone',
          nameAr: 'منطقة حذف',
          type: 'circle',
          center: {
            type: 'Point',
            coordinates: [30.9667, 30.4522],
          },
          radius: 5000,
          isActive: true,
        });
        zoneId = zone._id.toString();
      });

      it('should delete zone', async () => {
        const res = await request(app)
          .delete(`/api/v1/admin/zones/${zoneId}`)
          .set('Authorization', `Bearer ${adminToken}`);

        expect(res.status).toBe(200);

        const zone = await Zone.findById(zoneId);
        expect(zone).toBeNull();
      });
    });
  });

  describe('Settings Management', () => {
    describe('GET /api/v1/admin/settings', () => {
      it('should return settings with defaults', async () => {
        const res = await request(app)
          .get('/api/v1/admin/settings')
          .set('Authorization', `Bearer ${adminToken}`);

        expect(res.status).toBe(200);
        expect(res.body.data).toHaveProperty('commissionRate');
        expect(res.body.data).toHaveProperty('serviceFee');
      });
    });

    describe('PUT /api/v1/admin/settings', () => {
      it('should update settings', async () => {
        const res = await request(app)
          .put('/api/v1/admin/settings')
          .set('Authorization', `Bearer ${adminToken}`)
          .send({
            commissionRate: 20,
            serviceFee: 10,
          });

        expect(res.status).toBe(200);
        expect(res.body.data.commissionRate).toBe(20);
        expect(res.body.data.serviceFee).toBe(10);
      });
    });
  });

  describe('Notifications Management', () => {
    describe('POST /api/v1/admin/notifications', () => {
      beforeEach(async () => {
        // Create some users to receive broadcast
        await User.create({
          name: 'Broadcast Test User',
          email: 'broadcast@test.com',
          role: 'customer',
          isActive: true,
        });
      });

      it('should send broadcast notification', async () => {
        const res = await request(app)
          .post('/api/v1/admin/notifications')
          .set('Authorization', `Bearer ${adminToken}`)
          .send({
            title: 'Test Broadcast',
            titleAr: 'إشعار اختباري',
            body: 'Test body',
            bodyAr: 'محتوى اختباري',
            type: 'all',
          });

        expect(res.status).toBe(201);
        expect(res.body.data).toHaveProperty('recipientCount');
      });

      it('should validate broadcast fields', async () => {
        const res = await request(app)
          .post('/api/v1/admin/notifications')
          .set('Authorization', `Bearer ${adminToken}`)
          .send({
            title: 'Missing fields',
          });

        expect(res.status).toBe(400);
      });
    });
  });
});
