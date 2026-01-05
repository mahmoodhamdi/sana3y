import Joi from 'joi';

// User Roles
const USER_ROLES = {
  CUSTOMER: 'customer',
  CRAFTSMAN: 'craftsman',
  ADMIN: 'admin',
} as const;

/**
 * Email validation schema
 */
const emailSchema = Joi.string()
  .email()
  .lowercase()
  .trim()
  .messages({
    'string.email': 'البريد الإلكتروني غير صالح',
    'string.empty': 'البريد الإلكتروني مطلوب',
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
 * Send verification OTP request validation
 */
export const sendVerificationOTPSchema = Joi.object({
  email: emailSchema.required(),
});

/**
 * Send password reset OTP request validation
 */
export const sendPasswordResetOTPSchema = Joi.object({
  email: emailSchema.required(),
});

/**
 * Verify OTP request validation
 */
export const verifyOtpSchema = Joi.object({
  email: emailSchema.required(),
  code: otpSchema.required(),
  type: Joi.string()
    .valid('verification', 'password_reset')
    .default('verification'),
});

/**
 * Register request validation
 */
export const registerSchema = Joi.object({
  email: emailSchema.required(),
  password: passwordSchema.required().messages({
    'any.required': 'كلمة المرور مطلوبة',
  }),
  name: Joi.string()
    .min(2)
    .max(100)
    .required()
    .messages({
      'string.min': 'الاسم يجب أن يكون حرفين على الأقل',
      'string.max': 'الاسم يجب أن يكون أقل من 100 حرف',
      'any.required': 'الاسم مطلوب',
    }),
  role: Joi.string()
    .valid(USER_ROLES.CUSTOMER, USER_ROLES.CRAFTSMAN)
    .required()
    .messages({
      'any.only': 'نوع الحساب يجب أن يكون عميل أو صنايعي',
      'any.required': 'نوع الحساب مطلوب',
    }),
  otp: otpSchema.required().messages({
    'any.required': 'كود التحقق مطلوب',
  }),
});

/**
 * Login with password request validation
 */
export const loginPasswordSchema = Joi.object({
  email: emailSchema.required(),
  password: Joi.string().required().messages({
    'any.required': 'كلمة المرور مطلوبة',
  }),
});

/**
 * Login with Google request validation
 */
export const loginGoogleSchema = Joi.object({
  idToken: Joi.string().required().messages({
    'any.required': 'Google ID token مطلوب',
  }),
  role: Joi.string()
    .valid(USER_ROLES.CUSTOMER, USER_ROLES.CRAFTSMAN)
    .default(USER_ROLES.CUSTOMER),
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
  email: emailSchema.required(),
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
  avatar: Joi.string().uri().optional(),
});

/**
 * Admin login request validation
 */
export const adminLoginSchema = Joi.object({
  email: emailSchema.required(),
  password: Joi.string().required().messages({
    'any.required': 'كلمة المرور مطلوبة',
  }),
});

/**
 * Check email exists request validation
 */
export const checkEmailSchema = Joi.object({
  email: emailSchema.required(),
});
