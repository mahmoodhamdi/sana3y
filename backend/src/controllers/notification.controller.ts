import { Request, Response, NextFunction } from 'express';
import notificationService from '../services/notification.service';
import { sendSuccess } from '@utils/response';
import { UnauthorizedError } from '@utils/errors';

// Helper to get userId with proper null check
const getUserId = (req: Request): string => {
  if (!req.user?.userId) {
    throw new UnauthorizedError('غير مصرح');
  }
  return req.user.userId;
};

// Get user's notifications
export const getNotifications = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = getUserId(req);
    const { page = 1, limit = 20 } = req.query;

    const result = await notificationService.getUserNotifications(
      userId,
      Number(page),
      Number(limit)
    );

    sendSuccess(res, {
      notifications: result.notifications,
      pagination: {
        page: result.page,
        totalPages: result.totalPages,
        total: result.total,
        limit: Number(limit),
      },
      unreadCount: result.unreadCount,
    });
  } catch (error) {
    next(error);
  }
};

// Get unread count
export const getUnreadCount = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = getUserId(req);
    const count = await notificationService.getUnreadCount(userId);

    sendSuccess(res, { count });
  } catch (error) {
    next(error);
  }
};

// Mark notification as read
export const markAsRead = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = getUserId(req);
    const { id } = req.params;

    await notificationService.markAsRead(id, userId);
    sendSuccess(res, null, 'تم تحديث الإشعار');
  } catch (error) {
    next(error);
  }
};

// Mark all notifications as read
export const markAllAsRead = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = getUserId(req);
    const count = await notificationService.markAllAsRead(userId);

    sendSuccess(res, { count }, `تم تحديث ${count} إشعار`);
  } catch (error) {
    next(error);
  }
};

// Delete notification
export const deleteNotification = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = getUserId(req);
    const { id } = req.params;

    await notificationService.deleteNotification(id, userId);
    sendSuccess(res, null, 'تم حذف الإشعار');
  } catch (error) {
    next(error);
  }
};

// Register FCM token
export const registerFCMToken = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = getUserId(req);
    const { token } = req.body;

    await notificationService.registerFCMToken(userId, token);
    sendSuccess(res, null, 'تم تسجيل الجهاز');
  } catch (error) {
    next(error);
  }
};

// Remove FCM token
export const removeFCMToken = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = getUserId(req);
    const { token } = req.body;

    await notificationService.removeFCMToken(userId, token);
    sendSuccess(res, null, 'تم إلغاء تسجيل الجهاز');
  } catch (error) {
    next(error);
  }
};

// Admin: Broadcast notification
export const broadcastNotification = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { title, titleAr, body, bodyAr, targetRole } = req.body;

    const result = await notificationService.broadcastNotification({
      type: 'system',
      title,
      titleAr,
      body,
      bodyAr,
      targetRole,
    });

    sendSuccess(res, result, `تم إرسال الإشعار إلى ${result.sent} مستخدم`);
  } catch (error) {
    next(error);
  }
};
