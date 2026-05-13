import mongoose, { Schema, Model, Document, Types } from 'mongoose';

export interface IAuditLog extends Document {
  _id: Types.ObjectId;
  actorUserId?: Types.ObjectId;
  actorRole?: string;
  action: string;
  targetType?: string;
  targetId?: string;
  method?: string;
  path?: string;
  ip?: string;
  userAgent?: string;
  /** Whitelisted request body (sensitive fields redacted before storing). */
  payload?: Record<string, unknown>;
  status?: number;
  /** Optional human-readable reason logged from the controller (e.g. "approved by admin"). */
  reason?: string;
  createdAt: Date;
}

const auditLogSchema = new Schema<IAuditLog>(
  {
    actorUserId: { type: Schema.Types.ObjectId, ref: 'User' },
    actorRole: { type: String },
    action: { type: String, required: true, index: true },
    targetType: { type: String, index: true },
    targetId: { type: String, index: true },
    method: { type: String },
    path: { type: String },
    ip: { type: String },
    userAgent: { type: String },
    payload: { type: Schema.Types.Mixed },
    status: { type: Number },
    reason: { type: String },
  },
  { timestamps: { createdAt: true, updatedAt: false } }
);

auditLogSchema.index({ createdAt: -1 });
auditLogSchema.index({ actorUserId: 1, createdAt: -1 });

const AuditLog: Model<IAuditLog> =
  mongoose.models.AuditLog || mongoose.model<IAuditLog>('AuditLog', auditLogSchema);

export default AuditLog;
