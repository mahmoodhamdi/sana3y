import Joi from 'joi';

export const createCategorySchema = Joi.object({
  name: Joi.string().required().min(2).max(100).messages({
    'string.empty': 'اسم الفئة مطلوب',
    'string.min': 'اسم الفئة يجب أن يكون حرفين على الأقل',
    'string.max': 'اسم الفئة يجب ألا يتجاوز 100 حرف',
  }),
  nameAr: Joi.string().required().min(2).max(100).messages({
    'string.empty': 'اسم الفئة بالعربية مطلوب',
    'string.min': 'اسم الفئة بالعربية يجب أن يكون حرفين على الأقل',
    'string.max': 'اسم الفئة بالعربية يجب ألا يتجاوز 100 حرف',
  }),
  slug: Joi.string().optional().lowercase().trim(),
  icon: Joi.string().optional().uri().messages({
    'string.uri': 'رابط الأيقونة غير صالح',
  }),
  image: Joi.string().optional().uri().messages({
    'string.uri': 'رابط الصورة غير صالح',
  }),
  description: Joi.string().optional().max(500).messages({
    'string.max': 'الوصف يجب ألا يتجاوز 500 حرف',
  }),
  descriptionAr: Joi.string().optional().max(500).messages({
    'string.max': 'الوصف بالعربية يجب ألا يتجاوز 500 حرف',
  }),
  sortOrder: Joi.number().optional().min(0).default(0),
  isActive: Joi.boolean().optional().default(true),
  isPopular: Joi.boolean().optional().default(false),
  subcategories: Joi.array()
    .optional()
    .items(
      Joi.object({
        name: Joi.string().required().min(2).max(100),
        nameAr: Joi.string().required().min(2).max(100),
        suggestedPrice: Joi.object({
          min: Joi.number().min(0),
          max: Joi.number().min(0),
        }).optional(),
      })
    )
    .default([]),
});

export const updateCategorySchema = Joi.object({
  name: Joi.string().optional().min(2).max(100).messages({
    'string.min': 'اسم الفئة يجب أن يكون حرفين على الأقل',
    'string.max': 'اسم الفئة يجب ألا يتجاوز 100 حرف',
  }),
  nameAr: Joi.string().optional().min(2).max(100).messages({
    'string.min': 'اسم الفئة بالعربية يجب أن يكون حرفين على الأقل',
    'string.max': 'اسم الفئة بالعربية يجب ألا يتجاوز 100 حرف',
  }),
  slug: Joi.string().optional().lowercase().trim(),
  icon: Joi.string().optional().allow('').uri().messages({
    'string.uri': 'رابط الأيقونة غير صالح',
  }),
  image: Joi.string().optional().allow('').uri().messages({
    'string.uri': 'رابط الصورة غير صالح',
  }),
  description: Joi.string().optional().allow('').max(500).messages({
    'string.max': 'الوصف يجب ألا يتجاوز 500 حرف',
  }),
  descriptionAr: Joi.string().optional().allow('').max(500).messages({
    'string.max': 'الوصف بالعربية يجب ألا يتجاوز 500 حرف',
  }),
  sortOrder: Joi.number().optional().min(0),
  isActive: Joi.boolean().optional(),
  isPopular: Joi.boolean().optional(),
}).min(1);

export const addSubcategorySchema = Joi.object({
  name: Joi.string().required().min(2).max(100).messages({
    'string.empty': 'اسم الفئة الفرعية مطلوب',
    'string.min': 'اسم الفئة الفرعية يجب أن يكون حرفين على الأقل',
    'string.max': 'اسم الفئة الفرعية يجب ألا يتجاوز 100 حرف',
  }),
  nameAr: Joi.string().required().min(2).max(100).messages({
    'string.empty': 'اسم الفئة الفرعية بالعربية مطلوب',
    'string.min': 'اسم الفئة الفرعية بالعربية يجب أن يكون حرفين على الأقل',
    'string.max': 'اسم الفئة الفرعية بالعربية يجب ألا يتجاوز 100 حرف',
  }),
  suggestedPrice: Joi.object({
    min: Joi.number().min(0),
    max: Joi.number().min(0),
  }).optional(),
});

export const updateSubcategorySchema = Joi.object({
  name: Joi.string().optional().min(2).max(100),
  nameAr: Joi.string().optional().min(2).max(100),
  suggestedPrice: Joi.object({
    min: Joi.number().min(0),
    max: Joi.number().min(0),
  }).optional(),
}).min(1);

export const getCategoriesQuerySchema = Joi.object({
  page: Joi.number().optional().min(1).default(1),
  limit: Joi.number().optional().min(1).max(100).default(20),
  sort: Joi.string().optional().valid('name', 'nameAr', 'sortOrder', 'createdAt').default('sortOrder'),
  order: Joi.string().optional().valid('asc', 'desc').default('asc'),
  isActive: Joi.boolean().optional(),
  isPopular: Joi.boolean().optional(),
  search: Joi.string().optional().trim(),
});
