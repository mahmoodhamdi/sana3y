import { IUser } from './user';

export type CraftsmanStatus = 'pending' | 'approved' | 'rejected' | 'suspended';
export type PriceType = 'fixed' | 'hourly' | 'quote';

export interface ICraftsmanService {
  categoryId: string;
  subcategories: string[];
  experience: number;
  priceType: PriceType;
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

export interface ICraftsman {
  _id: string;
  userId: string;
  user?: IUser;
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
  serviceZones: string[];
  isOnline: boolean;
  isAvailable: boolean;
  workingHours: IWorkingHour[];
  status: CraftsmanStatus;
  approvedAt?: string;
  approvedBy?: string;
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
  featuredUntil?: string;
  createdAt: string;
  updatedAt: string;
}

export interface IServiceCategory {
  _id: string;
  name: string;
  nameAr: string;
  slug: string;
  icon?: string;
  image?: string;
  description?: string;
  descriptionAr?: string;
  subcategories: ISubcategory[];
  sortOrder: number;
  isActive: boolean;
  isPopular: boolean;
  totalCraftsmen: number;
  totalJobs: number;
  createdAt: string;
  updatedAt: string;
}

export interface ISubcategory {
  _id: string;
  name: string;
  nameAr: string;
  suggestedPrice?: {
    min: number;
    max: number;
  };
}
