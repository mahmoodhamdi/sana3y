import admin from 'firebase-admin';
import User from '../models/User';

// Initialize Firebase Admin if not already initialized
const initializeFirebase = () => {
  if (admin.apps.length === 0) {
    const serviceAccount = process.env.FIREBASE_SERVICE_ACCOUNT;

    if (serviceAccount) {
      try {
        const parsedAccount = JSON.parse(serviceAccount);
        admin.initializeApp({
          credential: admin.credential.cert(parsedAccount),
        });
        console.log('Firebase Admin initialized successfully');
      } catch (error) {
        console.error('Failed to initialize Firebase Admin:', error);
      }
    } else {
      console.warn('FIREBASE_SERVICE_ACCOUNT not set, FCM will be disabled');
    }
  }
};

// Initialize on module load
initializeFirebase();

interface PushNotificationPayload {
  title: string;
  body: string;
  data?: Record<string, string>;
  imageUrl?: string;
}

interface SendResult {
  success: boolean;
  successCount: number;
  failureCount: number;
  invalidTokens: string[];
}

class FCMService {
  private isEnabled(): boolean {
    return admin.apps.length > 0;
  }

  // Send notification to a single user
  async sendToUser(
    userId: string,
    payload: PushNotificationPayload
  ): Promise<SendResult> {
    if (!this.isEnabled()) {
      return { success: false, successCount: 0, failureCount: 0, invalidTokens: [] };
    }

    try {
      const user = await User.findById(userId).select('fcmTokens');
      if (!user || !user.fcmTokens || user.fcmTokens.length === 0) {
        return { success: false, successCount: 0, failureCount: 0, invalidTokens: [] };
      }

      return this.sendToTokens(user.fcmTokens, payload, userId);
    } catch (error) {
      console.error('Error sending notification to user:', error);
      return { success: false, successCount: 0, failureCount: 0, invalidTokens: [] };
    }
  }

  // Send notification to multiple users
  async sendToUsers(
    userIds: string[],
    payload: PushNotificationPayload
  ): Promise<SendResult> {
    if (!this.isEnabled()) {
      return { success: false, successCount: 0, failureCount: 0, invalidTokens: [] };
    }

    try {
      const users = await User.find({ _id: { $in: userIds } }).select('fcmTokens');
      const allTokens: string[] = [];

      users.forEach((user) => {
        if (user.fcmTokens && user.fcmTokens.length > 0) {
          allTokens.push(...user.fcmTokens);
        }
      });

      if (allTokens.length === 0) {
        return { success: false, successCount: 0, failureCount: 0, invalidTokens: [] };
      }

      return this.sendToTokens(allTokens, payload);
    } catch (error) {
      console.error('Error sending notification to users:', error);
      return { success: false, successCount: 0, failureCount: 0, invalidTokens: [] };
    }
  }

  // Send notification to specific tokens
  async sendToTokens(
    tokens: string[],
    payload: PushNotificationPayload,
    userId?: string
  ): Promise<SendResult> {
    if (!this.isEnabled() || tokens.length === 0) {
      return { success: false, successCount: 0, failureCount: 0, invalidTokens: [] };
    }

    const message: admin.messaging.MulticastMessage = {
      tokens,
      notification: {
        title: payload.title,
        body: payload.body,
        ...(payload.imageUrl && { imageUrl: payload.imageUrl }),
      },
      data: payload.data || {},
      android: {
        notification: {
          channelId: 'default',
          priority: 'high',
          sound: 'default',
        },
      },
      apns: {
        payload: {
          aps: {
            sound: 'default',
            badge: 1,
          },
        },
      },
    };

    try {
      const response = await admin.messaging().sendEachForMulticast(message);

      const invalidTokens: string[] = [];
      response.responses.forEach((resp, idx) => {
        if (!resp.success && resp.error) {
          const errorCode = resp.error.code;
          if (
            errorCode === 'messaging/invalid-registration-token' ||
            errorCode === 'messaging/registration-token-not-registered'
          ) {
            invalidTokens.push(tokens[idx]);
          }
        }
      });

      // Remove invalid tokens from user
      if (invalidTokens.length > 0 && userId) {
        await this.removeInvalidTokens(userId, invalidTokens);
      }

      return {
        success: response.successCount > 0,
        successCount: response.successCount,
        failureCount: response.failureCount,
        invalidTokens,
      };
    } catch (error) {
      console.error('Error sending FCM message:', error);
      return { success: false, successCount: 0, failureCount: tokens.length, invalidTokens: [] };
    }
  }

  // Send to all users by role
  async sendToRole(
    role: 'customer' | 'craftsman' | 'all',
    payload: PushNotificationPayload
  ): Promise<SendResult> {
    if (!this.isEnabled()) {
      return { success: false, successCount: 0, failureCount: 0, invalidTokens: [] };
    }

    try {
      const query: Record<string, unknown> = {
        fcmTokens: { $exists: true, $ne: [] },
        isActive: true,
      };

      if (role !== 'all') {
        query.role = role;
      }

      const users = await User.find(query).select('fcmTokens');
      const allTokens: string[] = [];

      users.forEach((user) => {
        if (user.fcmTokens) {
          allTokens.push(...user.fcmTokens);
        }
      });

      if (allTokens.length === 0) {
        return { success: false, successCount: 0, failureCount: 0, invalidTokens: [] };
      }

      // Send in batches of 500 (FCM limit)
      const batchSize = 500;
      let totalSuccess = 0;
      let totalFailure = 0;
      const allInvalidTokens: string[] = [];

      for (let i = 0; i < allTokens.length; i += batchSize) {
        const batch = allTokens.slice(i, i + batchSize);
        const result = await this.sendToTokens(batch, payload);
        totalSuccess += result.successCount;
        totalFailure += result.failureCount;
        allInvalidTokens.push(...result.invalidTokens);
      }

      return {
        success: totalSuccess > 0,
        successCount: totalSuccess,
        failureCount: totalFailure,
        invalidTokens: allInvalidTokens,
      };
    } catch (error) {
      console.error('Error sending notification to role:', error);
      return { success: false, successCount: 0, failureCount: 0, invalidTokens: [] };
    }
  }

  // Register FCM token for user
  async registerToken(userId: string, token: string): Promise<boolean> {
    try {
      await User.findByIdAndUpdate(userId, {
        $addToSet: { fcmTokens: token },
      });
      return true;
    } catch (error) {
      console.error('Error registering FCM token:', error);
      return false;
    }
  }

  // Remove FCM token
  async removeToken(userId: string, token: string): Promise<boolean> {
    try {
      await User.findByIdAndUpdate(userId, {
        $pull: { fcmTokens: token },
      });
      return true;
    } catch (error) {
      console.error('Error removing FCM token:', error);
      return false;
    }
  }

  // Remove invalid tokens from user
  private async removeInvalidTokens(userId: string, tokens: string[]): Promise<void> {
    try {
      await User.findByIdAndUpdate(userId, {
        $pull: { fcmTokens: { $in: tokens } },
      });
    } catch (error) {
      console.error('Error removing invalid tokens:', error);
    }
  }
}

export default new FCMService();
