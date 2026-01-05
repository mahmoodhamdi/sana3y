import User, { IUser } from '@models/User';
import Customer from '@models/Customer';
import Craftsman from '@models/Craftsman';
import OTP from '@models/OTP';
import { generateTokens, TokenPayload, verifyRefreshToken, AuthTokens } from '@utils/jwt';
import { emailService } from '@services/email.service';
import { BadRequestError, UnauthorizedError, NotFoundError, ConflictError } from '@utils/errors';
import { config } from '@config/index';
import admin from 'firebase-admin';

// User roles
const USER_ROLES = {
  CUSTOMER: 'customer',
  CRAFTSMAN: 'craftsman',
  ADMIN: 'admin',
} as const;

// Register request type
export interface RegisterRequest {
  email: string;
  password: string;
  name: string;
  role: 'customer' | 'craftsman';
}

export interface AuthResult {
  user: IUser;
  tokens: AuthTokens;
}

export interface OtpSendResult {
  success: boolean;
  message: string;
  expiresAt: Date;
  // Only in development
  code?: string;
}

class AuthService {
  /**
   * Send email verification OTP
   */
  async sendVerificationOTP(email: string): Promise<OtpSendResult> {
    const normalizedEmail = email.toLowerCase().trim();

    // Check if email already exists and verified
    const existingUser = await User.findOne({ email: normalizedEmail });
    if (existingUser && existingUser.isVerified) {
      throw new ConflictError('هذا البريد الإلكتروني مسجل بالفعل');
    }

    // Generate OTP using the model's static method
    const otp = await OTP.generateOTP(normalizedEmail, 'verification', 10);

    // Send OTP via email
    try {
      await emailService.sendOTP({
        to: normalizedEmail,
        otp: otp.code,
        type: 'verification',
      });
    } catch (error) {
      console.error('Failed to send verification email:', error);
      throw new BadRequestError('فشل في إرسال رسالة التحقق. حاول مرة أخرى.');
    }

    const result: OtpSendResult = {
      success: true,
      message: 'تم إرسال كود التحقق إلى بريدك الإلكتروني',
      expiresAt: otp.expiresAt,
    };

    // Include code in development for testing
    if (config.env === 'development') {
      result.code = otp.code;
    }

    return result;
  }

  /**
   * Send password reset OTP
   */
  async sendPasswordResetOTP(email: string): Promise<OtpSendResult> {
    const normalizedEmail = email.toLowerCase().trim();

    // Check if user exists
    const user = await User.findOne({ email: normalizedEmail });
    if (!user) {
      throw new NotFoundError('لم يتم العثور على حساب بهذا البريد الإلكتروني');
    }

    if (user.authProvider === 'google') {
      throw new BadRequestError('هذا الحساب مسجل عبر Google. استخدم تسجيل الدخول بـ Google.');
    }

    // Generate OTP
    const otp = await OTP.generateOTP(normalizedEmail, 'password_reset', 10);

    // Send OTP via email
    try {
      await emailService.sendOTP({
        to: normalizedEmail,
        otp: otp.code,
        type: 'reset',
      });
    } catch (error) {
      console.error('Failed to send reset email:', error);
      throw new BadRequestError('فشل في إرسال رسالة إعادة التعيين. حاول مرة أخرى.');
    }

    const result: OtpSendResult = {
      success: true,
      message: 'تم إرسال كود إعادة التعيين إلى بريدك الإلكتروني',
      expiresAt: otp.expiresAt,
    };

    // Include code in development for testing
    if (config.env === 'development') {
      result.code = otp.code;
    }

    return result;
  }

  /**
   * Verify OTP code
   */
  async verifyOTP(
    email: string,
    code: string,
    type: 'verification' | 'password_reset' = 'verification'
  ): Promise<boolean> {
    const normalizedEmail = email.toLowerCase().trim();
    const result = await OTP.verifyOTP(normalizedEmail, code, type);

    if (!result.success) {
      throw new BadRequestError(
        result.message === 'OTP expired or not found'
          ? 'كود التحقق غير صالح أو منتهي الصلاحية'
          : result.message === 'Too many attempts. Please request a new OTP.'
          ? 'تم تجاوز عدد المحاولات المسموحة. اطلب كود جديد.'
          : 'كود التحقق غير صحيح'
      );
    }

    return true;
  }

  /**
   * Register a new user with email and password
   */
  async register(data: RegisterRequest, otp: string): Promise<AuthResult> {
    const normalizedEmail = data.email.toLowerCase().trim();

    // Verify OTP first
    await this.verifyOTP(normalizedEmail, otp, 'verification');

    // Check if user already exists
    const existingUser = await User.findOne({ email: normalizedEmail });
    if (existingUser && existingUser.isVerified) {
      throw new ConflictError('هذا البريد الإلكتروني مسجل بالفعل');
    }

    // Create or update user
    let user;

    if (existingUser) {
      // Update existing unverified user
      existingUser.name = data.name;
      existingUser.password = data.password;
      existingUser.role = data.role;
      existingUser.authProvider = 'email';
      existingUser.isVerified = true;
      await existingUser.save();
      user = existingUser;
    } else {
      // Create new user
      user = await User.create({
        email: normalizedEmail,
        name: data.name,
        password: data.password,
        role: data.role,
        authProvider: 'email',
        isVerified: true,
      });
    }

    // Create role-specific profile
    if (data.role === USER_ROLES.CUSTOMER) {
      const existingProfile = await Customer.findOne({ userId: user._id });
      if (!existingProfile) {
        await Customer.create({
          userId: user._id,
          addresses: [],
        });
      }
    } else if (data.role === USER_ROLES.CRAFTSMAN) {
      const existingProfile = await Craftsman.findOne({ userId: user._id });
      if (!existingProfile) {
        await Craftsman.create({
          userId: user._id,
          displayName: data.name,
          services: [],
          status: 'pending',
        });
      }
    }

    // Generate tokens
    const tokenPayload: TokenPayload = {
      userId: user._id.toString(),
      role: user.role,
      email: user.email,
    };
    const tokens = generateTokens(tokenPayload);

    // Send welcome email
    try {
      await emailService.sendWelcome(normalizedEmail, data.name);
    } catch (error) {
      console.error('Failed to send welcome email:', error);
    }

    return { user: user.toObject(), tokens };
  }

  /**
   * Login with email and password
   */
  async loginWithPassword(email: string, password: string): Promise<AuthResult> {
    const normalizedEmail = email.toLowerCase().trim();

    // Find user
    const user = await User.findOne({ email: normalizedEmail }).select('+password');
    if (!user) {
      throw new UnauthorizedError('البريد الإلكتروني أو كلمة المرور غير صحيحة');
    }

    if (user.authProvider === 'google') {
      throw new BadRequestError('هذا الحساب مسجل عبر Google. استخدم تسجيل الدخول بـ Google.');
    }

    if (!user.password) {
      throw new BadRequestError('لم يتم تعيين كلمة مرور. استخدم إعادة تعيين كلمة المرور.');
    }

    if (!user.isVerified) {
      throw new UnauthorizedError('يرجى تفعيل حسابك أولاً');
    }

    // Verify password
    const isValidPassword = await user.comparePassword(password);
    if (!isValidPassword) {
      throw new UnauthorizedError('البريد الإلكتروني أو كلمة المرور غير صحيحة');
    }

    if (!user.isActive) {
      throw new UnauthorizedError('حسابك موقوف. تواصل مع الدعم');
    }

    // Update last login
    user.lastLoginAt = new Date();
    await user.save();

    // Generate tokens
    const tokenPayload: TokenPayload = {
      userId: user._id.toString(),
      role: user.role,
      email: user.email,
    };
    const tokens = generateTokens(tokenPayload);

    return { user: user.toObject(), tokens };
  }

  /**
   * Login with Google
   */
  async loginWithGoogle(
    idToken: string,
    role: 'customer' | 'craftsman' = 'customer'
  ): Promise<AuthResult> {
    // Verify Google ID token with Firebase
    let decodedToken;
    try {
      decodedToken = await admin.auth().verifyIdToken(idToken);
    } catch (error) {
      console.error('Google token verification failed:', error);
      throw new UnauthorizedError('فشل التحقق من حساب Google');
    }

    const { email, name, picture, uid } = decodedToken;

    if (!email) {
      throw new BadRequestError('لم يتم العثور على البريد الإلكتروني في حساب Google');
    }

    const normalizedEmail = email.toLowerCase().trim();

    // Check if user exists with this email
    let user = await User.findOne({ email: normalizedEmail });

    if (user) {
      // Existing user - check if they used a different auth provider
      if (user.authProvider === 'email' && !user.googleId) {
        // Link Google account to existing email account
        user.googleId = uid;
        user.authProvider = 'google';
        if (picture && !user.avatar) {
          user.avatar = picture;
        }
        await user.save();
      } else if (user.googleId && user.googleId !== uid) {
        throw new ConflictError('هذا البريد الإلكتروني مرتبط بحساب Google آخر');
      }
    } else {
      // New user - create account
      user = await User.create({
        email: normalizedEmail,
        name: name || email.split('@')[0],
        avatar: picture,
        role,
        authProvider: 'google',
        googleId: uid,
        isVerified: true,
      });

      // Create role-specific profile
      if (role === USER_ROLES.CUSTOMER) {
        await Customer.create({
          userId: user._id,
          addresses: [],
        });
      } else if (role === USER_ROLES.CRAFTSMAN) {
        await Craftsman.create({
          userId: user._id,
          displayName: name || email.split('@')[0],
          services: [],
          status: 'pending',
        });
      }
    }

    if (!user.isActive) {
      throw new UnauthorizedError('حسابك موقوف. تواصل مع الدعم');
    }

    // Update last login
    user.lastLoginAt = new Date();
    await user.save();

    // Generate tokens
    const tokenPayload: TokenPayload = {
      userId: user._id.toString(),
      role: user.role,
      email: user.email,
    };
    const tokens = generateTokens(tokenPayload);

    return { user: user.toObject(), tokens };
  }

  /**
   * Admin login
   */
  async adminLogin(email: string, password: string): Promise<AuthResult> {
    const normalizedEmail = email.toLowerCase().trim();

    // Find admin user
    const user = await User.findOne({
      email: normalizedEmail,
      role: USER_ROLES.ADMIN,
    }).select('+password');

    if (!user) {
      throw new UnauthorizedError('البريد الإلكتروني أو كلمة المرور غير صحيحة');
    }

    if (!user.password) {
      throw new BadRequestError('لم يتم تعيين كلمة مرور');
    }

    // Verify password
    const isValidPassword = await user.comparePassword(password);
    if (!isValidPassword) {
      throw new UnauthorizedError('البريد الإلكتروني أو كلمة المرور غير صحيحة');
    }

    if (!user.isActive) {
      throw new UnauthorizedError('حسابك موقوف');
    }

    // Update last login
    user.lastLoginAt = new Date();
    await user.save();

    // Generate tokens
    const tokenPayload: TokenPayload = {
      userId: user._id.toString(),
      role: user.role,
      email: user.email,
    };
    const tokens = generateTokens(tokenPayload);

    return { user: user.toObject(), tokens };
  }

  /**
   * Refresh access token
   */
  async refreshToken(refreshToken: string): Promise<AuthTokens> {
    try {
      const decoded = verifyRefreshToken(refreshToken);

      // Find user
      const user = await User.findById(decoded.userId);
      if (!user || !user.isActive) {
        throw new UnauthorizedError('جلسة غير صالحة');
      }

      // Generate new tokens
      const tokenPayload: TokenPayload = {
        userId: user._id.toString(),
        role: user.role,
        email: user.email,
      };

      return generateTokens(tokenPayload);
    } catch {
      throw new UnauthorizedError('جلسة منتهية. يرجى تسجيل الدخول مرة أخرى');
    }
  }

  /**
   * Change password
   */
  async changePassword(
    userId: string,
    currentPassword: string,
    newPassword: string
  ): Promise<void> {
    const user = await User.findById(userId).select('+password');
    if (!user) {
      throw new NotFoundError('المستخدم غير موجود');
    }

    if (user.authProvider === 'google') {
      throw new BadRequestError('لا يمكن تغيير كلمة المرور لحساب Google');
    }

    if (!user.password) {
      throw new BadRequestError('لم يتم تعيين كلمة مرور. استخدم إعادة تعيين كلمة المرور');
    }

    // Verify current password
    const isValidPassword = await user.comparePassword(currentPassword);
    if (!isValidPassword) {
      throw new BadRequestError('كلمة المرور الحالية غير صحيحة');
    }

    // Update password
    user.password = newPassword;
    await user.save();

    // Send confirmation email
    try {
      await emailService.sendPasswordChanged(user.email, user.name);
    } catch (error) {
      console.error('Failed to send password changed email:', error);
    }
  }

  /**
   * Reset password with OTP
   */
  async resetPassword(email: string, otp: string, newPassword: string): Promise<void> {
    const normalizedEmail = email.toLowerCase().trim();

    // Verify OTP
    await this.verifyOTP(normalizedEmail, otp, 'password_reset');

    // Find and update user
    const user = await User.findOne({ email: normalizedEmail });
    if (!user) {
      throw new NotFoundError('لم يتم العثور على حساب بهذا البريد الإلكتروني');
    }

    if (user.authProvider === 'google') {
      throw new BadRequestError('لا يمكن تغيير كلمة المرور لحساب Google');
    }

    user.password = newPassword;
    await user.save();

    // Send confirmation email
    try {
      await emailService.sendPasswordChanged(user.email, user.name);
    } catch (error) {
      console.error('Failed to send password changed email:', error);
    }
  }

  /**
   * Get user profile
   */
  async getProfile(userId: string): Promise<IUser> {
    const user = await User.findById(userId);
    if (!user) {
      throw new NotFoundError('المستخدم غير موجود');
    }
    return user.toObject();
  }

  /**
   * Update user profile
   */
  async updateProfile(
    userId: string,
    data: { name?: string; avatar?: string }
  ): Promise<IUser> {
    const user = await User.findById(userId);
    if (!user) {
      throw new NotFoundError('المستخدم غير موجود');
    }

    if (data.name) user.name = data.name;
    if (data.avatar) user.avatar = data.avatar;

    await user.save();
    return user.toObject();
  }

  /**
   * Check if email exists
   */
  async checkEmailExists(email: string): Promise<boolean> {
    const normalizedEmail = email.toLowerCase().trim();
    const user = await User.findOne({ email: normalizedEmail, isVerified: true });
    return !!user;
  }
}

export const authService = new AuthService();
