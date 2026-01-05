import Joi from 'joi';
import { Request, Response, NextFunction } from 'express';

const locationSchema = Joi.object({
  address: Joi.string().required().messages({
    'string.empty': 'العنوان مطلوب',
    'any.required': 'العنوان مطلوب',
  }),
  coordinates: Joi.array()
    .items(Joi.number())
    .length(2)
    .required()
    .messages({
      'array.length': 'إحداثيات الموقع يجب أن تكون زوج من الأرقام',
      'any.required': 'إحداثيات الموقع مطلوبة',
    }),
  governorate: Joi.string().required().messages({
    'string.empty': 'المحافظة مطلوبة',
    'any.required': 'المحافظة مطلوبة',
  }),
  city: Joi.string().required().messages({
    'string.empty': 'المدينة مطلوبة',
    'any.required': 'المدينة مطلوبة',
  }),
  area: Joi.string().optional(),
});

const budgetSchema = Joi.object({
  min: Joi.number().min(0).required(),
  max: Joi.number().min(Joi.ref('min')).required(),
});

const preferredTimeSchema = Joi.object({
  start: Joi.string()
    .pattern(/^([01]\d|2[0-3]):([0-5]\d)$/)
    .required(),
  end: Joi.string()
    .pattern(/^([01]\d|2[0-3]):([0-5]\d)$/)
    .required(),
});

// Create request validation
export const createRequestSchema = Joi.object({
  title: Joi.string().min(5).max(100).required().messages({
    'string.min': 'عنوان الطلب يجب أن يكون 5 أحرف على الأقل',
    'string.max': 'عنوان الطلب يجب أن لا يتجاوز 100 حرف',
    'any.required': 'عنوان الطلب مطلوب',
  }),
  description: Joi.string().min(20).max(1000).required().messages({
    'string.min': 'وصف الطلب يجب أن يكون 20 حرف على الأقل',
    'string.max': 'وصف الطلب يجب أن لا يتجاوز 1000 حرف',
    'any.required': 'وصف الطلب مطلوب',
  }),
  category: Joi.string()
    .pattern(/^[0-9a-fA-F]{24}$/)
    .required()
    .messages({
      'string.pattern.base': 'معرف الفئة غير صالح',
      'any.required': 'الفئة مطلوبة',
    }),
  subcategory: Joi.string()
    .pattern(/^[0-9a-fA-F]{24}$/)
    .optional(),
  location: locationSchema.required(),
  preferredDate: Joi.date().min('now').optional().messages({
    'date.min': 'التاريخ المفضل يجب أن يكون في المستقبل',
  }),
  preferredTime: preferredTimeSchema.optional(),
  images: Joi.array().items(Joi.string().uri()).max(5).optional().messages({
    'array.max': 'يمكنك رفع 5 صور كحد أقصى',
  }),
  budget: budgetSchema.optional(),
  urgency: Joi.string()
    .valid('normal', 'urgent', 'emergency')
    .default('normal')
    .messages({
      'any.only': 'مستوى الأهمية غير صالح',
    }),
});

// Update request validation
export const updateRequestSchema = Joi.object({
  title: Joi.string().min(5).max(100).optional(),
  description: Joi.string().min(20).max(1000).optional(),
  preferredDate: Joi.date().min('now').optional(),
  preferredTime: preferredTimeSchema.optional(),
  images: Joi.array().items(Joi.string().uri()).max(5).optional(),
  budget: budgetSchema.optional(),
  urgency: Joi.string().valid('normal', 'urgent', 'emergency').optional(),
}).min(1);

// Submit quote validation
export const submitQuoteSchema = Joi.object({
  amount: Joi.number().min(1).required().messages({
    'number.min': 'المبلغ يجب أن يكون أكبر من صفر',
    'any.required': 'المبلغ مطلوب',
  }),
  estimatedDuration: Joi.string().max(100).optional().messages({
    'string.max': 'مدة العمل المتوقعة طويلة جداً',
  }),
  notes: Joi.string().max(500).optional().messages({
    'string.max': 'الملاحظات طويلة جداً',
  }),
  validUntil: Joi.date().min('now').optional().messages({
    'date.min': 'تاريخ صلاحية العرض يجب أن يكون في المستقبل',
  }),
});

// Update status validation
export const updateStatusSchema = Joi.object({
  status: Joi.string()
    .valid(
      'pending',
      'quoted',
      'accepted',
      'in_progress',
      'arrived',
      'completed',
      'cancelled',
      'disputed',
      'refunded'
    )
    .required()
    .messages({
      'any.only': 'حالة الطلب غير صالحة',
      'any.required': 'حالة الطلب مطلوبة',
    }),
  cancellationReason: Joi.string().max(500).optional(),
  completionNotes: Joi.string().max(500).optional(),
  disputeReason: Joi.string().max(500).optional(),
  actualAmount: Joi.number().min(0).optional(),
});

// Cancel request validation
export const cancelRequestSchema = Joi.object({
  reason: Joi.string().max(500).optional(),
});

// Query params validation
export const getRequestsQuerySchema = Joi.object({
  page: Joi.number().min(1).default(1),
  limit: Joi.number().min(1).max(50).default(20),
  status: Joi.alternatives()
    .try(
      Joi.string(),
      Joi.array().items(Joi.string())
    )
    .optional(),
  category: Joi.string().optional(),
  governorate: Joi.string().optional(),
  city: Joi.string().optional(),
  urgency: Joi.string().valid('normal', 'urgent', 'emergency').optional(),
  dateFrom: Joi.date().optional(),
  dateTo: Joi.date().optional(),
  search: Joi.string().max(100).optional(),
  sortBy: Joi.string()
    .valid('createdAt', 'updatedAt', 'urgency')
    .default('createdAt'),
  sortOrder: Joi.string().valid('asc', 'desc').default('desc'),
});

// Middleware factory
const validate = (schema: Joi.ObjectSchema, source: 'body' | 'query' | 'params' = 'body') => {
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

export const validateCreateRequest = validate(createRequestSchema);
export const validateUpdateRequest = validate(updateRequestSchema);
export const validateSubmitQuote = validate(submitQuoteSchema);
export const validateUpdateStatus = validate(updateStatusSchema);
export const validateCancelRequest = validate(cancelRequestSchema);
export const validateGetRequestsQuery = validate(getRequestsQuerySchema, 'query');
