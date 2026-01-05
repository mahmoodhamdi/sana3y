import Joi from 'joi';
import { Request, Response, NextFunction } from 'express';

// Create conversation validation
export const createConversationSchema = Joi.object({
  requestId: Joi.string()
    .pattern(/^[0-9a-fA-F]{24}$/)
    .required()
    .messages({
      'string.pattern.base': 'معرف الطلب غير صالح',
      'any.required': 'معرف الطلب مطلوب',
    }),
  otherUserId: Joi.string()
    .pattern(/^[0-9a-fA-F]{24}$/)
    .required()
    .messages({
      'string.pattern.base': 'معرف المستخدم غير صالح',
      'any.required': 'معرف المستخدم الآخر مطلوب',
    }),
});

// Send message validation
export const sendMessageSchema = Joi.object({
  type: Joi.string()
    .valid('text', 'image', 'voice', 'location')
    .default('text')
    .messages({
      'any.only': 'نوع الرسالة غير صالح',
    }),
  content: Joi.string().min(1).max(2000).required().messages({
    'string.empty': 'محتوى الرسالة مطلوب',
    'string.min': 'الرسالة لا يمكن أن تكون فارغة',
    'string.max': 'الرسالة طويلة جداً',
    'any.required': 'محتوى الرسالة مطلوب',
  }),
  metadata: Joi.object().optional(),
});

// Query params validation for messages
export const getMessagesQuerySchema = Joi.object({
  page: Joi.number().min(1).default(1),
  limit: Joi.number().min(1).max(100).default(50),
  before: Joi.date().iso().optional(),
});

// Query params validation for conversations
export const getConversationsQuerySchema = Joi.object({
  page: Joi.number().min(1).default(1),
  limit: Joi.number().min(1).max(50).default(20),
});

// Middleware factory
const validate = (
  schema: Joi.ObjectSchema,
  source: 'body' | 'query' | 'params' = 'body'
) => {
  return (req: Request, res: Response, next: NextFunction) => {
    const { error, value } = schema.validate(req[source], {
      abortEarly: false,
      stripUnknown: true,
    });

    if (error) {
      const errors = error.details.map((detail) => ({
        field: detail.path.join('.'),
        message: detail.message,
      }));

      return res.status(400).json({
        success: false,
        message: 'بيانات غير صالحة',
        errors,
      });
    }

    // Apply validated values - use Object.assign for query/params (may be read-only)
    if (source === 'body') {
      req.body = value;
    } else {
      Object.assign(req[source], value);
    }
    next();
  };
};

export const validateCreateConversation = validate(createConversationSchema);
export const validateSendMessage = validate(sendMessageSchema);
export const validateGetMessagesQuery = validate(getMessagesQuerySchema, 'query');
export const validateGetConversationsQuery = validate(
  getConversationsQuerySchema,
  'query'
);
