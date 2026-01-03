import mongoose, { Schema, Model, Document } from 'mongoose';

export interface IOTP extends Document {
  phone: string;
  code: string;
  type: 'verification' | 'login' | 'password_reset';
  attempts: number;
  isVerified: boolean;
  isUsed: boolean;
  expiresAt: Date;
  createdAt: Date;
  updatedAt: Date;
}

const otpSchema = new Schema<IOTP>(
  {
    phone: {
      type: String,
      required: true,
      trim: true,
    },
    code: {
      type: String,
      required: true,
    },
    type: {
      type: String,
      enum: ['verification', 'login', 'password_reset'],
      default: 'verification',
    },
    attempts: {
      type: Number,
      default: 0,
      max: 5,
    },
    isVerified: {
      type: Boolean,
      default: false,
    },
    isUsed: {
      type: Boolean,
      default: false,
    },
    expiresAt: {
      type: Date,
      required: true,
      index: { expires: 0 },
    },
  },
  {
    timestamps: true,
  }
);

// Indexes
otpSchema.index({ phone: 1, type: 1 });
otpSchema.index({ expiresAt: 1 }, { expireAfterSeconds: 0 });

// Static method to generate OTP
otpSchema.statics.generateOTP = async function (
  phone: string,
  type: 'verification' | 'login' | 'password_reset' = 'verification',
  expirationMinutes: number = 5
): Promise<IOTP> {
  // Delete any existing OTPs for this phone and type
  await this.deleteMany({ phone, type });

  // Generate 6-digit OTP
  const code = Math.floor(100000 + Math.random() * 900000).toString();

  // Create expiration date
  const expiresAt = new Date(Date.now() + expirationMinutes * 60 * 1000);

  // Create and save OTP
  const otp = new this({
    phone,
    code,
    type,
    expiresAt,
  });

  await otp.save();
  return otp;
};

// Static method to verify OTP
otpSchema.statics.verifyOTP = async function (
  phone: string,
  code: string,
  type: 'verification' | 'login' | 'password_reset' = 'verification'
): Promise<{ success: boolean; message: string }> {
  const otp = await this.findOne({
    phone,
    type,
    expiresAt: { $gt: new Date() },
  });

  if (!otp) {
    return { success: false, message: 'OTP expired or not found' };
  }

  if (otp.attempts >= 5) {
    await otp.deleteOne();
    return { success: false, message: 'Too many attempts. Please request a new OTP.' };
  }

  if (otp.code !== code) {
    otp.attempts += 1;
    await otp.save();
    return { success: false, message: 'Invalid OTP' };
  }

  // Mark as verified and delete
  otp.isVerified = true;
  await otp.save();
  await otp.deleteOne();

  return { success: true, message: 'OTP verified successfully' };
};

interface OTPModel extends Model<IOTP> {
  generateOTP(
    phone: string,
    type?: 'verification' | 'login' | 'password_reset',
    expirationMinutes?: number
  ): Promise<IOTP>;
  verifyOTP(
    phone: string,
    code: string,
    type?: 'verification' | 'login' | 'password_reset'
  ): Promise<{ success: boolean; message: string }>;
}

const OTP = mongoose.model<IOTP, OTPModel>('OTP', otpSchema);

export default OTP;
