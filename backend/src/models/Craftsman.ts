import mongoose, { Schema, Model } from 'mongoose';
import { ICraftsman, ICraftsmanService, ICraftsmanDocuments, IWorkingHour } from '../types';

const workingHourSchema = new Schema<IWorkingHour>(
  {
    day: {
      type: Number,
      required: true,
      min: 0,
      max: 6,
    },
    isWorking: {
      type: Boolean,
      default: true,
    },
    start: {
      type: String,
      default: '08:00',
    },
    end: {
      type: String,
      default: '20:00',
    },
  },
  { _id: false }
);

const craftsmanServiceSchema = new Schema<ICraftsmanService>(
  {
    categoryId: {
      type: Schema.Types.ObjectId,
      ref: 'ServiceCategory',
      required: true,
    },
    subcategories: {
      type: [String],
      default: [],
    },
    experience: {
      type: Number,
      default: 0,
      min: 0,
    },
    priceType: {
      type: String,
      enum: ['fixed', 'hourly', 'quote'],
      default: 'quote',
    },
    basePrice: {
      type: Number,
      min: 0,
    },
    description: {
      type: String,
      trim: true,
    },
  },
  { _id: false }
);

const documentsSchema = new Schema<ICraftsmanDocuments>(
  {
    nationalIdFront: String,
    nationalIdBack: String,
    nationalIdNumber: {
      type: String,
      match: [/^[0-9]{14}$/, 'Please provide a valid 14-digit national ID number'],
    },
    certificates: {
      type: [String],
      default: [],
    },
    commercialRegister: String,
  },
  { _id: false }
);

const craftsmanSchema = new Schema<ICraftsman>(
  {
    userId: {
      type: Schema.Types.ObjectId,
      ref: 'User',
      required: true,
      unique: true,
    },
    displayName: {
      type: String,
      required: true,
      trim: true,
      minlength: [2, 'Display name must be at least 2 characters'],
      maxlength: [100, 'Display name cannot exceed 100 characters'],
    },
    bio: {
      type: String,
      trim: true,
      maxlength: [500, 'Bio cannot exceed 500 characters'],
    },
    profileImage: String,
    coverImage: String,
    workPhotos: {
      type: [String],
      default: [],
      validate: {
        validator: function (photos: string[]) {
          return photos.length <= 10;
        },
        message: 'Cannot have more than 10 work photos',
      },
    },
    whatsapp: {
      type: String,
      trim: true,
    },
    alternatePhone: {
      type: String,
      trim: true,
    },
    services: {
      type: [craftsmanServiceSchema],
      required: true,
      validate: {
        validator: function (services: ICraftsmanService[]) {
          return services.length > 0;
        },
        message: 'At least one service is required',
      },
    },
    documents: {
      type: documentsSchema,
      default: {},
    },
    address: {
      type: String,
      trim: true,
    },
    location: {
      type: {
        type: String,
        enum: ['Point'],
        default: 'Point',
      },
      coordinates: {
        type: [Number],
        validate: {
          validator: function (coords: number[]) {
            return coords.length === 2;
          },
          message: 'Coordinates must be [longitude, latitude]',
        },
      },
    },
    serviceRadius: {
      type: Number,
      default: 10,
      min: 1,
      max: 100,
    },
    serviceZones: {
      type: [Schema.Types.ObjectId],
      ref: 'Zone',
      default: [],
    },
    isOnline: {
      type: Boolean,
      default: false,
    },
    isAvailable: {
      type: Boolean,
      default: true,
    },
    workingHours: {
      type: [workingHourSchema],
      default: () => [
        { day: 0, isWorking: false, start: '08:00', end: '20:00' },
        { day: 1, isWorking: true, start: '08:00', end: '20:00' },
        { day: 2, isWorking: true, start: '08:00', end: '20:00' },
        { day: 3, isWorking: true, start: '08:00', end: '20:00' },
        { day: 4, isWorking: true, start: '08:00', end: '20:00' },
        { day: 5, isWorking: true, start: '08:00', end: '20:00' },
        { day: 6, isWorking: true, start: '08:00', end: '20:00' },
      ],
    },
    status: {
      type: String,
      enum: ['pending', 'approved', 'rejected', 'suspended'],
      default: 'pending',
    },
    approvedAt: Date,
    approvedBy: {
      type: Schema.Types.ObjectId,
      ref: 'User',
    },
    rejectionReason: String,
    suspensionReason: String,
    rating: {
      type: Number,
      default: 0,
      min: 0,
      max: 5,
    },
    totalRatings: {
      type: Number,
      default: 0,
      min: 0,
    },
    totalJobs: {
      type: Number,
      default: 0,
      min: 0,
    },
    completedJobs: {
      type: Number,
      default: 0,
      min: 0,
    },
    cancelledJobs: {
      type: Number,
      default: 0,
      min: 0,
    },
    responseRate: {
      type: Number,
      default: 0,
      min: 0,
      max: 100,
    },
    responseTime: {
      type: Number,
      default: 0,
      min: 0,
    },
    totalEarnings: {
      type: Number,
      default: 0,
      min: 0,
    },
    currentBalance: {
      type: Number,
      default: 0,
      min: 0,
    },
    commission: {
      type: Number,
      default: 15,
      min: 0,
      max: 100,
    },
    badges: {
      type: [String],
      default: [],
    },
    isFeatured: {
      type: Boolean,
      default: false,
    },
    featuredUntil: Date,
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
craftsmanSchema.index({ userId: 1 });
craftsmanSchema.index({ location: '2dsphere' });
craftsmanSchema.index({ 'services.categoryId': 1 });
craftsmanSchema.index({ status: 1 });
craftsmanSchema.index({ rating: -1 });
craftsmanSchema.index({ isOnline: 1, isAvailable: 1, status: 1 });
craftsmanSchema.index({ createdAt: -1 });

// Virtual for user details
craftsmanSchema.virtual('user', {
  ref: 'User',
  localField: 'userId',
  foreignField: '_id',
  justOne: true,
});

// Virtual for completion rate
craftsmanSchema.virtual('completionRate').get(function () {
  if (this.totalJobs === 0) return 0;
  return Math.round((this.completedJobs / this.totalJobs) * 100);
});

// Method to check if craftsman is currently working
craftsmanSchema.methods.isCurrentlyWorking = function (): boolean {
  const now = new Date();
  const day = now.getDay();
  const currentTime = now.toTimeString().slice(0, 5);

  const todayHours = this.workingHours.find((wh: IWorkingHour) => wh.day === day);
  if (!todayHours || !todayHours.isWorking) return false;

  return currentTime >= todayHours.start && currentTime <= todayHours.end;
};

// Method to update rating
craftsmanSchema.methods.updateRating = function (newRating: number): void {
  const totalScore = this.rating * this.totalRatings + newRating;
  this.totalRatings += 1;
  this.rating = Math.round((totalScore / this.totalRatings) * 10) / 10;
};

const Craftsman: Model<ICraftsman> = mongoose.model<ICraftsman>('Craftsman', craftsmanSchema);

export default Craftsman;
