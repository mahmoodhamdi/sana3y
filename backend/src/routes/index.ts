import { Router } from 'express';
import authRoutes from './auth.routes';
import categoryRoutes from './category.routes';
import craftsmanRoutes from './craftsman.routes';
import uploadRoutes from './upload.routes';
import requestRoutes from './request.routes';

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
      users: `${API_VERSION}/users`,
      craftsmen: `${API_VERSION}/craftsmen`,
      categories: `${API_VERSION}/categories`,
      requests: `${API_VERSION}/requests`,
      reviews: `${API_VERSION}/reviews`,
      chat: `${API_VERSION}/chat`,
    },
  });
});

export default router;
