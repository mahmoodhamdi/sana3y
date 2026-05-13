import { Router, Request } from 'express';
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

// Wallet aggregate (uses wallet.service — single endpoint for the mobile wallet screen)
import { getCraftsmanWalletBalance, requestWithdrawal } from '@services/wallet.service';
router.get('/wallet', authenticate, requireRole('craftsman'), async (req, res, next) => {
  try {
    const userId =
      (req as Request & { user?: { _id?: string; userId?: string } }).user?._id ??
      (req as Request & { user?: { userId?: string } }).user?.userId;
    if (!userId) {
      res.status(401).json({ success: false, message: 'Unauthorized' });
      return;
    }
    const balance = await getCraftsmanWalletBalance(String(userId));
    res.json({ success: true, data: balance });
  } catch (err) {
    next(err);
  }
});
router.post('/wallet/withdraw', authenticate, requireRole('craftsman'), async (req, res, next) => {
  try {
    const userId =
      (req as Request & { user?: { _id?: string; userId?: string } }).user?._id ??
      (req as Request & { user?: { userId?: string } }).user?.userId;
    if (!userId) {
      res.status(401).json({ success: false, message: 'Unauthorized' });
      return;
    }
    const { amount, method, destinationRef } = req.body as {
      amount?: number;
      method?: 'bank_transfer' | 'instapay' | 'vodafone_cash' | 'cash_at_office';
      destinationRef?: string;
    };
    if (typeof amount !== 'number' || amount <= 0) {
      res.status(400).json({ success: false, message: 'amount must be a positive number' });
      return;
    }
    if (!method || !destinationRef) {
      res.status(400).json({ success: false, message: 'method and destinationRef are required' });
      return;
    }
    const result = await requestWithdrawal({
      craftsmanUserId: String(userId),
      amount,
      method,
      destinationRef,
    });
    res.status(201).json({ success: true, data: result });
  } catch (err) {
    next(err);
  }
});

// Admin routes
router.get('/', authenticate, requireRole('admin'), getCraftsmen);
router.get('/pending', authenticate, requireRole('admin'), getPendingCraftsmen);
router.put('/:id/status', authenticate, requireRole('admin'), updateCraftsmanStatus);

// Public route with ID (must be after other routes to avoid conflicts)
router.get('/:id', getCraftsmanById);

export default router;
