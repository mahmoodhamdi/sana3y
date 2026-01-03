import { Types } from 'mongoose';
import ServiceRequest, { IServiceRequest } from '../models/ServiceRequest';
import Craftsman from '../models/Craftsman';
import Customer from '../models/Customer';
import { NotFoundError, BadRequestError, ForbiddenError } from '@utils/errors';
import socketService from './socket.service';

type RequestStatus = 'pending' | 'quoted' | 'accepted' | 'in_progress' | 'completed' | 'cancelled';

// Status transition rules
const STATUS_TRANSITIONS: Record<RequestStatus, RequestStatus[]> = {
  pending: ['quoted', 'cancelled'],
  quoted: ['accepted', 'cancelled', 'pending'],
  accepted: ['in_progress', 'cancelled'],
  in_progress: ['completed', 'cancelled'],
  completed: [],
  cancelled: [],
};

// Who can trigger which status transitions
const CUSTOMER_TRANSITIONS = [
  { from: 'pending', to: 'cancelled' },
  { from: 'quoted', to: 'accepted' },
  { from: 'quoted', to: 'cancelled' },
  { from: 'accepted', to: 'cancelled' },
];

const CRAFTSMAN_TRANSITIONS = [
  { from: 'accepted', to: 'in_progress' },
  { from: 'in_progress', to: 'completed' },
  { from: 'accepted', to: 'cancelled' },
];

class StatusService {
  // Check if a status transition is valid
  isValidTransition(from: RequestStatus, to: RequestStatus): boolean {
    const allowedTransitions = STATUS_TRANSITIONS[from];
    return allowedTransitions?.includes(to) ?? false;
  }

  // Check if user has permission to make this transition
  hasPermission(
    from: RequestStatus,
    to: RequestStatus,
    role: 'customer' | 'craftsman' | 'admin'
  ): boolean {
    if (role === 'admin') {
      return this.isValidTransition(from, to);
    }

    const transitions = role === 'customer' ? CUSTOMER_TRANSITIONS : CRAFTSMAN_TRANSITIONS;
    return transitions.some((t) => t.from === from && t.to === to);
  }

  // Update request status
  async updateStatus(
    requestId: string,
    newStatus: RequestStatus,
    userId: string,
    role: 'customer' | 'craftsman' | 'admin',
    additionalData?: {
      cancellationReason?: string;
      completionNotes?: string;
      actualAmount?: number;
    }
  ): Promise<IServiceRequest> {
    const request = await ServiceRequest.findById(requestId);
    if (!request) {
      throw new NotFoundError('الطلب غير موجود');
    }

    const currentStatus = request.status as RequestStatus;

    // Validate transition
    if (!this.isValidTransition(currentStatus, newStatus)) {
      throw new BadRequestError(
        `لا يمكن تغيير الحالة من ${currentStatus} إلى ${newStatus}`
      );
    }

    // Check permission
    if (!this.hasPermission(currentStatus, newStatus, role)) {
      throw new ForbiddenError(
        `ليس لديك صلاحية لتغيير الحالة من ${currentStatus} إلى ${newStatus}`
      );
    }

    // Verify user identity
    if (role === 'customer') {
      const customer = await Customer.findOne({ userId: new Types.ObjectId(userId) });
      if (!customer || request.customerId.toString() !== customer._id.toString()) {
        throw new ForbiddenError('غير مصرح');
      }
    }

    if (role === 'craftsman') {
      const craftsman = await Craftsman.findOne({ userId: new Types.ObjectId(userId) });
      if (!craftsman || request.craftsmanId?.toString() !== craftsman._id.toString()) {
        throw new ForbiddenError('غير مصرح');
      }
    }

    // Apply the status change
    request.status = newStatus;

    switch (newStatus) {
      case 'in_progress':
        request.startedAt = new Date();
        break;

      case 'completed':
        request.completedAt = new Date();
        if (additionalData?.completionNotes) {
          request.completionNotes = additionalData.completionNotes;
        }
        if (additionalData?.actualAmount) {
          request.finalPrice = additionalData.actualAmount;
        }
        // Update craftsman stats
        if (request.craftsmanId) {
          await this.updateCraftsmanStatsOnCompletion(
            request.craftsmanId.toString(),
            additionalData?.actualAmount || request.quotedPrice || 0
          );
        }
        break;

      case 'cancelled':
        request.cancelledAt = new Date();
        request.isCancelled = true;
        request.cancelledBy = role as 'customer' | 'craftsman';
        if (additionalData?.cancellationReason) {
          request.cancelReason = additionalData.cancellationReason;
        }
        break;
    }

    // Add to status history
    request.statusHistory.push({
      status: newStatus,
      timestamp: new Date(),
      note: this.getStatusChangeNote(currentStatus, newStatus),
      by: new Types.ObjectId(userId),
    });

    await request.save();

    // Notify relevant parties
    this.notifyStatusChange(request, currentStatus, newStatus);

    return request;
  }

  // Notify about status change
  private notifyStatusChange(
    request: IServiceRequest,
    oldStatus: string,
    newStatus: string
  ): void {
    try {
      socketService.notifyStatusChange(
        request._id.toString(),
        request.customerId.toString(),
        request.craftsmanId?.toString(),
        newStatus,
        { oldStatus }
      );
    } catch (error) {
      console.error('Error notifying status change:', error);
    }
  }

  // Get human-readable status change note
  private getStatusChangeNote(from: RequestStatus, to: RequestStatus): string {
    const notes: Record<string, string> = {
      pending_quoted: 'تم تقديم عرض سعر',
      quoted_accepted: 'تم قبول العرض',
      accepted_in_progress: 'بدأ العمل',
      in_progress_completed: 'تم إكمال العمل',
      pending_cancelled: 'تم إلغاء الطلب',
      quoted_cancelled: 'تم إلغاء الطلب',
      accepted_cancelled: 'تم إلغاء الطلب',
    };

    return notes[`${from}_${to}`] || `تغيرت الحالة من ${from} إلى ${to}`;
  }

  // Update craftsman statistics when a job is completed
  private async updateCraftsmanStatsOnCompletion(
    craftsmanId: string,
    amount: number
  ): Promise<void> {
    await Craftsman.findByIdAndUpdate(craftsmanId, {
      $inc: {
        completedJobs: 1,
        totalEarnings: amount,
        currentBalance: amount,
      },
    });
  }

  // Get status timeline for a request
  async getStatusTimeline(requestId: string): Promise<
    Array<{
      status: string;
      timestamp: Date;
      note: string;
    }>
  > {
    const request = await ServiceRequest.findById(requestId).select(
      'statusHistory status createdAt'
    );
    if (!request) {
      throw new NotFoundError('الطلب غير موجود');
    }

    const timeline = [
      {
        status: 'pending',
        timestamp: request.createdAt,
        note: 'تم إنشاء الطلب',
      },
    ];

    if (request.statusHistory) {
      request.statusHistory.forEach((entry) => {
        timeline.push({
          status: entry.status,
          timestamp: entry.timestamp,
          note: entry.note || '',
        });
      });
    }

    return timeline;
  }

  // Get status display info
  getStatusDisplayInfo(status: RequestStatus): {
    label: string;
    labelAr: string;
    color: string;
    icon: string;
  } {
    const statusInfo: Record<
      RequestStatus,
      { label: string; labelAr: string; color: string; icon: string }
    > = {
      pending: {
        label: 'Pending',
        labelAr: 'في الانتظار',
        color: '#FFA500',
        icon: 'clock',
      },
      quoted: {
        label: 'Quoted',
        labelAr: 'تم التسعير',
        color: '#3498DB',
        icon: 'tag',
      },
      accepted: {
        label: 'Accepted',
        labelAr: 'مقبول',
        color: '#9B59B6',
        icon: 'check',
      },
      in_progress: {
        label: 'In Progress',
        labelAr: 'جاري العمل',
        color: '#1ABC9C',
        icon: 'hammer',
      },
      completed: {
        label: 'Completed',
        labelAr: 'مكتمل',
        color: '#27AE60',
        icon: 'check-circle',
      },
      cancelled: {
        label: 'Cancelled',
        labelAr: 'ملغي',
        color: '#E74C3C',
        icon: 'x-circle',
      },
    };

    return (
      statusInfo[status] || {
        label: status,
        labelAr: status,
        color: '#95A5A6',
        icon: 'circle',
      }
    );
  }

  // Get all available statuses with their info
  getAllStatuses(): Array<{
    value: RequestStatus;
    label: string;
    labelAr: string;
    color: string;
    icon: string;
  }> {
    const statuses: RequestStatus[] = [
      'pending',
      'quoted',
      'accepted',
      'in_progress',
      'completed',
      'cancelled',
    ];
    return statuses.map((status) => ({
      value: status,
      ...this.getStatusDisplayInfo(status),
    }));
  }
}

export default new StatusService();
