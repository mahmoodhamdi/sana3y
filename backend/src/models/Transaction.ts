import mongoose, { Schema, Model, Document, Types } from 'mongoose';
import dayjs from 'dayjs';

export interface ITransaction extends Document {
  _id: Types.ObjectId;
  transactionNumber: string;
  type: 'job_payment' | 'craftsman_payout' | 'refund' | 'withdrawal' | 'fee';
  requestId?: Types.ObjectId;
  fromUserId?: Types.ObjectId;
  toUserId?: Types.ObjectId;
  amount: number;
  fee: number;
  netAmount: number;
  status: 'pending' | 'completed' | 'failed';
  paymentMethod?: string;
  paymentId?: string;
  notes?: string;
  processedBy?: Types.ObjectId;
  processedAt?: Date;
  createdAt: Date;
  updatedAt: Date;
}

const transactionSchema = new Schema<ITransaction>(
  {
    transactionNumber: {
      type: String,
      unique: true,
      required: true,
    },
    type: {
      type: String,
      enum: ['job_payment', 'craftsman_payout', 'refund', 'withdrawal', 'fee'],
      required: true,
    },
    requestId: {
      type: Schema.Types.ObjectId,
      ref: 'ServiceRequest',
    },
    fromUserId: {
      type: Schema.Types.ObjectId,
      ref: 'User',
    },
    toUserId: {
      type: Schema.Types.ObjectId,
      ref: 'User',
    },
    amount: {
      type: Number,
      required: true,
      min: 0,
    },
    fee: {
      type: Number,
      default: 0,
      min: 0,
    },
    netAmount: {
      type: Number,
      required: true,
    },
    status: {
      type: String,
      enum: ['pending', 'completed', 'failed'],
      default: 'pending',
    },
    paymentMethod: String,
    paymentId: String,
    notes: String,
    processedBy: {
      type: Schema.Types.ObjectId,
      ref: 'User',
    },
    processedAt: Date,
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
transactionSchema.index({ transactionNumber: 1 });
transactionSchema.index({ type: 1 });
transactionSchema.index({ status: 1 });
transactionSchema.index({ fromUserId: 1 });
transactionSchema.index({ toUserId: 1 });
transactionSchema.index({ createdAt: -1 });

// Generate transaction number before saving
transactionSchema.pre('save', async function () {
  if (this.isNew && !this.transactionNumber) {
    const date = dayjs().format('YYMMDD');
    const count = await mongoose.model('Transaction').countDocuments({
      createdAt: {
        $gte: dayjs().startOf('day').toDate(),
        $lte: dayjs().endOf('day').toDate(),
      },
    });
    this.transactionNumber = `TXN-${date}-${String(count + 1).padStart(4, '0')}`;
  }

  // Calculate net amount
  if (this.isModified('amount') || this.isModified('fee')) {
    this.netAmount = this.amount - this.fee;
  }
});

// Virtual for request details
transactionSchema.virtual('request', {
  ref: 'ServiceRequest',
  localField: 'requestId',
  foreignField: '_id',
  justOne: true,
});

const Transaction: Model<ITransaction> = mongoose.model<ITransaction>('Transaction', transactionSchema);

export default Transaction;
