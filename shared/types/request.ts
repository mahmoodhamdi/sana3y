import { ICustomer } from './user';
import { ICraftsman, IServiceCategory } from './craftsman';

export type RequestStatus = 'pending' | 'quoted' | 'accepted' | 'in_progress' | 'completed' | 'cancelled';
export type Urgency = 'urgent' | 'today' | 'scheduled';
export type PaymentMethod = 'cash' | 'card' | 'wallet';
export type PaymentStatus = 'pending' | 'paid' | 'refunded';
export type AssignmentType = 'direct' | 'broadcast';

export interface IQuote {
  craftsmanId: string;
  craftsman?: ICraftsman;
  price: number;
  note?: string;
  estimatedDuration?: string;
  createdAt: string;
}

export interface IStatusHistory {
  status: string;
  timestamp: string;
  note?: string;
  by: string;
}

export interface IRating {
  score: number;
  comment?: string;
  qualities?: string[];
  images?: string[];
  createdAt: string;
  response?: string;
  respondedAt?: string;
}

export interface IRequestAddress {
  address: string;
  area: string;
  city: string;
  landmark?: string;
  location: {
    type: 'Point';
    coordinates: [number, number];
  };
}

export interface IServiceRequest {
  _id: string;
  requestNumber: string;
  customerId: string;
  customer?: ICustomer;
  craftsmanId?: string;
  craftsman?: ICraftsman;
  categoryId: string;
  category?: IServiceCategory;
  subcategory?: string;
  title: string;
  description: string;
  images: string[];
  voiceNote?: string;
  address: IRequestAddress;
  urgency: Urgency;
  scheduledDate?: string;
  scheduledTimeSlot?: string;
  estimatedPrice?: {
    min: number;
    max: number;
  };
  quotedPrice?: number;
  finalPrice?: number;
  status: RequestStatus;
  statusHistory: IStatusHistory[];
  assignmentType: AssignmentType;
  broadcastedTo: string[];
  quotesReceived: IQuote[];
  startedAt?: string;
  completedAt?: string;
  completionNotes?: string;
  completionPhotos: string[];
  isCancelled: boolean;
  cancelledBy?: 'customer' | 'craftsman' | 'admin';
  cancelReason?: string;
  cancelledAt?: string;
  paymentMethod: PaymentMethod;
  paymentStatus: PaymentStatus;
  paidAt?: string;
  serviceFee: number;
  commission: number;
  craftsmanEarnings: number;
  rating?: IRating;
  isUrgent: boolean;
  hasWarranty: boolean;
  warrantyDays: number;
  createdAt: string;
  updatedAt: string;
}

export interface IReview {
  _id: string;
  requestId: string;
  customerId: string;
  customer?: ICustomer;
  craftsmanId: string;
  score: number;
  comment?: string;
  qualities: {
    punctuality?: number;
    professionalism?: number;
    quality?: number;
    cleanliness?: number;
    communication?: number;
  };
  images: string[];
  craftsmanResponse?: string;
  respondedAt?: string;
  isVisible: boolean;
  isReported: boolean;
  reportReason?: string;
  createdAt: string;
  updatedAt: string;
}
