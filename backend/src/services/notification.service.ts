import { Types } from 'mongoose';
import Notification, { INotification } from '../models/Notification';
import fcmService from './fcm.service';
import socketService from './socket.service';

type NotificationType = 'request' | 'quote' | 'status' | 'chat' | 'review' | 'system' | 'promotion';

interface CreateNotificationInput {
  userId: string;
  type: NotificationType;
  title: string;
  titleAr?: string;
  body: string;
  bodyAr?: string;
  data?: Record<string, unknown>;
  sendPush?: boolean;
}

interface BroadcastNotificationInput {
  type: NotificationType;
  title: string;
  titleAr?: string;
  body: string;
  bodyAr?: string;
  targetRole: 'all' | 'customer' | 'craftsman';
  data?: Record<string, unknown>;
}

class NotificationService {
  // Create and send a notification to a user
  async createNotification(input: CreateNotificationInput): Promise<INotification> {
    const notification = await Notification.create({
      userId: new Types.ObjectId(input.userId),
      type: input.type,
      title: input.title,
      titleAr: input.titleAr || input.title,
      body: input.body,
      bodyAr: input.bodyAr || input.body,
      data: input.data || {},
    });

    // Send real-time notification via Socket.io
    socketService.emitToUser(input.userId, 'notification:new', {
      notification: {
        id: notification._id,
        title: notification.titleAr || notification.title,
        body: notification.bodyAr || notification.body,
        type: notification.type,
        data: notification.data,
        createdAt: notification.createdAt,
      },
    });

    // Send push notification if enabled
    if (input.sendPush !== false) {
      const pushResult = await fcmService.sendToUser(input.userId, {
        title: input.titleAr || input.title,
        body: input.bodyAr || input.body,
        data: this.stringifyData(input.data),
      });

      if (pushResult.success) {
        notification.isSent = true;
        notification.sentAt = new Date();
        await notification.save();
      }
    }

    return notification;
  }

  // Broadcast notification to multiple users
  async broadcastNotification(input: BroadcastNotificationInput): Promise<{
    sent: number;
    failed: number;
  }> {
    // Send push notifications
    const result = await fcmService.sendToRole(
      input.targetRole === 'all' ? 'all' : input.targetRole,
      {
        title: input.titleAr || input.title,
        body: input.bodyAr || input.body,
        data: this.stringifyData(input.data),
      }
    );

    return {
      sent: result.successCount,
      failed: result.failureCount,
    };
  }

  // Get user's notifications
  async getUserNotifications(
    userId: string,
    page = 1,
    limit = 20
  ): Promise<{
    notifications: INotification[];
    page: number;
    totalPages: number;
    total: number;
    unreadCount: number;
  }> {
    const skip = (page - 1) * limit;

    const [notifications, total, unreadCount] = await Promise.all([
      Notification.find({ userId: new Types.ObjectId(userId) })
        .sort({ createdAt: -1 })
        .skip(skip)
        .limit(limit),
      Notification.countDocuments({ userId: new Types.ObjectId(userId) }),
      Notification.countDocuments({ userId: new Types.ObjectId(userId), isRead: false }),
    ]);

    return {
      notifications,
      page,
      totalPages: Math.ceil(total / limit),
      total,
      unreadCount,
    };
  }

  // Mark notification as read
  async markAsRead(notificationId: string, userId: string): Promise<boolean> {
    const result = await Notification.findOneAndUpdate(
      {
        _id: new Types.ObjectId(notificationId),
        userId: new Types.ObjectId(userId),
      },
      {
        isRead: true,
        readAt: new Date(),
      }
    );
    return result !== null;
  }

  // Mark all notifications as read
  async markAllAsRead(userId: string): Promise<number> {
    const result = await Notification.updateMany(
      { userId: new Types.ObjectId(userId), isRead: false },
      { isRead: true, readAt: new Date() }
    );
    return result.modifiedCount;
  }

  // Delete notification
  async deleteNotification(notificationId: string, userId: string): Promise<boolean> {
    const result = await Notification.findOneAndDelete({
      _id: new Types.ObjectId(notificationId),
      userId: new Types.ObjectId(userId),
    });
    return result !== null;
  }

  // Get unread count
  async getUnreadCount(userId: string): Promise<number> {
    return Notification.countDocuments({
      userId: new Types.ObjectId(userId),
      isRead: false,
    });
  }

  // Register FCM token
  async registerFCMToken(userId: string, token: string): Promise<boolean> {
    return fcmService.registerToken(userId, token);
  }

  // Remove FCM token
  async removeFCMToken(userId: string, token: string): Promise<boolean> {
    return fcmService.removeToken(userId, token);
  }

  // Helper to convert data object to string values for FCM
  private stringifyData(data?: Record<string, unknown>): Record<string, string> {
    if (!data) return {};
    const result: Record<string, string> = {};
    Object.entries(data).forEach(([key, value]) => {
      result[key] = typeof value === 'string' ? value : JSON.stringify(value);
    });
    return result;
  }

  // === Notification Triggers ===

  // New service request created
  async notifyNewRequest(
    requestId: string,
    title: string,
    craftsmanIds: string[]
  ): Promise<void> {
    for (const craftsmanId of craftsmanIds) {
      await this.createNotification({
        userId: craftsmanId,
        type: 'request',
        title: 'New Service Request',
        titleAr: 'طلب خدمة جديد',
        body: `New request: ${title}`,
        bodyAr: `طلب جديد: ${title}`,
        data: { requestId, action: 'view_request' },
      });
    }
  }

  // Quote received by customer
  async notifyQuoteReceived(
    customerId: string,
    requestTitle: string,
    craftsmanName: string,
    amount: number,
    requestId: string
  ): Promise<void> {
    await this.createNotification({
      userId: customerId,
      type: 'quote',
      title: 'Quote Received',
      titleAr: 'تم استلام عرض سعر',
      body: `${craftsmanName} sent a quote of ${amount} EGP for "${requestTitle}"`,
      bodyAr: `${craftsmanName} أرسل عرض سعر ${amount} ج.م لـ "${requestTitle}"`,
      data: { requestId, action: 'view_quotes' },
    });
  }

  // Quote accepted - notify craftsman
  async notifyQuoteAccepted(
    craftsmanId: string,
    requestTitle: string,
    customerName: string,
    requestId: string
  ): Promise<void> {
    await this.createNotification({
      userId: craftsmanId,
      type: 'quote',
      title: 'Quote Accepted',
      titleAr: 'تم قبول العرض',
      body: `${customerName} accepted your quote for "${requestTitle}"`,
      bodyAr: `${customerName} قبل عرضك لـ "${requestTitle}"`,
      data: { requestId, action: 'view_job' },
    });
  }

  // Request status changed
  async notifyStatusChange(
    userId: string,
    requestTitle: string,
    newStatus: string,
    requestId: string
  ): Promise<void> {
    const statusMessages: Record<string, { en: string; ar: string }> = {
      in_progress: { en: 'Work has started', ar: 'بدأ العمل' },
      completed: { en: 'Job completed', ar: 'اكتمل العمل' },
      cancelled: { en: 'Request cancelled', ar: 'تم إلغاء الطلب' },
    };

    const message = statusMessages[newStatus] || { en: `Status: ${newStatus}`, ar: `الحالة: ${newStatus}` };

    await this.createNotification({
      userId,
      type: 'status',
      title: 'Request Update',
      titleAr: 'تحديث الطلب',
      body: `${requestTitle}: ${message.en}`,
      bodyAr: `${requestTitle}: ${message.ar}`,
      data: { requestId, status: newStatus, action: 'view_request' },
    });
  }

  // New chat message
  async notifyNewMessage(
    userId: string,
    senderName: string,
    messagePreview: string,
    conversationId: string
  ): Promise<void> {
    await this.createNotification({
      userId,
      type: 'chat',
      title: 'New Message',
      titleAr: 'رسالة جديدة',
      body: `${senderName}: ${messagePreview}`,
      bodyAr: `${senderName}: ${messagePreview}`,
      data: { conversationId, action: 'open_chat' },
    });
  }

  // New review received
  async notifyNewReview(
    craftsmanId: string,
    customerName: string,
    rating: number,
    requestId: string
  ): Promise<void> {
    const stars = '⭐'.repeat(rating);
    await this.createNotification({
      userId: craftsmanId,
      type: 'review',
      title: 'New Review',
      titleAr: 'تقييم جديد',
      body: `${customerName} rated you ${stars}`,
      bodyAr: `${customerName} قيّمك ${stars}`,
      data: { requestId, rating: rating.toString(), action: 'view_reviews' },
    });
  }
}

export default new NotificationService();
