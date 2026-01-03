import mongoose, { Schema, Model, Document, Types } from 'mongoose';

export interface IZone extends Document {
  _id: Types.ObjectId;
  name: string;
  nameAr: string;
  type: 'polygon' | 'circle';
  polygon?: {
    type: 'Polygon';
    coordinates: number[][][];
  };
  center?: {
    type: 'Point';
    coordinates: [number, number];
  };
  radius?: number;
  serviceFee: number;
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
}

const zoneSchema = new Schema<IZone>(
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
    type: {
      type: String,
      enum: ['polygon', 'circle'],
      required: true,
    },
    polygon: {
      type: {
        type: String,
        enum: ['Polygon'],
      },
      coordinates: {
        type: [[[Number]]],
      },
    },
    center: {
      type: {
        type: String,
        enum: ['Point'],
      },
      coordinates: {
        type: [Number],
      },
    },
    radius: {
      type: Number,
      min: 0,
    },
    serviceFee: {
      type: Number,
      default: 5,
      min: 0,
    },
    isActive: {
      type: Boolean,
      default: true,
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
zoneSchema.index({ polygon: '2dsphere' });
zoneSchema.index({ center: '2dsphere' });
zoneSchema.index({ isActive: 1 });

// Static method to find zone for a point
zoneSchema.statics.findZoneForPoint = async function (
  lng: number,
  lat: number
): Promise<IZone | null> {
  // First try polygon zones
  let zone = await this.findOne({
    isActive: true,
    type: 'polygon',
    polygon: {
      $geoIntersects: {
        $geometry: {
          type: 'Point',
          coordinates: [lng, lat],
        },
      },
    },
  });

  if (zone) return zone;

  // Then try circle zones
  zone = await this.findOne({
    isActive: true,
    type: 'circle',
    center: {
      $nearSphere: {
        $geometry: {
          type: 'Point',
          coordinates: [lng, lat],
        },
        $maxDistance: 50000, // 50km max
      },
    },
  });

  return zone;
};

interface ZoneModel extends Model<IZone> {
  findZoneForPoint(lng: number, lat: number): Promise<IZone | null>;
}

const Zone = mongoose.model<IZone, ZoneModel>('Zone', zoneSchema);

export default Zone;
