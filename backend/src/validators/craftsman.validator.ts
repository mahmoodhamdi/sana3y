import Joi from 'joi';

const serviceSchema = Joi.object({
  categoryId: Joi.string().required().messages({
    'string.empty': 'معرف الفئة مطلوب',
  }),
  subcategories: Joi.array().items(Joi.string()).default([]),
  experience: Joi.number().min(0).default(0),
  priceType: Joi.string().valid('fixed', 'hourly', 'quote').default('quote'),
  basePrice: Joi.number().min(0).optional(),
  description: Joi.string().max(500).optional(),
});

const workingHourSchema = Joi.object({
  day: Joi.number().min(0).max(6).required(),
  isWorking: Joi.boolean().default(true),
  start: Joi.string().pattern(/^([01]?[0-9]|2[0-3]):[0-5][0-9]$/).default('08:00'),
  end: Joi.string().pattern(/^([01]?[0-9]|2[0-3]):[0-5][0-9]$/).default('20:00'),
});

const documentsSchema = Joi.object({
  nationalIdFront: Joi.string().optional(),
  nationalIdBack: Joi.string().optional(),
  nationalIdNumber: Joi.string().pattern(/^[0-9]{14}$/).optional().messages({
    'string.pattern.base': 'رقم البطاقة يجب أن يكون 14 رقم',
  }),
  certificates: Joi.array().items(Joi.string()).default([]),
  commercialRegister: Joi.string().optional(),
});

export const createCraftsmanProfileSchema = Joi.object({
  displayName: Joi.string().required().min(2).max(100).messages({
    'string.empty': 'اسم العرض مطلوب',
    'string.min': 'اسم العرض يجب أن يكون حرفين على الأقل',
    'string.max': 'اسم العرض يجب ألا يتجاوز 100 حرف',
  }),
  bio: Joi.string().max(500).optional(),
  whatsapp: Joi.string().optional(),
  alternatePhone: Joi.string().optional(),
  services: Joi.array().items(serviceSchema).min(1).required().messages({
    'array.min': 'يجب إضافة خدمة واحدة على الأقل',
    'any.required': 'الخدمات مطلوبة',
  }),
  address: Joi.string().optional(),
  location: Joi.object({
    type: Joi.string().valid('Point').default('Point'),
    coordinates: Joi.array().length(2).items(Joi.number()).optional(),
  }).optional(),
  serviceRadius: Joi.number().min(1).max(100).default(10),
  serviceZones: Joi.array().items(Joi.string()).default([]),
  workingHours: Joi.array().items(workingHourSchema).length(7).optional(),
  documents: documentsSchema.optional(),
});

export const updateCraftsmanProfileSchema = Joi.object({
  displayName: Joi.string().min(2).max(100).optional(),
  bio: Joi.string().max(500).optional().allow(''),
  profileImage: Joi.string().optional().allow(''),
  coverImage: Joi.string().optional().allow(''),
  workPhotos: Joi.array().items(Joi.string()).max(10).optional(),
  whatsapp: Joi.string().optional().allow(''),
  alternatePhone: Joi.string().optional().allow(''),
  services: Joi.array().items(serviceSchema).min(1).optional(),
  address: Joi.string().optional().allow(''),
  location: Joi.object({
    type: Joi.string().valid('Point').default('Point'),
    coordinates: Joi.array().length(2).items(Joi.number()).optional(),
  }).optional(),
  serviceRadius: Joi.number().min(1).max(100).optional(),
  serviceZones: Joi.array().items(Joi.string()).optional(),
  workingHours: Joi.array().items(workingHourSchema).length(7).optional(),
  isAvailable: Joi.boolean().optional(),
  documents: documentsSchema.optional(),
}).min(1);

export const updateCraftsmanStatusSchema = Joi.object({
  status: Joi.string().valid('approved', 'rejected', 'suspended').required().messages({
    'any.only': 'الحالة يجب أن تكون approved أو rejected أو suspended',
    'any.required': 'الحالة مطلوبة',
  }),
  rejectionReason: Joi.string().when('status', {
    is: 'rejected',
    then: Joi.required().messages({ 'any.required': 'سبب الرفض مطلوب' }),
    otherwise: Joi.optional(),
  }),
  suspensionReason: Joi.string().when('status', {
    is: 'suspended',
    then: Joi.required().messages({ 'any.required': 'سبب الإيقاف مطلوب' }),
    otherwise: Joi.optional(),
  }),
});

export const getCraftsmenQuerySchema = Joi.object({
  page: Joi.number().min(1).default(1),
  limit: Joi.number().min(1).max(50).default(20),
  sort: Joi.string().valid('rating', 'completedJobs', 'responseTime', 'createdAt').default('rating'),
  order: Joi.string().valid('asc', 'desc').default('desc'),
  categoryId: Joi.string().optional(),
  subcategory: Joi.string().optional(),
  status: Joi.string().valid('pending', 'approved', 'rejected', 'suspended').optional(),
  isOnline: Joi.boolean().optional(),
  isAvailable: Joi.boolean().optional(),
  isFeatured: Joi.boolean().optional(),
  minRating: Joi.number().min(0).max(5).optional(),
  search: Joi.string().optional(),
  lat: Joi.number().min(-90).max(90).optional(),
  lng: Joi.number().min(-180).max(180).optional(),
  radius: Joi.number().min(1).max(100).optional(),
  zoneId: Joi.string().optional(),
});

export const toggleOnlineSchema = Joi.object({
  isOnline: Joi.boolean().required().messages({
    'any.required': 'حالة الاتصال مطلوبة',
  }),
});

export const toggleAvailabilitySchema = Joi.object({
  isAvailable: Joi.boolean().required().messages({
    'any.required': 'حالة التوفر مطلوبة',
  }),
});
