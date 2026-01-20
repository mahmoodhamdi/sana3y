import { Router } from 'express';
import authRoutes from './auth.routes';
import categoryRoutes from './category.routes';
import craftsmanRoutes from './craftsman.routes';
import uploadRoutes from './upload.routes';
import requestRoutes from './request.routes';
import chatRoutes from './chat.routes';
import reviewRoutes from './review.routes';
import notificationRoutes from './notification.routes';
import paymentRoutes from './payment.routes';
import adminRoutes from './admin.routes';
import customerRoutes from './customer.routes';

const router = Router();

// API version prefix
const API_VERSION = '/api/v1';

// Auth routes
router.use(`${API_VERSION}/auth`, authRoutes);

// Category routes
router.use(`${API_VERSION}/categories`, categoryRoutes);

// Craftsman routes
router.use(`${API_VERSION}/craftsmen`, craftsmanRoutes);

// Upload routes
router.use(`${API_VERSION}/upload`, uploadRoutes);

// Request routes
router.use(`${API_VERSION}/requests`, requestRoutes);

// Chat routes
router.use(`${API_VERSION}/chat`, chatRoutes);

// Review routes
router.use(`${API_VERSION}/reviews`, reviewRoutes);

// Notification routes
router.use(`${API_VERSION}/notifications`, notificationRoutes);

// Payment routes
router.use(`${API_VERSION}/payments`, paymentRoutes);

// Admin routes (dashboard management)
router.use(`${API_VERSION}/admin`, adminRoutes);

// Customer routes (addresses, favorites)
router.use(`${API_VERSION}/customers`, customerRoutes);

// Health check
router.get('/health', (_req, res) => {
  res.json({
    success: true,
    message: 'صنايعي API is running',
    timestamp: new Date().toISOString(),
  });
});

// API info
router.get(API_VERSION, (_req, res) => {
  res.json({
    success: true,
    message: 'مرحباً بك في صنايعي API',
    version: 'v1',
    endpoints: {
      auth: `${API_VERSION}/auth`,
      craftsmen: `${API_VERSION}/craftsmen`,
      categories: `${API_VERSION}/categories`,
      requests: `${API_VERSION}/requests`,
      chat: `${API_VERSION}/chat`,
      reviews: `${API_VERSION}/reviews`,
      notifications: `${API_VERSION}/notifications`,
      upload: `${API_VERSION}/upload`,
      payments: `${API_VERSION}/payments`,
      admin: `${API_VERSION}/admin`,
      customers: `${API_VERSION}/customers`,
    },
  });
});

export default router;
