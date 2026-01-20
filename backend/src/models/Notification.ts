import mongoose, { Schema, Model, Document, Types } from 'mongoose';

interface INotificationData {
  requestId?: Types.ObjectId;
  craftsmanId?: Types.ObjectId;
  action?: string;
  [key: string]: unknown;
}

export interface INotification extends Document {
  _id: Types.ObjectId;
  userId: Types.ObjectId;
  title: string;
  titleAr?: string;
  body: string;
  bodyAr?: string;
  type: 'request' | 'quote' | 'status' | 'chat' | 'review' | 'system' | 'promotion';
  data?: INotificationData;
  isRead: boolean;
  readAt?: Date;
  isSent: boolean;
  sentAt?: Date;
  isBroadcast: boolean;
  createdAt: Date;
}

const notificationSchema = new Schema<INotification>(
  {
    userId: {
      type: Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
    title: {
      type: String,
      required: true,
    },
    titleAr: String,
    body: {
      type: String,
      required: true,
    },
    bodyAr: String,
    type: {
      type: String,
      enum: ['request', 'quote', 'status', 'chat', 'review', 'system', 'promotion'],
      required: true,
    },
    data: {
      type: Schema.Types.Mixed,
      default: {},
    },
    isRead: {
      type: Boolean,
      default: false,
    },
    readAt: Date,
    isSent: {
      type: Boolean,
      default: false,
    },
    sentAt: Date,
    isBroadcast: {
      type: Boolean,
      default: false,
    },
  },
  {
    timestamps: true,
    toJSON: {
      virtuals: true,
      transform: (_doc, ret: Record<string, unknown>) => {
        ret.__v = undefined;
        return ret;
      },
    },
    toObject: {
      virtuals: true,
    },
  }
);

// Indexes
notificationSchema.index({ userId: 1, createdAt: -1 });
notificationSchema.index({ userId: 1, isRead: 1 });
notificationSchema.index({ type: 1 });

// TTL index to delete old notifications after 30 days
notificationSchema.index({ createdAt: 1 }, { expireAfterSeconds: 30 * 24 * 60 * 60 });

const Notification: Model<INotification> = mongoose.model<INotification>(
  'Notification',
  notificationSchema
);

export default Notification;
