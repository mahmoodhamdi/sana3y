import mongoose from 'mongoose';
import Request, { IRequest, RequestStatus } from '../models/Request';
import Craftsman from '../models/Craftsman';

// Status transition rules - defines which transitions are allowed
const STATUS_TRANSITIONS: Record<RequestStatus, RequestStatus[]> = {
  [RequestStatus.PENDING]: [RequestStatus.QUOTED, RequestStatus.CANCELLED],
  [RequestStatus.QUOTED]: [RequestStatus.ACCEPTED, RequestStatus.CANCELLED, RequestStatus.PENDING],
  [RequestStatus.ACCEPTED]: [RequestStatus.IN_PROGRESS, RequestStatus.CANCELLED],
  [RequestStatus.IN_PROGRESS]: [RequestStatus.ARRIVED, RequestStatus.CANCELLED],
  [RequestStatus.ARRIVED]: [RequestStatus.COMPLETED, RequestStatus.CANCELLED],
  [RequestStatus.COMPLETED]: [RequestStatus.DISPUTED],
  [RequestStatus.CANCELLED]: [],
  [RequestStatus.DISPUTED]: [RequestStatus.COMPLETED, RequestStatus.REFUNDED],
  [RequestStatus.REFUNDED]: [],
};

// Who can trigger which status transitions
const TRANSITION_PERMISSIONS: Record<
  string,
  Array<{ from: RequestStatus; to: RequestStatus; role: 'customer' | 'craftsman' | 'admin' }>
> = {
  customer: [
    { from: RequestStatus.PENDING, to: RequestStatus.CANCELLED, role: 'customer' },
    { from: RequestStatus.QUOTED, to: RequestStatus.ACCEPTED, role: 'customer' },
    { from: RequestStatus.QUOTED, to: RequestStatus.CANCELLED, role: 'customer' },
    { from: RequestStatus.ACCEPTED, to: RequestStatus.CANCELLED, role: 'customer' },
    { from: RequestStatus.COMPLETED, to: RequestStatus.DISPUTED, role: 'customer' },
  ],
  craftsman: [
    { from: RequestStatus.ACCEPTED, to: RequestStatus.IN_PROGRESS, role: 'craftsman' },
    { from: RequestStatus.IN_PROGRESS, to: RequestStatus.ARRIVED, role: 'craftsman' },
    { from: RequestStatus.ARRIVED, to: RequestStatus.COMPLETED, role: 'craftsman' },
    { from: RequestStatus.ACCEPTED, to: RequestStatus.CANCELLED, role: 'craftsman' },
  ],
  admin: [
    // Admin can do any valid transition
  ],
};

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

    const permissions = TRANSITION_PERMISSIONS[role] || [];
    return permissions.some(
      (p) => p.from === from && p.to === to
    );
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
      disputeReason?: string;
      actualAmount?: number;
    }
  ): Promise<IRequest> {
    const request = await Request.findById(requestId);
    if (!request) {
      throw new Error('Request not found');
    }

    const currentStatus = request.status as RequestStatus;

    // Validate transition
    if (!this.isValidTransition(currentStatus, newStatus)) {
      throw new Error(
        `Invalid status transition from ${currentStatus} to ${newStatus}`
      );
    }

    // Check permission
    if (!this.hasPermission(currentStatus, newStatus, role)) {
      throw new Error(
        `You don't have permission to change status from ${currentStatus} to ${newStatus}`
      );
    }

    // Verify user identity
    if (role === 'customer' && request.customer.toString() !== userId) {
      throw new Error('Not authorized');
    }

    if (role === 'craftsman' && request.assignedCraftsman?.toString() !== userId) {
      throw new Error('Not authorized');
    }

    // Apply the status change with additional logic based on the new status
    request.status = newStatus;

    switch (newStatus) {
      case RequestStatus.IN_PROGRESS:
        request.startedAt = new Date();
        break;

      case RequestStatus.ARRIVED:
        request.arrivedAt = new Date();
        break;

      case RequestStatus.COMPLETED:
        request.completedAt = new Date();
        if (additionalData?.completionNotes) {
          request.completionNotes = additionalData.completionNotes;
        }
        if (additionalData?.actualAmount) {
          request.actualAmount = additionalData.actualAmount;
        }
        // Update craftsman stats
        await this.updateCraftsmanStatsOnCompletion(
          request.assignedCraftsman!.toString(),
          additionalData?.actualAmount || request.acceptedQuote?.amount || 0
        );
        break;

      case RequestStatus.CANCELLED:
        request.cancelledAt = new Date();
        request.cancelledBy = role;
        if (additionalData?.cancellationReason) {
          request.cancellationReason = additionalData.cancellationReason;
        }
        break;

      case RequestStatus.DISPUTED:
        request.disputedAt = new Date();
        if (additionalData?.disputeReason) {
          request.disputeReason = additionalData.disputeReason;
        }
        break;

      case RequestStatus.REFUNDED:
        request.refundedAt = new Date();
        break;
    }

    // Add to status history
    request.statusHistory = request.statusHistory || [];
    request.statusHistory.push({
      status: newStatus,
      changedAt: new Date(),
      changedBy: new mongoose.Types.ObjectId(userId),
      notes: this.getStatusChangeNote(currentStatus, newStatus),
    });

    await request.save();
    return request;
  }

  // Get human-readable status change note
  private getStatusChangeNote(from: RequestStatus, to: RequestStatus): string {
    const notes: Record<string, string> = {
      [`${RequestStatus.PENDING}_${RequestStatus.QUOTED}`]: 'تم تقديم عرض سعر',
      [`${RequestStatus.QUOTED}_${RequestStatus.ACCEPTED}`]: 'تم قبول العرض',
      [`${RequestStatus.ACCEPTED}_${RequestStatus.IN_PROGRESS}`]: 'بدأ العمل',
      [`${RequestStatus.IN_PROGRESS}_${RequestStatus.ARRIVED}`]: 'وصل الصنايعي',
      [`${RequestStatus.ARRIVED}_${RequestStatus.COMPLETED}`]: 'تم إكمال العمل',
      [`${RequestStatus.COMPLETED}_${RequestStatus.DISPUTED}`]: 'تم فتح نزاع',
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
        'earnings.total': amount,
        'earnings.pending': amount,
      },
    });
  }

  // Get status timeline for a request
  async getStatusTimeline(requestId: string): Promise<
    Array<{
      status: RequestStatus;
      timestamp: Date;
      note: string;
    }>
  > {
    const request = await Request.findById(requestId).select('statusHistory status createdAt');
    if (!request) {
      throw new Error('Request not found');
    }

    const timeline = [
      {
        status: RequestStatus.PENDING,
        timestamp: request.createdAt,
        note: 'تم إنشاء الطلب',
      },
    ];

    if (request.statusHistory) {
      request.statusHistory.forEach((entry) => {
        timeline.push({
          status: entry.status as RequestStatus,
          timestamp: entry.changedAt,
          note: entry.notes || '',
        });
      });
    }

    return timeline;
  }

  // Get expected next status based on current status
  getNextExpectedStatus(currentStatus: RequestStatus): RequestStatus | null {
    const normalFlow: Record<RequestStatus, RequestStatus | null> = {
      [RequestStatus.PENDING]: RequestStatus.QUOTED,
      [RequestStatus.QUOTED]: RequestStatus.ACCEPTED,
      [RequestStatus.ACCEPTED]: RequestStatus.IN_PROGRESS,
      [RequestStatus.IN_PROGRESS]: RequestStatus.ARRIVED,
      [RequestStatus.ARRIVED]: RequestStatus.COMPLETED,
      [RequestStatus.COMPLETED]: null,
      [RequestStatus.CANCELLED]: null,
      [RequestStatus.DISPUTED]: RequestStatus.COMPLETED,
      [RequestStatus.REFUNDED]: null,
    };

    return normalFlow[currentStatus];
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
      [RequestStatus.PENDING]: {
        label: 'Pending',
        labelAr: 'في الانتظار',
        color: '#FFA500',
        icon: 'clock',
      },
      [RequestStatus.QUOTED]: {
        label: 'Quoted',
        labelAr: 'تم التسعير',
        color: '#3498DB',
        icon: 'tag',
      },
      [RequestStatus.ACCEPTED]: {
        label: 'Accepted',
        labelAr: 'مقبول',
        color: '#9B59B6',
        icon: 'check',
      },
      [RequestStatus.IN_PROGRESS]: {
        label: 'In Progress',
        labelAr: 'جاري العمل',
        color: '#1ABC9C',
        icon: 'hammer',
      },
      [RequestStatus.ARRIVED]: {
        label: 'Arrived',
        labelAr: 'وصل الصنايعي',
        color: '#2ECC71',
        icon: 'location',
      },
      [RequestStatus.COMPLETED]: {
        label: 'Completed',
        labelAr: 'مكتمل',
        color: '#27AE60',
        icon: 'check-circle',
      },
      [RequestStatus.CANCELLED]: {
        label: 'Cancelled',
        labelAr: 'ملغي',
        color: '#E74C3C',
        icon: 'x-circle',
      },
      [RequestStatus.DISPUTED]: {
        label: 'Disputed',
        labelAr: 'نزاع',
        color: '#E67E22',
        icon: 'alert-triangle',
      },
      [RequestStatus.REFUNDED]: {
        label: 'Refunded',
        labelAr: 'مسترد',
        color: '#95A5A6',
        icon: 'refresh',
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
    return Object.values(RequestStatus).map((status) => ({
      value: status,
      ...this.getStatusDisplayInfo(status),
    }));
  }
}

export default new StatusService();
