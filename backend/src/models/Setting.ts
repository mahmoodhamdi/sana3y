import mongoose, { Schema, Model, Document, Types } from 'mongoose';

export interface ISetting extends Document {
  _id: Types.ObjectId;
  key: string;
  value: unknown;
  type: 'string' | 'number' | 'boolean' | 'json';
  description?: string;
  isPublic: boolean;
  updatedAt: Date;
  updatedBy?: Types.ObjectId;
}

const settingSchema = new Schema<ISetting>(
  {
    key: {
      type: String,
      required: true,
      unique: true,
      trim: true,
    },
    value: {
      type: Schema.Types.Mixed,
      required: true,
    },
    type: {
      type: String,
      enum: ['string', 'number', 'boolean', 'json'],
      default: 'string',
    },
    description: String,
    isPublic: {
      type: Boolean,
      default: false,
    },
    updatedBy: {
      type: Schema.Types.ObjectId,
      ref: 'User',
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

// Indexes (key index is created by unique: true)
settingSchema.index({ isPublic: 1 });

// Static method to get setting value
settingSchema.statics.getValue = async function (
  key: string,
  defaultValue?: unknown
): Promise<unknown> {
  const setting = await this.findOne({ key });
  return setting ? setting.value : defaultValue;
};

// Static method to set setting value
settingSchema.statics.setValue = async function (
  key: string,
  value: unknown,
  type: 'string' | 'number' | 'boolean' | 'json' = 'string',
  description?: string,
  isPublic: boolean = false,
  updatedBy?: Types.ObjectId
): Promise<ISetting> {
  return this.findOneAndUpdate(
    { key },
    { value, type, description, isPublic, updatedBy },
    { upsert: true, new: true }
  );
};

// Static method to get public settings
settingSchema.statics.getPublicSettings = async function (): Promise<Record<string, unknown>> {
  const settings = await this.find({ isPublic: true });
  const result: Record<string, unknown> = {};
  settings.forEach((setting: ISetting) => {
    result[setting.key] = setting.value;
  });
  return result;
};

interface SettingModel extends Model<ISetting> {
  getValue(key: string, defaultValue?: unknown): Promise<unknown>;
  setValue(
    key: string,
    value: unknown,
    type?: 'string' | 'number' | 'boolean' | 'json',
    description?: string,
    isPublic?: boolean,
    updatedBy?: Types.ObjectId
  ): Promise<ISetting>;
  getPublicSettings(): Promise<Record<string, unknown>>;
}

const Setting = mongoose.model<ISetting, SettingModel>('Setting', settingSchema);

export default Setting;
