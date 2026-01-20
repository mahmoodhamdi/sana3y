import { Router } from 'express';
import { authenticate, requireAdmin } from '@middleware/auth';
import {
  getDashboardStats,
  getCustomers,
  getCustomerById,
  toggleCustomerStatus,
  getCraftsmenAdmin,
  getPendingCraftsmenAdmin,
  updateCraftsmanStatusAdmin,
  approveCraftsman,
  rejectCraftsman,
  suspendCraftsman,
  getRequestsAdmin,
  getTransactions,
  getFinanceStats,
  getZones,
  createZone,
  updateZone,
  deleteZone,
  getSettings,
  updateSettings,
  getAdminNotifications,
  sendBroadcastNotification,
} from '@controllers/admin.controller';

const router = Router();

// All admin routes require authentication and admin role
router.use(authenticate, requireAdmin);

// ============================================
// Dashboard
// ============================================
router.get('/dashboard', getDashboardStats);

// ============================================
// Customers Management
// ============================================
router.get('/customers', getCustomers);
router.get('/customers/:id', getCustomerById);
router.put('/customers/:id/status', toggleCustomerStatus);

// ============================================
// Craftsmen Management
// ============================================
router.get('/craftsmen', getCraftsmenAdmin);
router.get('/craftsmen/pending', getPendingCraftsmenAdmin);
router.put('/craftsmen/:id/status', updateCraftsmanStatusAdmin);
// Convenience endpoints for dashboard
router.post('/craftsmen/:id/approve', approveCraftsman);
router.post('/craftsmen/:id/reject', rejectCraftsman);
router.post('/craftsmen/:id/suspend', suspendCraftsman);

// ============================================
// Requests Management
// ============================================
router.get('/requests', getRequestsAdmin);

// ============================================
// Finance/Transactions
// ============================================
router.get('/transactions', getTransactions);
router.get('/transactions/stats', getFinanceStats);

// ============================================
// Zones Management
// ============================================
router.get('/zones', getZones);
router.post('/zones', createZone);
router.put('/zones/:id', updateZone);
router.delete('/zones/:id', deleteZone);

// ============================================
// Settings Management
// ============================================
router.get('/settings', getSettings);
router.put('/settings', updateSettings);

// ============================================
// Notifications Management
// ============================================
router.get('/notifications', getAdminNotifications);
router.post('/notifications', sendBroadcastNotification);

export default router;
