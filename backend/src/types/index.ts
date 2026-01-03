import { Request } from 'express';
import { Document, Types } from 'mongoose';

export type UserRole = 'customer' | 'craftsman' | 'admin';

export interface IUser extends Document {
  _id: Types.ObjectId;
  role: UserRole;
  phone: string;
  email?: string;
  password?: string;
  name: string;
  avatar?: string;
  isPhoneVerified: boolean;
  isEmailVerified: boolean;
  isActive: boolean;
  fcmTokens: string[];
  lastLoginAt?: Date;
  createdAt: Date;
  updatedAt: Date;
  comparePassword(candidatePassword: string): Promise<boolean>;
}

export interface ICustomer extends Document {
  _id: Types.ObjectId;
  userId: Types.ObjectId;
  addresses: IAddress[];
  totalRequests: number;
  totalSpent: number;
  favoriteCraftsmen: Types.ObjectId[];
  createdAt: Date;
  updatedAt: Date;
}

export interface IAddress {
  _id: Types.ObjectId;
  label: 'home' | 'work' | 'other';
  name: string;
  address: string;
  area: string;
  city: string;
  landmark?: string;
  location: {
    type: 'Point';
    coordinates: [number, number];
  };
  isDefault: boolean;
}

export interface ICraftsman extends Document {
  _id: Types.ObjectId;
  userId: Types.ObjectId;
  displayName: string;
  bio?: string;
  profileImage?: string;
  coverImage?: string;
  workPhotos: string[];
  whatsapp?: string;
  alternatePhone?: string;
  services: ICraftsmanService[];
  documents: ICraftsmanDocuments;
  address?: string;
  location?: {
    type: 'Point';
    coordinates: [number, number];
  };
  serviceRadius: number;
  serviceZones: Types.ObjectId[];
  isOnline: boolean;
  isAvailable: boolean;
  workingHours: IWorkingHour[];
  status: 'pending' | 'approved' | 'rejected' | 'suspended';
  approvedAt?: Date;
  approvedBy?: Types.ObjectId;
  rejectionReason?: string;
  suspensionReason?: string;
  rating: number;
  totalRatings: number;
  totalJobs: number;
  completedJobs: number;
  cancelledJobs: number;
  responseRate: number;
  responseTime: number;
  totalEarnings: number;
  currentBalance: number;
  commission: number;
  badges: string[];
  isFeatured: boolean;
  featuredUntil?: Date;
  createdAt: Date;
  updatedAt: Date;
}

export interface ICraftsmanService {
  categoryId: Types.ObjectId;
  subcategories: string[];
  experience: number;
  priceType: 'fixed' | 'hourly' | 'quote';
  basePrice?: number;
  description?: string;
}

export interface ICraftsmanDocuments {
  nationalIdFront?: string;
  nationalIdBack?: string;
  nationalIdNumber?: string;
  certificates?: string[];
  commercialRegister?: string;
}

export interface IWorkingHour {
  day: number;
  isWorking: boolean;
  start: string;
  end: string;
}

// Note: AuthenticatedRequest is now defined via global Express namespace extension
// in @middleware/auth.ts. The user property contains DecodedToken from JWT.
// Use req.user?.userId to get user ID, req.user?.role for role, etc.

export interface PaginationQuery {
  page?: number;
  limit?: number;
  sort?: string;
  order?: 'asc' | 'desc';
}

export interface LocationQuery {
  lat?: number;
  lng?: number;
  radius?: number;
}
