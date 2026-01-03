import Joi from 'joi';

// Egyptian Phone Regex
const EGYPT_PHONE_REGEX = /^\+20[0-9]{10}$/;

// User Roles
const USER_ROLES = {
  CUSTOMER: 'customer',
  CRAFTSMAN: 'craftsman',
  ADMIN: 'admin',
} as const;

/**
 * Phone validation schema
 */
const phoneSchema = Joi.string()
  .pattern(EGYPT_PHONE_REGEX)
  .messages({
    'string.pattern.base': 'رقم الهاتف غير صالح. يجب أن يكون بالصيغة +20XXXXXXXXXX',
    'string.empty': 'رقم الهاتف مطلوب',
  });

/**
 * Password validation schema
 */
const passwordSchema = Joi.string()
  .min(8)
  .max(128)
  .pattern(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/)
  .messages({
    'string.min': 'كلمة المرور يجب أن تكون 8 أحرف على الأقل',
    'string.max': 'كلمة المرور يجب أن تكون أقل من 128 حرف',
    'string.pattern.base': 'كلمة المرور يجب أن تحتوي على حرف كبير وحرف صغير ورقم',
  });

/**
 * OTP validation schema
 */
const otpSchema = Joi.string()
  .length(6)
  .pattern(/^\d+$/)
  .messages({
    'string.length': 'كود التحقق يجب أن يكون 6 أرقام',
    'string.pattern.base': 'كود التحقق يجب أن يحتوي على أرقام فقط',
  });

/**
 * Send OTP request validation
 */
export const sendOtpSchema = Joi.object({
  phone: phoneSchema.required(),
  type: Joi.string()
    .valid('verification', 'login', 'password_reset')
    .default('verification'),
});

/**
 * Verify OTP request validation
 */
export const verifyOtpSchema = Joi.object({
  phone: phoneSchema.required(),
  code: otpSchema.required(),
  type: Joi.string()
    .valid('verification', 'login', 'password_reset')
    .default('verification'),
});

/**
 * Register request validation
 */
export const registerSchema = Joi.object({
  phone: phoneSchema.required(),
  name: Joi.string()
    .min(2)
    .max(100)
    .required()
    .messages({
      'string.min': 'الاسم يجب أن يكون حرفين على الأقل',
      'string.max': 'الاسم يجب أن يكون أقل من 100 حرف',
      'any.required': 'الاسم مطلوب',
    }),
  email: Joi.string()
    .email()
    .optional()
    .messages({
      'string.email': 'البريد الإلكتروني غير صالح',
    }),
  password: passwordSchema.optional(),
  role: Joi.string()
    .valid(USER_ROLES.CUSTOMER, USER_ROLES.CRAFTSMAN)
    .required()
    .messages({
      'any.only': 'نوع الحساب يجب أن يكون عميل أو صنايعي',
      'any.required': 'نوع الحساب مطلوب',
    }),
});

/**
 * Login with OTP request validation
 */
export const loginOtpSchema = Joi.object({
  phone: phoneSchema.required(),
  otp: otpSchema.required(),
});

/**
 * Login with password request validation
 */
export const loginPasswordSchema = Joi.object({
  phone: phoneSchema.required(),
  password: Joi.string().required().messages({
    'any.required': 'كلمة المرور مطلوبة',
  }),
});

/**
 * Refresh token request validation
 */
export const refreshTokenSchema = Joi.object({
  refreshToken: Joi.string().required().messages({
    'any.required': 'Refresh token مطلوب',
  }),
});

/**
 * Change password request validation
 */
export const changePasswordSchema = Joi.object({
  currentPassword: Joi.string().required().messages({
    'any.required': 'كلمة المرور الحالية مطلوبة',
  }),
  newPassword: passwordSchema.required().messages({
    'any.required': 'كلمة المرور الجديدة مطلوبة',
  }),
});

/**
 * Reset password request validation
 */
export const resetPasswordSchema = Joi.object({
  phone: phoneSchema.required(),
  otp: otpSchema.required(),
  newPassword: passwordSchema.required().messages({
    'any.required': 'كلمة المرور الجديدة مطلوبة',
  }),
});

/**
 * Update profile request validation
 */
export const updateProfileSchema = Joi.object({
  name: Joi.string().min(2).max(100).optional(),
  email: Joi.string().email().optional(),
  avatar: Joi.string().uri().optional(),
});

/**
 * Admin login request validation
 */
export const adminLoginSchema = Joi.object({
  email: Joi.string().email().required().messages({
    'string.email': 'البريد الإلكتروني غير صالح',
    'any.required': 'البريد الإلكتروني مطلوب',
  }),
  password: Joi.string().required().messages({
    'any.required': 'كلمة المرور مطلوبة',
  }),
});
