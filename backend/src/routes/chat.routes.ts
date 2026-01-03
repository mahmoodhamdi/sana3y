import { Router } from 'express';
import { authenticate } from '@middleware/auth';
import {
  getConversations,
  getConversation,
  createConversation,
  getMessages,
  sendMessage,
  markAsRead,
  getUnreadCount,
  archiveConversation,
} from '@controllers/chat.controller';
import {
  validateCreateConversation,
  validateSendMessage,
  validateGetMessagesQuery,
  validateGetConversationsQuery,
} from '@validators/chat.validator';

const router = Router();

// All routes require authentication
router.use(authenticate);

/**
 * @route   GET /api/v1/chat/conversations
 * @desc    Get user's conversations list
 * @access  Private
 */
router.get('/conversations', validateGetConversationsQuery, getConversations);

/**
 * @route   GET /api/v1/chat/unread-count
 * @desc    Get total unread messages count
 * @access  Private
 */
router.get('/unread-count', getUnreadCount);

/**
 * @route   POST /api/v1/chat/conversations
 * @desc    Create or get conversation for a request
 * @access  Private
 */
router.post('/conversations', validateCreateConversation, createConversation);

/**
 * @route   GET /api/v1/chat/conversations/:id
 * @desc    Get single conversation
 * @access  Private
 */
router.get('/conversations/:id', getConversation);

/**
 * @route   DELETE /api/v1/chat/conversations/:id
 * @desc    Archive conversation
 * @access  Private
 */
router.delete('/conversations/:id', archiveConversation);

/**
 * @route   GET /api/v1/chat/conversations/:id/messages
 * @desc    Get messages for a conversation
 * @access  Private
 */
router.get(
  '/conversations/:id/messages',
  validateGetMessagesQuery,
  getMessages
);

/**
 * @route   POST /api/v1/chat/conversations/:id/messages
 * @desc    Send a message
 * @access  Private
 */
router.post(
  '/conversations/:id/messages',
  validateSendMessage,
  sendMessage
);

/**
 * @route   PUT /api/v1/chat/conversations/:id/read
 * @desc    Mark conversation as read
 * @access  Private
 */
router.put('/conversations/:id/read', markAsRead);

export default router;
