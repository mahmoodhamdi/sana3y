import { Router } from 'express';
import {
  getNotifications,
  getUnreadCount,
  markAsRead,
  markAllAsRead,
  deleteNotification,
  registerFCMToken,
  removeFCMToken,
  broadcastNotification,
} from '../controllers/notification.controller';
import { authenticate, requireAdmin } from '../middleware/auth';
import { validateRegisterToken, validateBroadcast } from '../validators/notification.validator';

const router = Router();

// User routes (require authentication)
router.use(authenticate);

// Get user's notifications
router.get('/', getNotifications);

// Get unread count
router.get('/unread-count', getUnreadCount);

// Mark single notification as read
router.put('/:id/read', markAsRead);

// Mark all notifications as read
router.put('/read-all', markAllAsRead);

// Delete notification
router.delete('/:id', deleteNotification);

// FCM token management
router.post('/fcm-token', validateRegisterToken, registerFCMToken);
router.delete('/fcm-token', validateRegisterToken, removeFCMToken);

// Admin routes
router.post('/broadcast', requireAdmin, validateBroadcast, broadcastNotification);

export default router;
