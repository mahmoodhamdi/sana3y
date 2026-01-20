import { Router } from 'express';
import { authenticate, requireCustomer } from '@middleware/auth';
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

const router = Router();

// All customer routes require authentication
router.use(authenticate);

// ============================================
// Customer Profile
// ============================================
router.get('/me', getCustomerProfile);

// ============================================
// Addresses
// ============================================
router.get('/addresses', getAddresses);
router.post('/addresses', addAddress);
router.put('/addresses/:id', updateAddress);
router.delete('/addresses/:id', deleteAddress);
router.patch('/addresses/:id/default', setDefaultAddress);

// ============================================
// Favorites
// ============================================
router.get('/favorites', getFavorites);
router.post('/favorites/:craftsmanId', addToFavorites);
router.delete('/favorites/:craftsmanId', removeFromFavorites);
router.get('/favorites/:craftsmanId/check', checkFavorite);
router.delete('/favorites', clearFavorites);

export default router;
