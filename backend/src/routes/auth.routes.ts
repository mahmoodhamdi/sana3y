import { Router } from 'express';
import {
  sendVerificationOTP,
  sendPasswordResetOTP,
  verifyOtp,
  register,
  loginWithPassword,
  loginWithGoogle,
  adminLogin,
  refreshToken,
  getProfile,
  updateProfile,
  changePassword,
  resetPassword,
  checkEmail,
  logout,
  switchRole,
  getAvailableRoles,
} from '@controllers/auth.controller';
import { authenticate } from '@middleware/auth';
import { rateLimiter } from '@middleware/rateLimiter';

const router = Router();

// Rate limiters for auth routes
const otpLimiter = rateLimiter({
  windowMs: 60 * 1000, // 1 minute
  max: 3, // 3 requests per minute
  message: 'تم تجاوز الحد المسموح. حاول مرة أخرى بعد دقيقة',
});

const authLimiter = rateLimiter({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 10, // 10 requests per 15 minutes
  message: 'تم تجاوز الحد المسموح. حاول مرة أخرى لاحقاً',
});

// Public routes - Email OTP
router.post('/send-verification-otp', otpLimiter, sendVerificationOTP);
router.post('/send-reset-otp', otpLimiter, sendPasswordResetOTP);
router.post('/verify-otp', otpLimiter, verifyOtp);

// Public routes - Registration & Login
router.post('/register', authLimiter, register);
router.post('/login', authLimiter, loginWithPassword);
router.post('/login/google', authLimiter, loginWithGoogle);
router.post('/admin/login', authLimiter, adminLogin);
router.post('/refresh', refreshToken);
router.post('/reset-password', authLimiter, resetPassword);
router.post('/check-email', checkEmail);

// Protected routes (require authentication)
router.get('/me', authenticate, getProfile);
router.put('/me', authenticate, updateProfile);
router.post('/change-password', authenticate, changePassword);
router.post('/logout', authenticate, logout);
router.get('/roles', authenticate, getAvailableRoles);
router.post('/switch-role', authenticate, switchRole);

export default router;
