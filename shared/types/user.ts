export type UserRole = 'customer' | 'craftsman' | 'admin';

export interface IUser {
  _id: string;
  role: UserRole;
  phone: string;
  email?: string;
  name: string;
  avatar?: string;
  isPhoneVerified: boolean;
  isEmailVerified: boolean;
  isActive: boolean;
  fcmTokens: string[];
  lastLoginAt?: string;
  createdAt: string;
  updatedAt: string;
}

export interface IAddress {
  _id: string;
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

export interface ICustomer {
  _id: string;
  userId: string;
  user?: IUser;
  addresses: IAddress[];
  totalRequests: number;
  totalSpent: number;
  favoriteCraftsmen: string[];
  createdAt: string;
  updatedAt: string;
}
