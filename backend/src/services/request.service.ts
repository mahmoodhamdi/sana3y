import { Types } from 'mongoose';
import ServiceRequest, { IServiceRequest } from '../models/ServiceRequest';
import User from '../models/User';
import Craftsman from '../models/Craftsman';
import Customer from '../models/Customer';
import { NotFoundError, BadRequestError, ForbiddenError } from '@utils/errors';
import socketService from './socket.service';

type RequestStatus = 'pending' | 'quoted' | 'accepted' | 'in_progress' | 'completed' | 'cancelled';

export interface CreateRequestData {
  customer: string;
  title: string;
  description: string;
  category: string;
  subcategory?: string;
  location: {
    address: string;
    coordinates: [number, number];
    governorate: string;
    city: string;
    area?: string;
  };
  preferredDate?: Date;
  preferredTime?: {
    start: string;
    end: string;
  };
  images?: string[];
  budget?: {
    min: number;
    max: number;
  };
  urgency?: 'today' | 'urgent' | 'scheduled';
}

export interface RequestFilters {
  status?: RequestStatus | RequestStatus[];
  category?: string;
  customer?: string;
  craftsman?: string;
  governorate?: string;
  city?: string;
  urgency?: string;
  dateFrom?: Date;
  dateTo?: Date;
  search?: string;
}

export interface QuoteData {
  craftsman: string;
  amount: number;
  estimatedDuration?: string;
  notes?: string;
  validUntil?: Date;
}

class RequestService {
  // Create a new service request
  async createRequest(data: CreateRequestData): Promise<IServiceRequest> {
    // Get customer
    const customer = await Customer.findOne({ userId: new Types.ObjectId(data.customer) });
    if (!customer) {
      throw new NotFoundError('العميل غير موجود');
    }

    const request = new ServiceRequest({
      customerId: customer._id,
      categoryId: new Types.ObjectId(data.category),
      subcategory: data.subcategory,
      title: data.title,
      description: data.description,
      images: data.images || [],
      address: {
        address: data.location.address,
        area: data.location.area || data.location.city,
        city: data.location.city,
        location: {
          type: 'Point',
          coordinates: data.location.coordinates,
        },
      },
      urgency: data.urgency || 'today',
      scheduledDate: data.preferredDate,
      estimatedPrice: data.budget,
      status: 'pending',
    });

    await request.save();

    // Notify craftsmen in the area
    this.notifyCraftsmen(request);

    return request.populate([
      { path: 'customerId', select: 'userId', populate: { path: 'userId', select: 'name phone' } },
      { path: 'categoryId', select: 'nameAr icon' },
    ]);
  }

  // Notify nearby craftsmen about new request
  private async notifyCraftsmen(request: IServiceRequest): Promise<void> {
    try {
      socketService.emitToCategory(
        request.categoryId.toString(),
        'request:new',
        {
          requestId: request._id.toString(),
          title: request.title,
          urgency: request.urgency,
          location: request.address,
        }
      );
    } catch (error) {
      console.error('Error notifying craftsmen:', error);
    }
  }

  // Get single request by ID
  async getRequestById(requestId: string): Promise<IServiceRequest | null> {
    return ServiceRequest.findById(requestId)
      .populate({ path: 'customerId', select: 'userId', populate: { path: 'userId', select: 'name phone avatar' } })
      .populate({ path: 'craftsmanId', select: 'displayName userId profileImage rating', populate: { path: 'userId', select: 'name phone' } })
      .populate({ path: 'categoryId', select: 'nameAr icon' });
  }

  // Get requests with filters and pagination
  async getRequests(
    filters: RequestFilters,
    page: number = 1,
    limit: number = 20,
    sortBy: string = 'createdAt',
    sortOrder: 'asc' | 'desc' = 'desc'
  ) {
    const query: Record<string, unknown> = {};

    if (filters.status) {
      query.status = Array.isArray(filters.status)
        ? { $in: filters.status }
        : filters.status;
    }

    if (filters.category) {
      query.categoryId = new Types.ObjectId(filters.category);
    }

    if (filters.customer) {
      query.customerId = new Types.ObjectId(filters.customer);
    }

    if (filters.craftsman) {
      query.craftsmanId = new Types.ObjectId(filters.craftsman);
    }

    if (filters.governorate) {
      query['address.city'] = filters.governorate;
    }

    if (filters.urgency) {
      query.urgency = filters.urgency;
    }

    if (filters.dateFrom || filters.dateTo) {
      query.createdAt = {};
      if (filters.dateFrom) {
        (query.createdAt as Record<string, Date>).$gte = filters.dateFrom;
      }
      if (filters.dateTo) {
        (query.createdAt as Record<string, Date>).$lte = filters.dateTo;
      }
    }

    if (filters.search) {
      query.$or = [
        { title: { $regex: filters.search, $options: 'i' } },
        { description: { $regex: filters.search, $options: 'i' } },
        { requestNumber: { $regex: filters.search, $options: 'i' } },
      ];
    }

    const skip = (page - 1) * limit;
    const sort: Record<string, 1 | -1> = { [sortBy]: sortOrder === 'asc' ? 1 : -1 };

    const [requests, total] = await Promise.all([
      ServiceRequest.find(query)
        .sort(sort)
        .skip(skip)
        .limit(limit)
        .populate({ path: 'customerId', select: 'userId', populate: { path: 'userId', select: 'name phone' } })
        .populate({ path: 'craftsmanId', select: 'displayName profileImage rating' })
        .populate({ path: 'categoryId', select: 'nameAr icon' }),
      ServiceRequest.countDocuments(query),
    ]);

    return {
      requests,
      page,
      totalPages: Math.ceil(total / limit),
      total,
    };
  }

  // Get customer's requests
  async getCustomerRequests(
    userId: string,
    status?: RequestStatus | RequestStatus[],
    page: number = 1,
    limit: number = 20
  ) {
    const customer = await Customer.findOne({ userId: new Types.ObjectId(userId) });
    if (!customer) {
      return { requests: [], page: 1, totalPages: 0, total: 0 };
    }

    const filters: RequestFilters = { customer: customer._id.toString() };
    if (status) {
      filters.status = status;
    }

    return this.getRequests(filters, page, limit);
  }

  // Get available requests for craftsman
  async getAvailableRequestsForCraftsman(
    craftsmanId: string,
    page: number = 1,
    limit: number = 20
  ) {
    const craftsman = await Craftsman.findById(craftsmanId);
    if (!craftsman) {
      throw new NotFoundError('الصنايعي غير موجود');
    }

    // Get category IDs from craftsman's services
    const categoryIds = craftsman.services.map((s) => s.categoryId);

    const query: Record<string, unknown> = {
      status: 'pending',
      categoryId: { $in: categoryIds },
      craftsmanId: { $exists: false },
    };

    const skip = (page - 1) * limit;

    const [requests, total] = await Promise.all([
      ServiceRequest.find(query)
        .sort({ createdAt: -1 })
        .skip(skip)
        .limit(limit)
        .populate({ path: 'customerId', select: 'userId', populate: { path: 'userId', select: 'name' } })
        .populate({ path: 'categoryId', select: 'nameAr icon' }),
      ServiceRequest.countDocuments(query),
    ]);

    return {
      requests,
      page,
      totalPages: Math.ceil(total / limit),
      total,
    };
  }

  // Get craftsman's active jobs
  async getCraftsmanActiveJobs(
    craftsmanId: string,
    page: number = 1,
    limit: number = 20
  ) {
    const query = {
      craftsmanId: new Types.ObjectId(craftsmanId),
      status: { $in: ['accepted', 'in_progress'] },
    };

    const skip = (page - 1) * limit;

    const [requests, total] = await Promise.all([
      ServiceRequest.find(query)
        .sort({ updatedAt: -1 })
        .skip(skip)
        .limit(limit)
        .populate({ path: 'customerId', select: 'userId', populate: { path: 'userId', select: 'name phone' } })
        .populate({ path: 'categoryId', select: 'nameAr icon' }),
      ServiceRequest.countDocuments(query),
    ]);

    return {
      requests,
      page,
      totalPages: Math.ceil(total / limit),
      total,
    };
  }

  // Get craftsman's completed jobs
  async getCraftsmanCompletedJobs(
    craftsmanId: string,
    page: number = 1,
    limit: number = 20
  ) {
    const query = {
      craftsmanId: new Types.ObjectId(craftsmanId),
      status: 'completed',
    };

    const skip = (page - 1) * limit;

    const [requests, total] = await Promise.all([
      ServiceRequest.find(query)
        .sort({ completedAt: -1 })
        .skip(skip)
        .limit(limit)
        .populate({ path: 'customerId', select: 'userId', populate: { path: 'userId', select: 'name' } })
        .populate({ path: 'categoryId', select: 'nameAr icon' }),
      ServiceRequest.countDocuments(query),
    ]);

    return {
      requests,
      page,
      totalPages: Math.ceil(total / limit),
      total,
    };
  }

  // Submit a quote
  async submitQuote(requestId: string, quoteData: QuoteData): Promise<IServiceRequest> {
    const request = await ServiceRequest.findById(requestId);
    if (!request) {
      throw new NotFoundError('الطلب غير موجود');
    }

    if (request.status !== 'pending' && request.status !== 'quoted') {
      throw new BadRequestError('لا يمكن تقديم عرض لهذا الطلب');
    }

    // Check if craftsman already submitted a quote
    const existingQuote = request.quotesReceived.find(
      (q) => q.craftsmanId.toString() === quoteData.craftsman
    );
    if (existingQuote) {
      throw new BadRequestError('لقد قدمت عرضاً مسبقاً لهذا الطلب');
    }

    request.quotesReceived.push({
      craftsmanId: new Types.ObjectId(quoteData.craftsman),
      price: quoteData.amount,
      note: quoteData.notes,
      estimatedDuration: quoteData.estimatedDuration,
      createdAt: new Date(),
    });

    if (request.status === 'pending') {
      request.status = 'quoted';
    }

    await request.save();

    // Notify customer
    socketService.emitToUser(
      request.customerId.toString(),
      'request:quote',
      {
        requestId: request._id.toString(),
        quoteCount: request.quotesReceived.length,
      }
    );

    return this.getRequestById(requestId) as Promise<IServiceRequest>;
  }

  // Accept a quote
  async acceptQuote(
    requestId: string,
    quoteId: string,
    userId: string
  ): Promise<IServiceRequest> {
    const request = await ServiceRequest.findById(requestId);
    if (!request) {
      throw new NotFoundError('الطلب غير موجود');
    }

    // Verify ownership
    const customer = await Customer.findOne({ userId: new Types.ObjectId(userId) });
    if (!customer || request.customerId.toString() !== customer._id.toString()) {
      throw new ForbiddenError('ليس لديك صلاحية لقبول هذا العرض');
    }

    // Find the quote
    const quote = request.quotesReceived.find(
      (q) => (q as any)._id?.toString() === quoteId || q.craftsmanId.toString() === quoteId
    );
    if (!quote) {
      throw new NotFoundError('العرض غير موجود');
    }

    request.craftsmanId = quote.craftsmanId;
    request.quotedPrice = quote.price;
    request.status = 'accepted';
    await request.save();

    // Notify craftsman
    socketService.emitToCraftsman(
      quote.craftsmanId.toString(),
      'request:accepted',
      {
        requestId: request._id.toString(),
        title: request.title,
      }
    );

    return this.getRequestById(requestId) as Promise<IServiceRequest>;
  }

  // Reject a quote
  async rejectQuote(
    requestId: string,
    quoteId: string,
    userId: string
  ): Promise<IServiceRequest> {
    const request = await ServiceRequest.findById(requestId);
    if (!request) {
      throw new NotFoundError('الطلب غير موجود');
    }

    // Verify ownership
    const customer = await Customer.findOne({ userId: new Types.ObjectId(userId) });
    if (!customer || request.customerId.toString() !== customer._id.toString()) {
      throw new ForbiddenError('ليس لديك صلاحية');
    }

    // Remove the quote
    request.quotesReceived = request.quotesReceived.filter(
      (q) => (q as any)._id?.toString() !== quoteId && q.craftsmanId.toString() !== quoteId
    );

    await request.save();
    return this.getRequestById(requestId) as Promise<IServiceRequest>;
  }

  // Update request
  async updateRequest(
    requestId: string,
    userId: string,
    updates: Partial<CreateRequestData>
  ): Promise<IServiceRequest> {
    const request = await ServiceRequest.findById(requestId);
    if (!request) {
      throw new NotFoundError('الطلب غير موجود');
    }

    // Verify ownership
    const customer = await Customer.findOne({ userId: new Types.ObjectId(userId) });
    if (!customer || request.customerId.toString() !== customer._id.toString()) {
      throw new ForbiddenError('ليس لديك صلاحية لتعديل هذا الطلب');
    }

    if (request.status !== 'pending') {
      throw new BadRequestError('لا يمكن تعديل الطلب في هذه الحالة');
    }

    if (updates.title) request.title = updates.title;
    if (updates.description) request.description = updates.description;
    if (updates.images) request.images = updates.images;
    if (updates.urgency) request.urgency = updates.urgency;
    if (updates.preferredDate) request.scheduledDate = updates.preferredDate;
    if (updates.budget) request.estimatedPrice = updates.budget;

    await request.save();
    return this.getRequestById(requestId) as Promise<IServiceRequest>;
  }

  // Cancel request
  async cancelRequest(
    requestId: string,
    userId: string,
    reason?: string
  ): Promise<IServiceRequest> {
    const request = await ServiceRequest.findById(requestId);
    if (!request) {
      throw new NotFoundError('الطلب غير موجود');
    }

    // Verify ownership or craftsman
    const customer = await Customer.findOne({ userId: new Types.ObjectId(userId) });
    const craftsman = await Craftsman.findOne({ userId: new Types.ObjectId(userId) });

    let cancelledBy: 'customer' | 'craftsman' = 'customer';
    if (customer && request.customerId.toString() === customer._id.toString()) {
      cancelledBy = 'customer';
    } else if (craftsman && request.craftsmanId?.toString() === craftsman._id.toString()) {
      cancelledBy = 'craftsman';
    } else {
      throw new ForbiddenError('ليس لديك صلاحية لإلغاء هذا الطلب');
    }

    if (['completed', 'cancelled'].includes(request.status)) {
      throw new BadRequestError('لا يمكن إلغاء هذا الطلب');
    }

    request.status = 'cancelled';
    request.isCancelled = true;
    request.cancelledBy = cancelledBy;
    request.cancelReason = reason;
    request.cancelledAt = new Date();
    await request.save();

    return this.getRequestById(requestId) as Promise<IServiceRequest>;
  }

  // Get request statistics
  async getRequestStats() {
    const stats = await ServiceRequest.aggregate([
      {
        $facet: {
          byStatus: [{ $group: { _id: '$status', count: { $sum: 1 } } }],
          byUrgency: [{ $group: { _id: '$urgency', count: { $sum: 1 } } }],
          total: [{ $count: 'count' }],
          today: [
            {
              $match: {
                createdAt: { $gte: new Date(new Date().setHours(0, 0, 0, 0)) },
              },
            },
            { $count: 'count' },
          ],
          thisWeek: [
            {
              $match: {
                createdAt: {
                  $gte: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000),
                },
              },
            },
            { $count: 'count' },
          ],
        },
      },
    ]);

    return stats[0];
  }

  // Delete request (admin only)
  async deleteRequest(requestId: string): Promise<void> {
    const request = await ServiceRequest.findByIdAndDelete(requestId);
    if (!request) {
      throw new NotFoundError('الطلب غير موجود');
    }
  }
}

export default new RequestService();
