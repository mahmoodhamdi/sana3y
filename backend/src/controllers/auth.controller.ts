import { Request, Response, NextFunction } from 'express';
import { authService } from '@services/auth.service';
import {
  sendOtpSchema,
  verifyOtpSchema,
  registerSchema,
  loginOtpSchema,
  loginPasswordSchema,
  refreshTokenSchema,
  changePasswordSchema,
  resetPasswordSchema,
  updateProfileSchema,
  adminLoginSchema,
} from '@validators/auth.validator';
import { sendSuccess, sendCreated } from '@utils/response';
import { BadRequestError } from '@utils/errors';
import { formatPhone } from '@utils/phone';

/**
 * Send OTP to phone number
 * POST /api/v1/auth/send-otp
 */
export const sendOtp = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { error, value } = sendOtpSchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const result = await authService.sendOtp(value.phone, value.type);

    return sendSuccess(res, result, 'تم إرسال كود التحقق بنجاح');
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

    await authService.verifyOtp(value.phone, value.code, value.type);

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

    // Format phone number
    value.phone = formatPhone(value.phone);

    const result = await authService.register(value);

    return sendCreated(res, result, 'تم إنشاء الحساب بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Login with OTP
 * POST /api/v1/auth/login/otp
 */
export const loginWithOtp = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { error, value } = loginOtpSchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const result = await authService.loginWithOtp(value.phone, value.otp);

    return sendSuccess(res, result, 'تم تسجيل الدخول بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Login with password
 * POST /api/v1/auth/login/password
 */
export const loginWithPassword = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { error, value } = loginPasswordSchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const result = await authService.loginWithPassword(value.phone, value.password);

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

    await authService.resetPassword(value.phone, value.otp, value.newPassword);

    return sendSuccess(res, null, 'تم إعادة تعيين كلمة المرور بنجاح');
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
