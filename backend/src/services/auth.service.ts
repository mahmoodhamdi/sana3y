import User, { IUser } from '@models/User';
import Customer from '@models/Customer';
import Craftsman from '@models/Craftsman';
import OTP from '@models/OTP';
import { generateOtp, generateDevOtp, verifyOtpHash, isOtpExpired } from '@utils/otp';
import { generateTokens, TokenPayload, verifyRefreshToken, AuthTokens } from '@utils/jwt';
import { sendOtpSms, sendWelcomeSms } from '@utils/sms';
import { formatPhone } from '@utils/phone';
import { BadRequestError, UnauthorizedError, NotFoundError, ConflictError } from '@utils/errors';
import { config } from '@config/index';

// User roles
const USER_ROLES = {
  CUSTOMER: 'customer',
  CRAFTSMAN: 'craftsman',
  ADMIN: 'admin',
} as const;

// Register request type
export interface RegisterRequest {
  phone: string;
  name: string;
  role: 'customer' | 'craftsman';
  email?: string;
  password?: string;
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
   * Send OTP to phone number
   */
  async sendOtp(
    phone: string,
    type: 'verification' | 'login' | 'password_reset' = 'verification'
  ): Promise<OtpSendResult> {
    const formattedPhone = formatPhone(phone);

    // Check for existing user for login/password_reset
    if (type === 'login' || type === 'password_reset') {
      const existingUser = await User.findOne({ phone: formattedPhone });
      if (!existingUser) {
        throw new NotFoundError('لم يتم العثور على حساب بهذا الرقم');
      }
    }

    // Check for existing user for verification (registration)
    if (type === 'verification') {
      const existingUser = await User.findOne({ phone: formattedPhone });
      if (existingUser && existingUser.isPhoneVerified) {
        throw new ConflictError('هذا الرقم مسجل بالفعل');
      }
    }

    // Generate OTP (use dev OTP in development mode)
    const otpData = config.env === 'development'
      ? generateDevOtp(formattedPhone)
      : generateOtp(formattedPhone);

    // Save OTP to database
    await OTP.create({
      phone: formattedPhone,
      code: otpData.hash,
      type,
      expiresAt: otpData.expiresAt,
    });

    // Send SMS (skipped in development)
    if (config.env !== 'development') {
      await sendOtpSms(formattedPhone, otpData.code);
    }

    const result: OtpSendResult = {
      success: true,
      message: 'تم إرسال كود التحقق بنجاح',
      expiresAt: otpData.expiresAt,
    };

    // Include code in development for testing
    if (config.env === 'development') {
      result.code = otpData.code;
    }

    return result;
  }

  /**
   * Verify OTP code
   */
  async verifyOtp(
    phone: string,
    code: string,
    type: 'verification' | 'login' | 'password_reset' = 'verification'
  ): Promise<boolean> {
    const formattedPhone = formatPhone(phone);

    // Find the latest OTP for this phone and type
    const otpRecord = await OTP.findOne({
      phone: formattedPhone,
      type,
      isUsed: false,
    }).sort({ createdAt: -1 });

    if (!otpRecord) {
      throw new BadRequestError('كود التحقق غير صالح أو منتهي الصلاحية');
    }

    // Check expiration
    if (isOtpExpired(otpRecord.expiresAt)) {
      throw new BadRequestError('كود التحقق منتهي الصلاحية');
    }

    // Verify the code
    if (!verifyOtpHash(code, formattedPhone, otpRecord.code)) {
      // Increment attempts
      otpRecord.attempts += 1;
      await otpRecord.save();

      if (otpRecord.attempts >= 5) {
        otpRecord.isUsed = true;
        await otpRecord.save();
        throw new BadRequestError('تم تجاوز عدد المحاولات المسموحة');
      }

      throw new BadRequestError('كود التحقق غير صحيح');
    }

    // Mark OTP as used
    otpRecord.isUsed = true;
    await otpRecord.save();

    return true;
  }

  /**
   * Register a new user
   */
  async register(data: RegisterRequest): Promise<AuthResult> {
    const formattedPhone = formatPhone(data.phone);

    // Check if user already exists
    const existingUser = await User.findOne({ phone: formattedPhone });
    if (existingUser && existingUser.isPhoneVerified) {
      throw new ConflictError('هذا الرقم مسجل بالفعل');
    }

    // Create or update user
    let user;

    if (existingUser) {
      // Update existing unverified user
      existingUser.name = data.name;
      existingUser.email = data.email;
      existingUser.password = data.password;
      existingUser.role = data.role;
      existingUser.isPhoneVerified = true;
      await existingUser.save();
      user = existingUser;
    } else {
      // Create new user
      user = await User.create({
        phone: formattedPhone,
        name: data.name,
        email: data.email,
        password: data.password,
        role: data.role,
        isPhoneVerified: true,
      });
    }

    // Create role-specific profile
    if (data.role === USER_ROLES.CUSTOMER) {
      await Customer.create({
        userId: user._id,
        addresses: [],
      });
    } else if (data.role === USER_ROLES.CRAFTSMAN) {
      await Craftsman.create({
        userId: user._id,
        services: [],
        status: 'pending',
      });
    }

    // Generate tokens
    const tokenPayload: TokenPayload = {
      userId: user._id.toString(),
      role: user.role,
      phone: user.phone,
    };
    const tokens = generateTokens(tokenPayload);

    // Send welcome SMS
    if (config.env !== 'development') {
      await sendWelcomeSms(formattedPhone, data.name);
    }

    return { user: user.toObject(), tokens };
  }

  /**
   * Login with OTP
   */
  async loginWithOtp(phone: string, otp: string): Promise<AuthResult> {
    const formattedPhone = formatPhone(phone);

    // Verify OTP first
    await this.verifyOtp(formattedPhone, otp, 'login');

    // Find user
    const user = await User.findOne({ phone: formattedPhone });
    if (!user) {
      throw new NotFoundError('لم يتم العثور على حساب بهذا الرقم');
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
      phone: user.phone,
    };
    const tokens = generateTokens(tokenPayload);

    return { user: user.toObject(), tokens };
  }

  /**
   * Login with password
   */
  async loginWithPassword(phone: string, password: string): Promise<AuthResult> {
    const formattedPhone = formatPhone(phone);

    // Find user
    const user = await User.findOne({ phone: formattedPhone }).select('+password');
    if (!user) {
      throw new UnauthorizedError('رقم الهاتف أو كلمة المرور غير صحيحة');
    }

    if (!user.password) {
      throw new BadRequestError('لم يتم تعيين كلمة مرور. استخدم تسجيل الدخول بالكود');
    }

    // Verify password
    const isValidPassword = await user.comparePassword(password);
    if (!isValidPassword) {
      throw new UnauthorizedError('رقم الهاتف أو كلمة المرور غير صحيحة');
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
      phone: user.phone,
    };
    const tokens = generateTokens(tokenPayload);

    return { user: user.toObject(), tokens };
  }

  /**
   * Admin login
   */
  async adminLogin(email: string, password: string): Promise<AuthResult> {
    // Find admin user
    const user = await User.findOne({
      email: email.toLowerCase(),
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
      phone: user.phone,
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
        phone: user.phone,
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
  }

  /**
   * Reset password with OTP
   */
  async resetPassword(phone: string, otp: string, newPassword: string): Promise<void> {
    const formattedPhone = formatPhone(phone);

    // Verify OTP
    await this.verifyOtp(formattedPhone, otp, 'password_reset');

    // Find and update user
    const user = await User.findOne({ phone: formattedPhone });
    if (!user) {
      throw new NotFoundError('لم يتم العثور على حساب بهذا الرقم');
    }

    user.password = newPassword;
    await user.save();
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
    data: { name?: string; email?: string; avatar?: string }
  ): Promise<IUser> {
    const user = await User.findById(userId);
    if (!user) {
      throw new NotFoundError('المستخدم غير موجود');
    }

    if (data.name) user.name = data.name;
    if (data.email) user.email = data.email;
    if (data.avatar) user.avatar = data.avatar;

    await user.save();
    return user.toObject();
  }
}

export const authService = new AuthService();
