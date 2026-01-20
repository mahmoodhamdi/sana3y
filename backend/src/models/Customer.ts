import mongoose, { Schema, Model, Types } from 'mongoose';
import { ICustomer, IAddress } from '../types';

const addressSchema = new Schema<IAddress>(
  {
    label: {
      type: String,
      enum: ['home', 'work', 'other'],
      default: 'home',
    },
    name: {
      type: String,
      required: true,
      trim: true,
    },
    address: {
      type: String,
      required: true,
      trim: true,
    },
    area: {
      type: String,
      required: true,
      trim: true,
    },
    city: {
      type: String,
      default: 'الباجور',
      trim: true,
    },
    landmark: {
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
        required: true,
        validate: {
          validator: function (coords: number[]) {
            return coords.length === 2;
          },
          message: 'Coordinates must be [longitude, latitude]',
        },
      },
    },
    isDefault: {
      type: Boolean,
      default: false,
    },
  },
  { _id: true }
);

const customerSchema = new Schema<ICustomer>(
  {
    userId: {
      type: Schema.Types.ObjectId,
      ref: 'User',
      required: true,
      unique: true,
    },
    addresses: {
      type: [addressSchema],
      default: [],
      validate: {
        validator: function (addresses: IAddress[]) {
          return addresses.length <= 10;
        },
        message: 'Cannot have more than 10 addresses',
      },
    },
    totalRequests: {
      type: Number,
      default: 0,
      min: 0,
    },
    totalSpent: {
      type: Number,
      default: 0,
      min: 0,
    },
    favoriteCraftsmen: {
      type: [Schema.Types.ObjectId],
      ref: 'Craftsman',
      default: [],
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

// Indexes (userId index is created by unique: true)
customerSchema.index({ 'addresses.location': '2dsphere' });

// Virtual for user details
customerSchema.virtual('user', {
  ref: 'User',
  localField: 'userId',
  foreignField: '_id',
  justOne: true,
});

// Method to add address
customerSchema.methods.addAddress = function (address: Partial<IAddress>): IAddress {
  // If this is the first address or isDefault is true, set as default
  if (this.addresses.length === 0 || address.isDefault) {
    // Unset other default addresses
    this.addresses.forEach((addr: IAddress) => {
      addr.isDefault = false;
    });
    address.isDefault = true;
  }

  const newAddress = {
    _id: new Types.ObjectId(),
    ...address,
  } as IAddress;

  this.addresses.push(newAddress);
  return newAddress;
};

// Method to get default address
customerSchema.methods.getDefaultAddress = function (): IAddress | null {
  return this.addresses.find((addr: IAddress) => addr.isDefault) || this.addresses[0] || null;
};

const Customer: Model<ICustomer> = mongoose.model<ICustomer>('Customer', customerSchema);

export default Customer;
