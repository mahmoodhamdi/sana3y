import { Types } from 'mongoose';
import Conversation, { IConversation } from '@models/Conversation';
import Message, { IMessage } from '@models/Message';
import ServiceRequest from '@models/ServiceRequest';
import { NotFoundError, ForbiddenError } from '@utils/errors';
import socketService from './socket.service';

interface CreateConversationParams {
  requestId: string;
  participants: string[];
}

interface SendMessageParams {
  conversationId: string;
  senderId: string;
  type: 'text' | 'image' | 'voice' | 'location' | 'system';
  content: string;
  metadata?: Record<string, unknown>;
}

interface GetMessagesParams {
  conversationId: string;
  userId: string;
  page?: number;
  limit?: number;
  before?: Date;
}

interface ConversationListParams {
  userId: string;
  page?: number;
  limit?: number;
}

class ChatService {
  /**
   * Create or get existing conversation for a request
   */
  async getOrCreateConversation(params: CreateConversationParams): Promise<IConversation> {
    const { requestId, participants } = params;

    // Validate request exists
    const request = await ServiceRequest.findById(requestId);
    if (!request) {
      throw new NotFoundError('الطلب غير موجود');
    }

    // Check if conversation already exists for this request
    let conversation = await Conversation.findOne({
      requestId: new Types.ObjectId(requestId),
    });

    if (conversation) {
      return conversation;
    }

    // Create new conversation
    conversation = await Conversation.create({
      requestId: new Types.ObjectId(requestId),
      participants: participants.map((id) => new Types.ObjectId(id)),
      unreadCount: new Map(participants.map((id) => [id, 0])),
    });

    // Create system message
    await this.sendMessage({
      conversationId: conversation._id.toString(),
      senderId: participants[0], // Customer
      type: 'system',
      content: 'تم بدء المحادثة',
    });

    return conversation;
  }

  /**
   * Get conversation by ID
   */
  async getConversationById(
    conversationId: string,
    userId: string
  ): Promise<IConversation | null> {
    const conversation = await Conversation.findOne({
      _id: new Types.ObjectId(conversationId),
      participants: new Types.ObjectId(userId),
    })
      .populate('participants', 'name phone avatar role')
      .populate({
        path: 'requestId',
        select: 'requestNumber title status category',
        populate: {
          path: 'category',
          select: 'nameAr icon',
        },
      });

    return conversation;
  }

  /**
   * Get user's conversations list
   */
  async getUserConversations(params: ConversationListParams) {
    const { userId, page = 1, limit = 20 } = params;

    const skip = (page - 1) * limit;

    const [conversations, total] = await Promise.all([
      Conversation.find({
        participants: new Types.ObjectId(userId),
        isActive: true,
      })
        .sort({ updatedAt: -1 })
        .skip(skip)
        .limit(limit)
        .populate('participants', 'name phone avatar role')
        .populate({
          path: 'requestId',
          select: 'requestNumber title status category assignedCraftsman',
          populate: [
            { path: 'category', select: 'nameAr icon' },
            { path: 'assignedCraftsman', select: 'displayName profileImage' },
          ],
        }),
      Conversation.countDocuments({
        participants: new Types.ObjectId(userId),
        isActive: true,
      }),
    ]);

    // Add unread count for current user
    const conversationsWithUnread = conversations.map((conv) => {
      const unread = conv.unreadCount.get(userId) || 0;
      return {
        ...conv.toJSON(),
        myUnreadCount: unread,
      };
    });

    return {
      data: conversationsWithUnread,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  /**
   * Send a message
   */
  async sendMessage(params: SendMessageParams): Promise<IMessage> {
    const { conversationId, senderId, type, content, metadata } = params;

    const conversation = await Conversation.findById(conversationId);
    if (!conversation) {
      throw new NotFoundError('المحادثة غير موجودة');
    }

    // Check if sender is a participant
    const isParticipant = conversation.participants.some(
      (p) => p.toString() === senderId
    );
    if (!isParticipant) {
      throw new ForbiddenError('ليس لديك صلاحية إرسال رسائل في هذه المحادثة');
    }

    // Create message
    const message = await Message.create({
      conversationId: new Types.ObjectId(conversationId),
      senderId: new Types.ObjectId(senderId),
      type,
      content,
      metadata,
    });

    // Update conversation
    conversation.lastMessage = {
      content: type === 'text' ? content : this.getMessagePreview(type),
      senderId: new Types.ObjectId(senderId),
      createdAt: new Date(),
    };

    // Increment unread count for other participants
    conversation.participants.forEach((participantId) => {
      const id = participantId.toString();
      if (id !== senderId) {
        const current = conversation.unreadCount.get(id) || 0;
        conversation.unreadCount.set(id, current + 1);
      }
    });

    await conversation.save();

    // Populate sender info
    const populatedMessage = await Message.findById(message._id).populate(
      'senderId',
      'name avatar'
    );

    // Emit socket event for real-time
    socketService.emitToRoom(
      `conversation:${conversationId}`,
      'message:new',
      populatedMessage
    );

    // Also notify participants individually
    conversation.participants.forEach((participantId) => {
      const id = participantId.toString();
      if (id !== senderId) {
        socketService.emitToUser(id, 'message:notification', {
          conversationId,
          message: populatedMessage,
        });
      }
    });

    return populatedMessage!;
  }

  /**
   * Get messages for a conversation
   */
  async getMessages(params: GetMessagesParams) {
    const { conversationId, userId, page = 1, limit = 50, before } = params;

    // Verify user is participant
    const conversation = await Conversation.findOne({
      _id: new Types.ObjectId(conversationId),
      participants: new Types.ObjectId(userId),
    });

    if (!conversation) {
      throw new NotFoundError('المحادثة غير موجودة أو ليس لديك صلاحية الوصول');
    }

    const skip = (page - 1) * limit;
    const query: Record<string, unknown> = {
      conversationId: new Types.ObjectId(conversationId),
    };

    if (before) {
      query.createdAt = { $lt: before };
    }

    const [messages, total] = await Promise.all([
      Message.find(query)
        .sort({ createdAt: -1 })
        .skip(skip)
        .limit(limit)
        .populate('senderId', 'name avatar'),
      Message.countDocuments(query),
    ]);

    // Return in chronological order
    messages.reverse();

    return {
      data: messages,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  /**
   * Mark messages as read
   */
  async markAsRead(conversationId: string, userId: string): Promise<void> {
    const conversation = await Conversation.findOne({
      _id: new Types.ObjectId(conversationId),
      participants: new Types.ObjectId(userId),
    });

    if (!conversation) {
      throw new NotFoundError('المحادثة غير موجودة');
    }

    // Mark all unread messages as read
    await Message.updateMany(
      {
        conversationId: new Types.ObjectId(conversationId),
        senderId: { $ne: new Types.ObjectId(userId) },
        isRead: false,
      },
      {
        isRead: true,
        readAt: new Date(),
      }
    );

    // Reset unread count
    conversation.unreadCount.set(userId, 0);
    await conversation.save();

    // Notify sender that messages were read
    const otherParticipants = conversation.participants.filter(
      (p) => p.toString() !== userId
    );
    otherParticipants.forEach((participantId) => {
      socketService.emitToUser(participantId.toString(), 'message:read', {
        conversationId,
        readBy: userId,
        readAt: new Date(),
      });
    });
  }

  /**
   * Get total unread count for a user
   */
  async getTotalUnreadCount(userId: string): Promise<number> {
    const conversations = await Conversation.find({
      participants: new Types.ObjectId(userId),
      isActive: true,
    });

    return conversations.reduce((total, conv) => {
      return total + (conv.unreadCount.get(userId) || 0);
    }, 0);
  }

  /**
   * Archive/deactivate conversation
   */
  async archiveConversation(
    conversationId: string,
    userId: string
  ): Promise<void> {
    const conversation = await Conversation.findOne({
      _id: new Types.ObjectId(conversationId),
      participants: new Types.ObjectId(userId),
    });

    if (!conversation) {
      throw new NotFoundError('المحادثة غير موجودة');
    }

    conversation.isActive = false;
    await conversation.save();
  }

  /**
   * Get message preview text for non-text messages
   */
  private getMessagePreview(type: string): string {
    switch (type) {
      case 'image':
        return '📷 صورة';
      case 'voice':
        return '🎤 رسالة صوتية';
      case 'location':
        return '📍 موقع';
      case 'system':
        return 'رسالة نظام';
      default:
        return 'رسالة';
    }
  }
}

export const chatService = new ChatService();
