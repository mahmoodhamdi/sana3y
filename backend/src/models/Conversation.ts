import mongoose, { Schema, Model, Document, Types } from 'mongoose';

interface ILastMessage {
  content: string;
  senderId: Types.ObjectId;
  createdAt: Date;
}

export interface IConversation extends Document {
  _id: Types.ObjectId;
  requestId: Types.ObjectId;
  participants: Types.ObjectId[];
  lastMessage?: ILastMessage;
  unreadCount: Map<string, number>;
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
}

const lastMessageSchema = new Schema<ILastMessage>(
  {
    content: {
      type: String,
      required: true,
    },
    senderId: {
      type: Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
    createdAt: {
      type: Date,
      default: Date.now,
    },
  },
  { _id: false }
);

const conversationSchema = new Schema<IConversation>(
  {
    requestId: {
      type: Schema.Types.ObjectId,
      ref: 'ServiceRequest',
      required: true,
    },
    participants: {
      type: [Schema.Types.ObjectId],
      ref: 'User',
      required: true,
      validate: {
        validator: function (participants: Types.ObjectId[]) {
          return participants.length >= 2;
        },
        message: 'At least 2 participants required',
      },
    },
    lastMessage: lastMessageSchema,
    unreadCount: {
      type: Map,
      of: Number,
      default: new Map(),
    },
    isActive: {
      type: Boolean,
      default: true,
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
conversationSchema.index({ requestId: 1 });
conversationSchema.index({ participants: 1 });
conversationSchema.index({ updatedAt: -1 });

// Virtual for request details
conversationSchema.virtual('request', {
  ref: 'ServiceRequest',
  localField: 'requestId',
  foreignField: '_id',
  justOne: true,
});

// Method to mark messages as read for a user
conversationSchema.methods.markAsRead = function (userId: string): void {
  this.unreadCount.set(userId, 0);
};

// Method to increment unread count for recipients
conversationSchema.methods.incrementUnread = function (senderId: string): void {
  this.participants.forEach((participantId: Types.ObjectId) => {
    const id = participantId.toString();
    if (id !== senderId) {
      const current = this.unreadCount.get(id) || 0;
      this.unreadCount.set(id, current + 1);
    }
  });
};

const Conversation: Model<IConversation> = mongoose.model<IConversation>(
  'Conversation',
  conversationSchema
);

export default Conversation;
