import Joi from 'joi';
import { Request, Response, NextFunction } from 'express';

// Create review validation
export const createReviewSchema = Joi.object({
  requestId: Joi.string()
    .pattern(/^[0-9a-fA-F]{24}$/)
    .required()
    .messages({
      'string.pattern.base': 'معرف الطلب غير صالح',
      'any.required': 'معرف الطلب مطلوب',
    }),
  score: Joi.number().min(1).max(5).required().messages({
    'number.min': 'التقييم يجب أن يكون بين 1 و 5',
    'number.max': 'التقييم يجب أن يكون بين 1 و 5',
    'any.required': 'التقييم مطلوب',
  }),
  comment: Joi.string().max(1000).optional().messages({
    'string.max': 'التعليق طويل جداً',
  }),
  qualities: Joi.object({
    punctuality: Joi.number().min(1).max(5).optional(),
    professionalism: Joi.number().min(1).max(5).optional(),
    quality: Joi.number().min(1).max(5).optional(),
    cleanliness: Joi.number().min(1).max(5).optional(),
    communication: Joi.number().min(1).max(5).optional(),
  }).optional(),
  images: Joi.array().items(Joi.string().uri()).max(5).optional().messages({
    'array.max': 'يمكنك رفع 5 صور كحد أقصى',
  }),
});

// Update review validation
export const updateReviewSchema = Joi.object({
  comment: Joi.string().max(1000).optional(),
  images: Joi.array().items(Joi.string().uri()).max(5).optional(),
}).min(1);

// Respond to review validation
export const respondToReviewSchema = Joi.object({
  response: Joi.string().min(1).max(500).required().messages({
    'string.empty': 'الرد مطلوب',
    'string.min': 'الرد لا يمكن أن يكون فارغاً',
    'string.max': 'الرد طويل جداً',
    'any.required': 'الرد مطلوب',
  }),
});

// Report review validation
export const reportReviewSchema = Joi.object({
  reason: Joi.string().min(10).max(500).required().messages({
    'string.min': 'سبب الإبلاغ يجب أن يكون 10 أحرف على الأقل',
    'string.max': 'سبب الإبلاغ طويل جداً',
    'any.required': 'سبب الإبلاغ مطلوب',
  }),
});

// Admin toggle visibility validation
export const toggleVisibilitySchema = Joi.object({
  isVisible: Joi.boolean().required().messages({
    'any.required': 'حالة الظهور مطلوبة',
  }),
});

// Query params validation
export const getReviewsQuerySchema = Joi.object({
  page: Joi.number().min(1).default(1),
  limit: Joi.number().min(1).max(50).default(20),
  minScore: Joi.number().min(1).max(5).optional(),
  sortBy: Joi.string().valid('createdAt', 'score').default('createdAt'),
  sortOrder: Joi.string().valid('asc', 'desc').default('desc'),
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

export const validateCreateReview = validate(createReviewSchema);
export const validateUpdateReview = validate(updateReviewSchema);
export const validateRespondToReview = validate(respondToReviewSchema);
export const validateReportReview = validate(reportReviewSchema);
export const validateToggleVisibility = validate(toggleVisibilitySchema);
export const validateGetReviewsQuery = validate(getReviewsQuerySchema, 'query');
