import mongoose, { Schema, Model, HydratedDocument } from 'mongoose';
import bcrypt from 'bcryptjs';
import { IUser, UserRole, AuthProvider } from '../types';

export type { IUser } from '../types';

interface IUserMethods {
  comparePassword(candidatePassword: string): Promise<boolean>;
}

type UserModel = Model<IUser, object, IUserMethods>;

const userSchema = new Schema<IUser, UserModel, IUserMethods>(
  {
    role: {
      type: String,
      enum: ['customer', 'craftsman', 'admin'] as UserRole[],
      required: true,
      default: 'customer',
    },
    email: {
      type: String,
      required: true,
      unique: true,
      trim: true,
      lowercase: true,
      match: [/^\S+@\S+\.\S+$/, 'Please provide a valid email'],
    },
    password: {
      type: String,
      minlength: [6, 'Password must be at least 6 characters'],
      select: false,
    },
    name: {
      type: String,
      required: true,
      trim: true,
      minlength: [2, 'Name must be at least 2 characters'],
      maxlength: [100, 'Name cannot exceed 100 characters'],
    },
    avatar: {
      type: String,
    },
    // Auth provider
    authProvider: {
      type: String,
      enum: ['email', 'google'] as AuthProvider[],
      required: true,
      default: 'email',
    },
    googleId: {
      type: String,
      unique: true,
      sparse: true,
    },
    // Email verification OTP
    emailOTP: {
      type: String,
    },
    emailOTPExpires: {
      type: Date,
    },
    // Password reset OTP
    resetOTP: {
      type: String,
    },
    resetOTPExpires: {
      type: Date,
    },
    // Status flags
    isVerified: {
      type: Boolean,
      default: false,
    },
    isActive: {
      type: Boolean,
      default: true,
    },
    fcmTokens: {
      type: [String],
      default: [],
    },
    lastLoginAt: {
      type: Date,
    },
  },
  {
    timestamps: true,
    toJSON: {
      virtuals: true,
      transform: (_doc, ret: Record<string, unknown>) => {
        ret.password = undefined;
        ret.__v = undefined;
        return ret;
      },
    },
    toObject: {
      virtuals: true,
    },
  }
);

// Indexes (email and googleId indexes are created by unique: true)
userSchema.index({ role: 1 });
userSchema.index({ authProvider: 1 });
userSchema.index({ createdAt: -1 });

// Hash password before saving
userSchema.pre('save', async function (this: HydratedDocument<IUser>) {
  if (!this.isModified('password') || !this.password) {
    return;
  }

  const salt = await bcrypt.genSalt(12);
  this.password = await bcrypt.hash(this.password, salt);
});

// Compare password method
userSchema.method('comparePassword', async function (candidatePassword: string): Promise<boolean> {
  if (!this.password) {
    return false;
  }
  return bcrypt.compare(candidatePassword, this.password);
});

// Virtual for customer profile
userSchema.virtual('customerProfile', {
  ref: 'Customer',
  localField: '_id',
  foreignField: 'userId',
  justOne: true,
});

// Virtual for craftsman profile
userSchema.virtual('craftsmanProfile', {
  ref: 'Craftsman',
  localField: '_id',
  foreignField: 'userId',
  justOne: true,
});

const User = mongoose.model<IUser, UserModel>('User', userSchema);

export default User;
