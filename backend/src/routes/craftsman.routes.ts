import { Router } from 'express';
import {
  getCraftsmen,
  getApprovedCraftsmen,
  getCraftsmenByCategory,
  getNearbyCraftsmen,
  getFeaturedCraftsmen,
  getPendingCraftsmen,
  getCraftsmanById,
  getMyProfile,
  createCraftsmanProfile,
  updateCraftsmanProfile,
  updateCraftsmanStatus,
  toggleOnline,
  toggleAvailability,
  addWorkPhotos,
  removeWorkPhoto,
  getEarnings,
  requestPayout,
  getPayoutHistory,
} from '@controllers/craftsman.controller';
import { authenticate, requireRole } from '@middleware/auth';

const router = Router();

// Public routes
router.get('/public', getApprovedCraftsmen);
router.get('/featured', getFeaturedCraftsmen);
router.get('/nearby', getNearbyCraftsmen);
router.get('/category/:categoryId', getCraftsmenByCategory);

// Protected routes - Craftsman
router.get('/me', authenticate, requireRole('craftsman'), getMyProfile);
router.post('/profile', authenticate, requireRole('craftsman'), createCraftsmanProfile);
router.put('/profile', authenticate, requireRole('craftsman'), updateCraftsmanProfile);
router.put('/online', authenticate, requireRole('craftsman'), toggleOnline);
router.put('/availability', authenticate, requireRole('craftsman'), toggleAvailability);
router.post('/photos', authenticate, requireRole('craftsman'), addWorkPhotos);
router.delete('/photos', authenticate, requireRole('craftsman'), removeWorkPhoto);

// Earnings and payouts
router.get('/earnings', authenticate, requireRole('craftsman'), getEarnings);
router.post('/payout', authenticate, requireRole('craftsman'), requestPayout);
router.get('/payout/history', authenticate, requireRole('craftsman'), getPayoutHistory);

// Admin routes
router.get('/', authenticate, requireRole('admin'), getCraftsmen);
router.get('/pending', authenticate, requireRole('admin'), getPendingCraftsmen);
router.put('/:id/status', authenticate, requireRole('admin'), updateCraftsmanStatus);

// Public route with ID (must be after other routes to avoid conflicts)
router.get('/:id', getCraftsmanById);

export default router;
