import mongoose, { Schema, Model, Document, Types } from 'mongoose';
import dayjs from 'dayjs';

interface IQuote {
  _id?: Types.ObjectId;
  craftsmanId: Types.ObjectId;
  price: number;
  note?: string;
  estimatedDuration?: string;
  createdAt: Date;
}

interface IStatusHistory {
  status: string;
  timestamp: Date;
  note?: string;
  by: Types.ObjectId;
}

interface IRating {
  score: number;
  comment?: string;
  qualities?: string[];
  images?: string[];
  createdAt: Date;
  response?: string;
  respondedAt?: Date;
}

interface IRequestAddress {
  address: string;
  area: string;
  city: string;
  landmark?: string;
  location: {
    type: 'Point';
    coordinates: [number, number];
  };
}

export interface IServiceRequest extends Document {
  _id: Types.ObjectId;
  requestNumber: string;
  customerId: Types.ObjectId;
  craftsmanId?: Types.ObjectId;
  categoryId: Types.ObjectId;
  subcategory?: string;
  title: string;
  description: string;
  images: string[];
  voiceNote?: string;
  address: IRequestAddress;
  urgency: 'urgent' | 'today' | 'scheduled';
  scheduledDate?: Date;
  scheduledTimeSlot?: string;
  estimatedPrice?: {
    min: number;
    max: number;
  };
  quotedPrice?: number;
  finalPrice?: number;
  status: 'pending' | 'quoted' | 'accepted' | 'in_progress' | 'completed' | 'cancelled';
  statusHistory: IStatusHistory[];
  assignmentType: 'direct' | 'broadcast';
  broadcastedTo: Types.ObjectId[];
  quotesReceived: IQuote[];
  startedAt?: Date;
  completedAt?: Date;
  completionNotes?: string;
  completionPhotos: string[];
  isCancelled: boolean;
  cancelledBy?: 'customer' | 'craftsman' | 'admin';
  cancelReason?: string;
  cancelledAt?: Date;
  paymentMethod: 'cash' | 'card' | 'wallet';
  paymentStatus: 'pending' | 'paid' | 'refunded';
  paidAt?: Date;
  serviceFee: number;
  commission: number;
  craftsmanEarnings: number;
  rating?: IRating;
  isUrgent: boolean;
  hasWarranty: boolean;
  warrantyDays: number;
  createdAt: Date;
  updatedAt: Date;
}

const quoteSchema = new Schema<IQuote>(
  {
    craftsmanId: {
      type: Schema.Types.ObjectId,
      ref: 'Craftsman',
      required: true,
    },
    price: {
      type: Number,
      required: true,
      min: 0,
    },
    note: String,
    estimatedDuration: String,
    createdAt: {
      type: Date,
      default: Date.now,
    },
  },
  { _id: false }
);

const statusHistorySchema = new Schema<IStatusHistory>(
  {
    status: {
      type: String,
      required: true,
    },
    timestamp: {
      type: Date,
      default: Date.now,
    },
    note: String,
    by: {
      type: Schema.Types.ObjectId,
      ref: 'User',
    },
  },
  { _id: false }
);

const ratingSchema = new Schema<IRating>(
  {
    score: {
      type: Number,
      required: true,
      min: 1,
      max: 5,
    },
    comment: String,
    qualities: {
      type: [String],
      default: [],
    },
    images: {
      type: [String],
      default: [],
    },
    createdAt: {
      type: Date,
      default: Date.now,
    },
    response: String,
    respondedAt: Date,
  },
  { _id: false }
);

const requestAddressSchema = new Schema<IRequestAddress>(
  {
    address: {
      type: String,
      required: true,
    },
    area: {
      type: String,
      required: true,
    },
    city: {
      type: String,
      default: 'الباجور',
    },
    landmark: String,
    location: {
      type: {
        type: String,
        enum: ['Point'],
        default: 'Point',
      },
      coordinates: {
        type: [Number],
        required: true,
      },
    },
  },
  { _id: false }
);

const serviceRequestSchema = new Schema<IServiceRequest>(
  {
    requestNumber: {
      type: String,
      unique: true,
      required: true,
    },
    customerId: {
      type: Schema.Types.ObjectId,
      ref: 'Customer',
      required: true,
    },
    craftsmanId: {
      type: Schema.Types.ObjectId,
      ref: 'Craftsman',
    },
    categoryId: {
      type: Schema.Types.ObjectId,
      ref: 'ServiceCategory',
      required: true,
    },
    subcategory: String,
    title: {
      type: String,
      required: true,
      trim: true,
      maxlength: 200,
    },
    description: {
      type: String,
      required: true,
      trim: true,
      maxlength: 2000,
    },
    images: {
      type: [String],
      default: [],
      validate: {
        validator: function (images: string[]) {
          return images.length <= 5;
        },
        message: 'Cannot upload more than 5 images',
      },
    },
    voiceNote: String,
    address: {
      type: requestAddressSchema,
      required: true,
    },
    urgency: {
      type: String,
      enum: ['urgent', 'today', 'scheduled'],
      default: 'today',
    },
    scheduledDate: Date,
    scheduledTimeSlot: String,
    estimatedPrice: {
      min: { type: Number, min: 0 },
      max: { type: Number, min: 0 },
    },
    quotedPrice: {
      type: Number,
      min: 0,
    },
    finalPrice: {
      type: Number,
      min: 0,
    },
    status: {
      type: String,
      enum: ['pending', 'quoted', 'accepted', 'in_progress', 'completed', 'cancelled'],
      default: 'pending',
    },
    statusHistory: {
      type: [statusHistorySchema],
      default: [],
    },
    assignmentType: {
      type: String,
      enum: ['direct', 'broadcast'],
      default: 'broadcast',
    },
    broadcastedTo: {
      type: [Schema.Types.ObjectId],
      ref: 'Craftsman',
      default: [],
    },
    quotesReceived: {
      type: [quoteSchema],
      default: [],
    },
    startedAt: Date,
    completedAt: Date,
    completionNotes: String,
    completionPhotos: {
      type: [String],
      default: [],
    },
    isCancelled: {
      type: Boolean,
      default: false,
    },
    cancelledBy: {
      type: String,
      enum: ['customer', 'craftsman', 'admin'],
    },
    cancelReason: String,
    cancelledAt: Date,
    paymentMethod: {
      type: String,
      enum: ['cash', 'card', 'wallet'],
      default: 'cash',
    },
    paymentStatus: {
      type: String,
      enum: ['pending', 'paid', 'refunded'],
      default: 'pending',
    },
    paidAt: Date,
    serviceFee: {
      type: Number,
      default: 0,
      min: 0,
    },
    commission: {
      type: Number,
      default: 0,
      min: 0,
    },
    craftsmanEarnings: {
      type: Number,
      default: 0,
      min: 0,
    },
    rating: ratingSchema,
    isUrgent: {
      type: Boolean,
      default: false,
    },
    hasWarranty: {
      type: Boolean,
      default: false,
    },
    warrantyDays: {
      type: Number,
      default: 0,
      min: 0,
    },
  },
  {
    timestamps: true,
    toJSON: {
      virtuals: true,
      transform: (_doc, ret: Record<string, unknown>) => {
        ret.__v = undefined;
        return ret;
      },
    },
    toObject: {
      virtuals: true,
    },
  }
);

// Indexes
serviceRequestSchema.index({ requestNumber: 1 });
serviceRequestSchema.index({ customerId: 1 });
serviceRequestSchema.index({ craftsmanId: 1 });
serviceRequestSchema.index({ status: 1 });
serviceRequestSchema.index({ categoryId: 1 });
serviceRequestSchema.index({ createdAt: -1 });
serviceRequestSchema.index({ 'address.location': '2dsphere' });

// Generate request number before saving
serviceRequestSchema.pre('save', async function () {
  if (this.isNew && !this.requestNumber) {
    const date = dayjs().format('YYMMDD');
    const count = await mongoose.model('ServiceRequest').countDocuments({
      createdAt: {
        $gte: dayjs().startOf('day').toDate(),
        $lte: dayjs().endOf('day').toDate(),
      },
    });
    this.requestNumber = `SAN-${date}-${String(count + 1).padStart(4, '0')}`;
  }

  // Add to status history
  if (this.isModified('status')) {
    this.statusHistory.push({
      status: this.status,
      timestamp: new Date(),
      by: this.craftsmanId || this.customerId,
    });
  }
});

// Virtual for customer details
serviceRequestSchema.virtual('customer', {
  ref: 'Customer',
  localField: 'customerId',
  foreignField: '_id',
  justOne: true,
});

// Virtual for craftsman details
serviceRequestSchema.virtual('craftsman', {
  ref: 'Craftsman',
  localField: 'craftsmanId',
  foreignField: '_id',
  justOne: true,
});

// Virtual for category details
serviceRequestSchema.virtual('category', {
  ref: 'ServiceCategory',
  localField: 'categoryId',
  foreignField: '_id',
  justOne: true,
});

const ServiceRequest: Model<IServiceRequest> = mongoose.model<IServiceRequest>(
  'ServiceRequest',
  serviceRequestSchema
);

export default ServiceRequest;
