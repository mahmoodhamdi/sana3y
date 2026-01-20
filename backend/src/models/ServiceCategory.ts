import mongoose, { Schema, Model, Document, Types } from 'mongoose';

interface ISubcategory {
  _id: Types.ObjectId;
  name: string;
  nameAr: string;
  suggestedPrice?: {
    min: number;
    max: number;
  };
}

export interface IServiceCategory extends Document {
  _id: Types.ObjectId;
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
  createdAt: Date;
  updatedAt: Date;
}

const subcategorySchema = new Schema<ISubcategory>(
  {
    name: {
      type: String,
      required: true,
      trim: true,
    },
    nameAr: {
      type: String,
      required: true,
      trim: true,
    },
    suggestedPrice: {
      min: {
        type: Number,
        min: 0,
      },
      max: {
        type: Number,
        min: 0,
      },
    },
  },
  { _id: true }
);

const serviceCategorySchema = new Schema<IServiceCategory>(
  {
    name: {
      type: String,
      required: true,
      trim: true,
      unique: true,
    },
    nameAr: {
      type: String,
      required: true,
      trim: true,
    },
    slug: {
      type: String,
      required: true,
      unique: true,
      lowercase: true,
      trim: true,
    },
    icon: String,
    image: String,
    description: {
      type: String,
      trim: true,
    },
    descriptionAr: {
      type: String,
      trim: true,
    },
    subcategories: {
      type: [subcategorySchema],
      default: [],
    },
    sortOrder: {
      type: Number,
      default: 0,
    },
    isActive: {
      type: Boolean,
      default: true,
    },
    isPopular: {
      type: Boolean,
      default: false,
    },
    totalCraftsmen: {
      type: Number,
      default: 0,
      min: 0,
    },
    totalJobs: {
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

// Indexes (slug index is created by unique: true)
serviceCategorySchema.index({ sortOrder: 1 });
serviceCategorySchema.index({ isActive: 1 });
serviceCategorySchema.index({ isPopular: 1 });

// Pre-save middleware to generate slug
serviceCategorySchema.pre('save', function () {
  if (this.isModified('name') && !this.slug) {
    this.slug = this.name
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, '-')
      .replace(/(^-|-$)/g, '');
  }
});

const ServiceCategory: Model<IServiceCategory> = mongoose.model<IServiceCategory>(
  'ServiceCategory',
  serviceCategorySchema
);

export default ServiceCategory;
