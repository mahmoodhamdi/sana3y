import mongoose, { Schema, Model, Document, Types } from 'mongoose';

interface IQualityRatings {
  punctuality?: number;
  professionalism?: number;
  quality?: number;
  cleanliness?: number;
  communication?: number;
}

export interface IReview extends Document {
  _id: Types.ObjectId;
  requestId: Types.ObjectId;
  customerId: Types.ObjectId;
  craftsmanId: Types.ObjectId;
  score: number;
  comment?: string;
  qualities: IQualityRatings;
  images: string[];
  craftsmanResponse?: string;
  respondedAt?: Date;
  isVisible: boolean;
  isReported: boolean;
  reportReason?: string;
  createdAt: Date;
  updatedAt: Date;
}

const qualityRatingsSchema = new Schema<IQualityRatings>(
  {
    punctuality: { type: Number, min: 1, max: 5 },
    professionalism: { type: Number, min: 1, max: 5 },
    quality: { type: Number, min: 1, max: 5 },
    cleanliness: { type: Number, min: 1, max: 5 },
    communication: { type: Number, min: 1, max: 5 },
  },
  { _id: false }
);

const reviewSchema = new Schema<IReview>(
  {
    requestId: {
      type: Schema.Types.ObjectId,
      ref: 'ServiceRequest',
      required: true,
      unique: true,
    },
    customerId: {
      type: Schema.Types.ObjectId,
      ref: 'Customer',
      required: true,
    },
    craftsmanId: {
      type: Schema.Types.ObjectId,
      ref: 'Craftsman',
      required: true,
    },
    score: {
      type: Number,
      required: true,
      min: 1,
      max: 5,
    },
    comment: {
      type: String,
      trim: true,
      maxlength: 1000,
    },
    qualities: {
      type: qualityRatingsSchema,
      default: {},
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
    craftsmanResponse: {
      type: String,
      trim: true,
      maxlength: 500,
    },
    respondedAt: Date,
    isVisible: {
      type: Boolean,
      default: true,
    },
    isReported: {
      type: Boolean,
      default: false,
    },
    reportReason: String,
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
reviewSchema.index({ craftsmanId: 1, createdAt: -1 });
reviewSchema.index({ customerId: 1 });
reviewSchema.index({ score: 1 });
reviewSchema.index({ isVisible: 1 });

// Virtual for customer details
reviewSchema.virtual('customer', {
  ref: 'Customer',
  localField: 'customerId',
  foreignField: '_id',
  justOne: true,
});

// Virtual for request details
reviewSchema.virtual('request', {
  ref: 'ServiceRequest',
  localField: 'requestId',
  foreignField: '_id',
  justOne: true,
});

const Review: Model<IReview> = mongoose.model<IReview>('Review', reviewSchema);

export default Review;
