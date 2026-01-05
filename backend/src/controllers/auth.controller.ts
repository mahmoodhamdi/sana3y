import { Request, Response, NextFunction } from 'express';
import { authService } from '@services/auth.service';
import {
  sendVerificationOTPSchema,
  sendPasswordResetOTPSchema,
  verifyOtpSchema,
  registerSchema,
  loginPasswordSchema,
  loginGoogleSchema,
  refreshTokenSchema,
  changePasswordSchema,
  resetPasswordSchema,
  updateProfileSchema,
  adminLoginSchema,
  checkEmailSchema,
} from '@validators/auth.validator';
import { sendSuccess, sendCreated } from '@utils/response';
import { BadRequestError } from '@utils/errors';

/**
 * Send verification OTP to email
 * POST /api/v1/auth/send-verification-otp
 */
export const sendVerificationOTP = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { error, value } = sendVerificationOTPSchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const result = await authService.sendVerificationOTP(value.email);

    return sendSuccess(res, result, 'تم إرسال كود التحقق بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Send password reset OTP to email
 * POST /api/v1/auth/send-reset-otp
 */
export const sendPasswordResetOTP = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { error, value } = sendPasswordResetOTPSchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const result = await authService.sendPasswordResetOTP(value.email);

    return sendSuccess(res, result, 'تم إرسال كود إعادة التعيين بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Verify OTP code
 * POST /api/v1/auth/verify-otp
 */
export const verifyOtp = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { error, value } = verifyOtpSchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    await authService.verifyOTP(value.email, value.code, value.type);

    return sendSuccess(res, { verified: true }, 'تم التحقق بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Register new user
 * POST /api/v1/auth/register
 */
export const register = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { error, value } = registerSchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const result = await authService.register(
      {
        email: value.email,
        password: value.password,
        name: value.name,
        role: value.role,
      },
      value.otp
    );

    return sendCreated(res, result, 'تم إنشاء الحساب بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Login with email and password
 * POST /api/v1/auth/login
 */
export const loginWithPassword = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { error, value } = loginPasswordSchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const result = await authService.loginWithPassword(value.email, value.password);

    return sendSuccess(res, result, 'تم تسجيل الدخول بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Login with Google
 * POST /api/v1/auth/login/google
 */
export const loginWithGoogle = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { error, value } = loginGoogleSchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const result = await authService.loginWithGoogle(value.idToken, value.role);

    return sendSuccess(res, result, 'تم تسجيل الدخول بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Admin login
 * POST /api/v1/auth/admin/login
 */
export const adminLogin = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { error, value } = adminLoginSchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const result = await authService.adminLogin(value.email, value.password);

    return sendSuccess(res, result, 'تم تسجيل الدخول بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Refresh access token
 * POST /api/v1/auth/refresh
 */
export const refreshToken = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { error, value } = refreshTokenSchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const tokens = await authService.refreshToken(value.refreshToken);

    return sendSuccess(res, tokens, 'تم تجديد الجلسة بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Get current user profile
 * GET /api/v1/auth/me
 */
export const getProfile = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const userId = req.user?.userId;
    if (!userId) {
      throw new BadRequestError('غير مصرح');
    }

    const user = await authService.getProfile(userId);

    return sendSuccess(res, { user }, 'تم جلب البيانات بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Update user profile
 * PUT /api/v1/auth/me
 */
export const updateProfile = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const userId = req.user?.userId;
    if (!userId) {
      throw new BadRequestError('غير مصرح');
    }

    const { error, value } = updateProfileSchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const user = await authService.updateProfile(userId, value);

    return sendSuccess(res, { user }, 'تم تحديث البيانات بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Change password
 * POST /api/v1/auth/change-password
 */
export const changePassword = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const userId = req.user?.userId;
    if (!userId) {
      throw new BadRequestError('غير مصرح');
    }

    const { error, value } = changePasswordSchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    await authService.changePassword(userId, value.currentPassword, value.newPassword);

    return sendSuccess(res, null, 'تم تغيير كلمة المرور بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Reset password with OTP
 * POST /api/v1/auth/reset-password
 */
export const resetPassword = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { error, value } = resetPasswordSchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    await authService.resetPassword(value.email, value.otp, value.newPassword);

    return sendSuccess(res, null, 'تم إعادة تعيين كلمة المرور بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Check if email exists
 * POST /api/v1/auth/check-email
 */
export const checkEmail = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { error, value } = checkEmailSchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const exists = await authService.checkEmailExists(value.email);

    return sendSuccess(res, { exists }, 'تم التحقق بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Logout (client-side token removal)
 * POST /api/v1/auth/logout
 */
export const logout = async (req: Request, res: Response, next: NextFunction) => {
  try {
    // For JWT, logout is handled client-side by removing tokens
    // Here we can optionally blacklist the token or remove FCM tokens
    return sendSuccess(res, null, 'تم تسجيل الخروج بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Switch user role
 * POST /api/v1/auth/switch-role
 */
export const switchRole = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const userId = req.user?.userId;
    if (!userId) {
      throw new BadRequestError('غير مصرح');
    }

    const { role } = req.body;
    if (!role || !['customer', 'craftsman'].includes(role)) {
      throw new BadRequestError('الدور غير صالح');
    }

    const result = await authService.switchRole(userId, role);

    return sendSuccess(res, result, 'تم تغيير الدور بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Get available roles
 * GET /api/v1/auth/roles
 */
export const getAvailableRoles = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const userId = req.user?.userId;
    if (!userId) {
      throw new BadRequestError('غير مصرح');
    }

    const result = await authService.getAvailableRoles(userId);

    return sendSuccess(res, result, 'تم جلب الأدوار المتاحة');
  } catch (err) {
    next(err);
  }
};
