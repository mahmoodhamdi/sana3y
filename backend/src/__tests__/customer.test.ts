import request from 'supertest';
import express, { Express, Request, Response, NextFunction } from 'express';
import mongoose, { Types } from 'mongoose';
import { MongoMemoryServer } from 'mongodb-memory-server';
import { generateAccessToken } from '@utils/jwt';

// Mock models
import User from '@models/User';
import Customer from '@models/Customer';
import Craftsman from '@models/Craftsman';
import ServiceCategory from '@models/ServiceCategory';

// Controllers
import {
  getAddresses,
  addAddress,
  updateAddress,
  deleteAddress,
  setDefaultAddress,
  getFavorites,
  addToFavorites,
  removeFromFavorites,
  checkFavorite,
  clearFavorites,
  getCustomerProfile,
} from '@controllers/customer.controller';

let app: Express;
let mongoServer: MongoMemoryServer;
let customerToken: string;
let customerUser: any;
let customer: any;
let testCategory: any;
let approvedCraftsman: any;

// Setup express app for testing without the real auth middleware
const setupApp = () => {
  const testApp = express();
  testApp.use(express.json());

  // Mock authenticate middleware that sets req.user from the generated token
  const mockAuth = (req: any, res: Response, next: NextFunction) => {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return res.status(401).json({ success: false, message: 'الرجاء تسجيل الدخول' });
    }
    // The token contains user info, so decode without verifying (test environment)
    const token = authHeader.substring(7);
    try {
      const decoded = JSON.parse(Buffer.from(token.split('.')[1], 'base64').toString());
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

  // Customer routes with mock auth
  testApp.get('/api/v1/customers/me', mockAuth, getCustomerProfile);
  testApp.get('/api/v1/customers/addresses', mockAuth, getAddresses);
  testApp.post('/api/v1/customers/addresses', mockAuth, addAddress);
  testApp.put('/api/v1/customers/addresses/:id', mockAuth, updateAddress);
  testApp.delete('/api/v1/customers/addresses/:id', mockAuth, deleteAddress);
  testApp.patch('/api/v1/customers/addresses/:id/default', mockAuth, setDefaultAddress);
  testApp.get('/api/v1/customers/favorites', mockAuth, getFavorites);
  testApp.post('/api/v1/customers/favorites/:craftsmanId', mockAuth, addToFavorites);
  testApp.delete('/api/v1/customers/favorites/:craftsmanId', mockAuth, removeFromFavorites);
  testApp.get('/api/v1/customers/favorites/:craftsmanId/check', mockAuth, checkFavorite);
  testApp.delete('/api/v1/customers/favorites', mockAuth, clearFavorites);

  // Error handler
  testApp.use((err: any, _req: Request, res: Response, _next: NextFunction) => {
    res.status(err.statusCode || 500).json({
      success: false,
      message: err.message || 'Internal Server Error',
    });
  });

  return testApp;
};

describe('Customer Routes', () => {
  beforeAll(async () => {
    mongoServer = await MongoMemoryServer.create();
    const mongoUri = mongoServer.getUri();
    await mongoose.connect(mongoUri);

    app = setupApp();

    // Create category
    testCategory = await ServiceCategory.create({
      name: 'Electricity',
      nameAr: 'كهرباء',
      slug: 'electricity',
      icon: 'electrical_services',
      isActive: true,
    });

    // Create customer user
    customerUser = await User.create({
      name: 'Test Customer',
      email: 'customer@test.com',
      password: 'hashedpassword',
      role: 'customer',
      isActive: true,
      isVerified: true,
    });

    customerToken = generateAccessToken({
      userId: customerUser._id.toString(),
      role: 'customer',
      email: customerUser.email,
    });

    // Create customer profile
    customer = await Customer.create({
      userId: customerUser._id,
      addresses: [],
      favoriteCraftsmen: [],
    });

    // Create approved craftsman for favorites testing
    const craftsmanUser = await User.create({
      name: 'Test Craftsman',
      email: 'craftsman@test.com',
      role: 'craftsman',
      isActive: true,
    });

    approvedCraftsman = await Craftsman.create({
      userId: craftsmanUser._id,
      displayName: craftsmanUser.name,
      services: [{
        categoryId: testCategory._id,
        subcategories: [],
        experience: 5,
      }],
      status: 'approved',
      bio: 'Professional electrician',
      location: {
        type: 'Point',
        coordinates: [30.9667, 30.4522],
      },
    });
  });

  afterAll(async () => {
    await mongoose.disconnect();
    await mongoServer.stop();
  });

  beforeEach(async () => {
    // Reset customer addresses and favorites
    await Customer.findByIdAndUpdate(customer._id, {
      addresses: [],
      favoriteCraftsmen: [],
    });
  });

  describe('GET /api/v1/customers/me', () => {
    it('should return customer profile', async () => {
      const res = await request(app)
        .get('/api/v1/customers/me')
        .set('Authorization', `Bearer ${customerToken}`);

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
      expect(res.body.data).toHaveProperty('addresses');
    });

    it('should reject unauthenticated request', async () => {
      const res = await request(app).get('/api/v1/customers/me');

      expect(res.status).toBe(401);
    });
  });

  describe('Address Management', () => {
    describe('GET /api/v1/customers/addresses', () => {
      it('should return empty addresses initially', async () => {
        const res = await request(app)
          .get('/api/v1/customers/addresses')
          .set('Authorization', `Bearer ${customerToken}`);

        expect(res.status).toBe(200);
        expect(res.body.data).toEqual([]);
      });
    });

    describe('POST /api/v1/customers/addresses', () => {
      it('should add new address', async () => {
        const addressData = {
          label: 'home',
          name: 'Home Address',
          address: '123 Main Street, Building 5',
          area: 'الباجور',
          city: 'المنوفية',
          location: {
            type: 'Point',
            coordinates: [30.9667, 30.4522],
          },
        };

        const res = await request(app)
          .post('/api/v1/customers/addresses')
          .set('Authorization', `Bearer ${customerToken}`)
          .send(addressData);

        expect(res.status).toBe(201);
        expect(res.body.success).toBe(true);
        expect(res.body.data.name).toBe('Home Address');
        expect(res.body.data.isDefault).toBe(true); // First address is default
      });

      it('should set first address as default', async () => {
        const res = await request(app)
          .post('/api/v1/customers/addresses')
          .set('Authorization', `Bearer ${customerToken}`)
          .send({
            label: 'work',
            name: 'Work Address',
            address: 'Office Building, Floor 3',
            area: 'شبين الكوم',
            location: {
              type: 'Point',
              coordinates: [30.5514, 30.5585],
            },
          });

        expect(res.status).toBe(201);
        expect(res.body.data.isDefault).toBe(true);
      });

      it('should validate required fields', async () => {
        const res = await request(app)
          .post('/api/v1/customers/addresses')
          .set('Authorization', `Bearer ${customerToken}`)
          .send({
            label: 'home',
            // Missing required fields
          });

        expect(res.status).toBe(400);
      });

      it('should limit addresses to 10', async () => {
        // Add 10 addresses
        for (let i = 0; i < 10; i++) {
          await request(app)
            .post('/api/v1/customers/addresses')
            .set('Authorization', `Bearer ${customerToken}`)
            .send({
              label: 'other',
              name: `Address ${i + 1}`,
              address: `Street ${i + 1}`,
              area: 'الباجور',
              location: {
                type: 'Point',
                coordinates: [30.9667 + i * 0.001, 30.4522],
              },
            });
        }

        // Try to add 11th
        const res = await request(app)
          .post('/api/v1/customers/addresses')
          .set('Authorization', `Bearer ${customerToken}`)
          .send({
            label: 'other',
            name: 'Address 11',
            address: 'Street 11',
            area: 'الباجور',
            location: {
              type: 'Point',
              coordinates: [30.9667, 30.4522],
            },
          });

        expect(res.status).toBe(400);
      });
    });

    describe('PUT /api/v1/customers/addresses/:id', () => {
      let addressId: string;

      beforeEach(async () => {
        const res = await request(app)
          .post('/api/v1/customers/addresses')
          .set('Authorization', `Bearer ${customerToken}`)
          .send({
            label: 'home',
            name: 'Original Name',
            address: 'Original Street',
            area: 'الباجور',
            location: {
              type: 'Point',
              coordinates: [30.9667, 30.4522],
            },
          });

        addressId = res.body.data._id;
      });

      it('should update address', async () => {
        const res = await request(app)
          .put(`/api/v1/customers/addresses/${addressId}`)
          .set('Authorization', `Bearer ${customerToken}`)
          .send({
            name: 'Updated Name',
          });

        expect(res.status).toBe(200);
        expect(res.body.data.name).toBe('Updated Name');
      });

      it('should return 404 for non-existent address', async () => {
        const fakeId = new Types.ObjectId().toString();
        const res = await request(app)
          .put(`/api/v1/customers/addresses/${fakeId}`)
          .set('Authorization', `Bearer ${customerToken}`)
          .send({ name: 'Test' });

        expect(res.status).toBe(404);
      });
    });

    describe('PATCH /api/v1/customers/addresses/:id/default', () => {
      let address1Id: string;
      let address2Id: string;

      beforeEach(async () => {
        const res1 = await request(app)
          .post('/api/v1/customers/addresses')
          .set('Authorization', `Bearer ${customerToken}`)
          .send({
            label: 'home',
            name: 'Address 1',
            address: 'Street 1',
            area: 'الباجور',
            location: { type: 'Point', coordinates: [30.9667, 30.4522] },
          });
        address1Id = res1.body.data._id;

        const res2 = await request(app)
          .post('/api/v1/customers/addresses')
          .set('Authorization', `Bearer ${customerToken}`)
          .send({
            label: 'work',
            name: 'Address 2',
            address: 'Street 2',
            area: 'شبين الكوم',
            location: { type: 'Point', coordinates: [30.5514, 30.5585] },
          });
        address2Id = res2.body.data._id;
      });

      it('should set address as default', async () => {
        const res = await request(app)
          .patch(`/api/v1/customers/addresses/${address2Id}/default`)
          .set('Authorization', `Bearer ${customerToken}`);

        expect(res.status).toBe(200);
        expect(res.body.data.isDefault).toBe(true);

        // Verify first address is no longer default
        const getRes = await request(app)
          .get('/api/v1/customers/addresses')
          .set('Authorization', `Bearer ${customerToken}`);

        const addr1 = getRes.body.data.find((a: any) => a._id === address1Id);
        expect(addr1.isDefault).toBe(false);
      });
    });

    describe('DELETE /api/v1/customers/addresses/:id', () => {
      let addressId: string;

      beforeEach(async () => {
        const res = await request(app)
          .post('/api/v1/customers/addresses')
          .set('Authorization', `Bearer ${customerToken}`)
          .send({
            label: 'home',
            name: 'Delete Me',
            address: 'Delete Street',
            area: 'الباجور',
            location: { type: 'Point', coordinates: [30.9667, 30.4522] },
          });
        addressId = res.body.data._id;
      });

      it('should delete address', async () => {
        const res = await request(app)
          .delete(`/api/v1/customers/addresses/${addressId}`)
          .set('Authorization', `Bearer ${customerToken}`);

        expect(res.status).toBe(200);

        // Verify deletion
        const getRes = await request(app)
          .get('/api/v1/customers/addresses')
          .set('Authorization', `Bearer ${customerToken}`);

        expect(getRes.body.data.length).toBe(0);
      });

      it('should make another address default when deleting default', async () => {
        // Add second address
        await request(app)
          .post('/api/v1/customers/addresses')
          .set('Authorization', `Bearer ${customerToken}`)
          .send({
            label: 'work',
            name: 'Second Address',
            address: 'Second Street',
            area: 'شبين الكوم',
            location: { type: 'Point', coordinates: [30.5514, 30.5585] },
          });

        // Delete first (default) address
        await request(app)
          .delete(`/api/v1/customers/addresses/${addressId}`)
          .set('Authorization', `Bearer ${customerToken}`);

        // Check remaining address is now default
        const getRes = await request(app)
          .get('/api/v1/customers/addresses')
          .set('Authorization', `Bearer ${customerToken}`);

        expect(getRes.body.data[0].isDefault).toBe(true);
      });
    });
  });

  describe('Favorites Management', () => {
    describe('GET /api/v1/customers/favorites', () => {
      it('should return empty favorites initially', async () => {
        const res = await request(app)
          .get('/api/v1/customers/favorites')
          .set('Authorization', `Bearer ${customerToken}`);

        expect(res.status).toBe(200);
        expect(res.body.data).toEqual([]);
      });
    });

    describe('POST /api/v1/customers/favorites/:craftsmanId', () => {
      it('should add craftsman to favorites', async () => {
        const res = await request(app)
          .post(`/api/v1/customers/favorites/${approvedCraftsman._id}`)
          .set('Authorization', `Bearer ${customerToken}`);

        expect(res.status).toBe(201);
        expect(res.body.success).toBe(true);
      });

      it('should not add duplicate', async () => {
        // Add first time
        await request(app)
          .post(`/api/v1/customers/favorites/${approvedCraftsman._id}`)
          .set('Authorization', `Bearer ${customerToken}`);

        // Try to add again
        const res = await request(app)
          .post(`/api/v1/customers/favorites/${approvedCraftsman._id}`)
          .set('Authorization', `Bearer ${customerToken}`);

        expect(res.status).toBe(400);
      });

      it('should not add non-existent craftsman', async () => {
        const fakeId = new Types.ObjectId().toString();
        const res = await request(app)
          .post(`/api/v1/customers/favorites/${fakeId}`)
          .set('Authorization', `Bearer ${customerToken}`);

        expect(res.status).toBe(404);
      });
    });

    describe('GET /api/v1/customers/favorites/:craftsmanId/check', () => {
      it('should return false when not in favorites', async () => {
        const res = await request(app)
          .get(`/api/v1/customers/favorites/${approvedCraftsman._id}/check`)
          .set('Authorization', `Bearer ${customerToken}`);

        expect(res.status).toBe(200);
        expect(res.body.data.isFavorite).toBe(false);
      });

      it('should return true when in favorites', async () => {
        // Add to favorites first
        await request(app)
          .post(`/api/v1/customers/favorites/${approvedCraftsman._id}`)
          .set('Authorization', `Bearer ${customerToken}`);

        const res = await request(app)
          .get(`/api/v1/customers/favorites/${approvedCraftsman._id}/check`)
          .set('Authorization', `Bearer ${customerToken}`);

        expect(res.status).toBe(200);
        expect(res.body.data.isFavorite).toBe(true);
      });
    });

    describe('DELETE /api/v1/customers/favorites/:craftsmanId', () => {
      beforeEach(async () => {
        await request(app)
          .post(`/api/v1/customers/favorites/${approvedCraftsman._id}`)
          .set('Authorization', `Bearer ${customerToken}`);
      });

      it('should remove craftsman from favorites', async () => {
        const res = await request(app)
          .delete(`/api/v1/customers/favorites/${approvedCraftsman._id}`)
          .set('Authorization', `Bearer ${customerToken}`);

        expect(res.status).toBe(200);

        // Verify removal
        const checkRes = await request(app)
          .get(`/api/v1/customers/favorites/${approvedCraftsman._id}/check`)
          .set('Authorization', `Bearer ${customerToken}`);

        expect(checkRes.body.data.isFavorite).toBe(false);
      });
    });

    describe('DELETE /api/v1/customers/favorites', () => {
      beforeEach(async () => {
        await request(app)
          .post(`/api/v1/customers/favorites/${approvedCraftsman._id}`)
          .set('Authorization', `Bearer ${customerToken}`);
      });

      it('should clear all favorites', async () => {
        const res = await request(app)
          .delete('/api/v1/customers/favorites')
          .set('Authorization', `Bearer ${customerToken}`);

        expect(res.status).toBe(200);

        // Verify all cleared
        const getRes = await request(app)
          .get('/api/v1/customers/favorites')
          .set('Authorization', `Bearer ${customerToken}`);

        expect(getRes.body.data.length).toBe(0);
      });
    });
  });
});
