import { Request, Response, NextFunction } from 'express';
import { chatService } from '@services/chat.service';
import { sendSuccess, sendCreated, sendError, sendPaginated } from '@utils/response';
import { StatusCodes } from 'http-status-codes';

/**
 * Get user's conversations
 * GET /api/v1/chat/conversations
 */
export const getConversations = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = req.user!.userId;
    const page = parseInt(req.query.page as string) || 1;
    const limit = parseInt(req.query.limit as string) || 20;

    const result = await chatService.getUserConversations({
      userId,
      page,
      limit,
    });

    return sendPaginated(
      res,
      result.data,
      result.pagination.page,
      result.pagination.limit,
      result.pagination.total,
      'تم جلب المحادثات بنجاح'
    );
  } catch (error) {
    next(error);
  }
};

/**
 * Get single conversation
 * GET /api/v1/chat/conversations/:id
 */
export const getConversation = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = req.user!.userId;
    const conversationId = req.params.id;

    const conversation = await chatService.getConversationById(
      conversationId,
      userId
    );

    if (!conversation) {
      return sendError(res, 'المحادثة غير موجودة', StatusCodes.NOT_FOUND);
    }

    return sendSuccess(res, conversation, 'تم جلب المحادثة بنجاح');
  } catch (error) {
    next(error);
  }
};

/**
 * Create or get conversation for a request
 * POST /api/v1/chat/conversations
 */
export const createConversation = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = req.user!.userId;
    const { requestId, otherUserId } = req.body;

    const conversation = await chatService.getOrCreateConversation({
      requestId,
      participants: [userId, otherUserId],
    });

    // Populate and return
    const populatedConversation = await chatService.getConversationById(
      conversation._id.toString(),
      userId
    );

    return sendCreated(res, populatedConversation, 'تم إنشاء المحادثة بنجاح');
  } catch (error) {
    next(error);
  }
};

/**
 * Get messages for a conversation
 * GET /api/v1/chat/conversations/:id/messages
 */
export const getMessages = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = req.user!.userId;
    const conversationId = req.params.id;
    const page = parseInt(req.query.page as string) || 1;
    const limit = parseInt(req.query.limit as string) || 50;
    const before = req.query.before
      ? new Date(req.query.before as string)
      : undefined;

    const result = await chatService.getMessages({
      conversationId,
      userId,
      page,
      limit,
      before,
    });

    return sendPaginated(
      res,
      result.data,
      result.pagination.page,
      result.pagination.limit,
      result.pagination.total,
      'تم جلب الرسائل بنجاح'
    );
  } catch (error) {
    next(error);
  }
};

/**
 * Send a message
 * POST /api/v1/chat/conversations/:id/messages
 */
export const sendMessage = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = req.user!.userId;
    const conversationId = req.params.id;
    const { type = 'text', content, metadata } = req.body;

    const message = await chatService.sendMessage({
      conversationId,
      senderId: userId,
      type,
      content,
      metadata,
    });

    return sendCreated(res, message, 'تم إرسال الرسالة بنجاح');
  } catch (error) {
    next(error);
  }
};

/**
 * Mark conversation as read
 * PUT /api/v1/chat/conversations/:id/read
 */
export const markAsRead = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = req.user!.userId;
    const conversationId = req.params.id;

    await chatService.markAsRead(conversationId, userId);

    return sendSuccess(res, null, 'تم تحديث حالة القراءة');
  } catch (error) {
    next(error);
  }
};

/**
 * Get total unread count
 * GET /api/v1/chat/unread-count
 */
export const getUnreadCount = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = req.user!.userId;
    const count = await chatService.getTotalUnreadCount(userId);

    return sendSuccess(res, { count }, 'تم جلب عدد الرسائل غير المقروءة');
  } catch (error) {
    next(error);
  }
};

/**
 * Archive conversation
 * DELETE /api/v1/chat/conversations/:id
 */
export const archiveConversation = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = req.user!.userId;
    const conversationId = req.params.id;

    await chatService.archiveConversation(conversationId, userId);

    return sendSuccess(res, null, 'تم أرشفة المحادثة');
  } catch (error) {
    next(error);
  }
};
