import { Router } from 'express';
import { authenticate, requireAdmin } from '@middleware/auth';
import { auditLog } from '@middleware/auditLog';
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

// Record mutating admin actions for the audit log viewer
router.use(auditLog);

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

// ============================================
// Audit Log
// ============================================
import AuditLog from '@models/AuditLog';
router.get('/audit-log', async (req, res, next) => {
  try {
    const page = Math.max(1, parseInt(String(req.query.page ?? '1'), 10));
    const limit = Math.min(100, Math.max(1, parseInt(String(req.query.limit ?? '50'), 10)));
    const filter: Record<string, unknown> = {};
    if (req.query.actor) filter.actorUserId = req.query.actor;
    if (req.query.targetType) filter.targetType = req.query.targetType;
    const [items, total] = await Promise.all([
      AuditLog.find(filter)
        .sort({ createdAt: -1 })
        .skip((page - 1) * limit)
        .limit(limit)
        .lean(),
      AuditLog.countDocuments(filter),
    ]);
    res.json({
      success: true,
      data: { items, total, page, limit, pages: Math.ceil(total / limit) },
    });
  } catch (err) {
    next(err);
  }
});

export default router;
