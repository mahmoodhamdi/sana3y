import mongoose, { FilterQuery } from 'mongoose';
import Request, { IRequest, RequestStatus } from '../models/Request';
import User from '../models/User';
import Craftsman from '../models/Craftsman';

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
  urgency?: 'normal' | 'urgent' | 'emergency';
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
  async createRequest(data: CreateRequestData): Promise<IRequest> {
    // Verify customer exists
    const customer = await User.findById(data.customer);
    if (!customer) {
      throw new Error('Customer not found');
    }

    const request = new Request({
      ...data,
      location: {
        ...data.location,
        type: 'Point',
        coordinates: data.location.coordinates,
      },
      status: RequestStatus.PENDING,
      requestNumber: await this.generateRequestNumber(),
    });

    await request.save();
    return request.populate([
      { path: 'customer', select: 'name phone avatar' },
      { path: 'category', select: 'name nameAr icon' },
    ]);
  }

  // Generate unique request number
  private async generateRequestNumber(): Promise<string> {
    const date = new Date();
    const year = date.getFullYear().toString().slice(-2);
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');

    // Count today's requests
    const startOfDay = new Date(date.setHours(0, 0, 0, 0));
    const endOfDay = new Date(date.setHours(23, 59, 59, 999));

    const count = await Request.countDocuments({
      createdAt: { $gte: startOfDay, $lte: endOfDay },
    });

    const sequence = (count + 1).toString().padStart(4, '0');
    return `REQ-${year}${month}${day}-${sequence}`;
  }

  // Get requests with filters and pagination
  async getRequests(
    filters: RequestFilters,
    page: number = 1,
    limit: number = 20,
    sortBy: string = 'createdAt',
    sortOrder: 'asc' | 'desc' = 'desc'
  ): Promise<{
    requests: IRequest[];
    total: number;
    page: number;
    totalPages: number;
  }> {
    const query: FilterQuery<IRequest> = {};

    // Apply filters
    if (filters.status) {
      query.status = Array.isArray(filters.status)
        ? { $in: filters.status }
        : filters.status;
    }

    if (filters.category) {
      query.category = filters.category;
    }

    if (filters.customer) {
      query.customer = filters.customer;
    }

    if (filters.craftsman) {
      query.assignedCraftsman = filters.craftsman;
    }

    if (filters.governorate) {
      query['location.governorate'] = filters.governorate;
    }

    if (filters.city) {
      query['location.city'] = filters.city;
    }

    if (filters.urgency) {
      query.urgency = filters.urgency;
    }

    if (filters.dateFrom || filters.dateTo) {
      query.createdAt = {};
      if (filters.dateFrom) {
        query.createdAt.$gte = filters.dateFrom;
      }
      if (filters.dateTo) {
        query.createdAt.$lte = filters.dateTo;
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
      Request.find(query)
        .populate('customer', 'name phone avatar')
        .populate('category', 'name nameAr icon')
        .populate('assignedCraftsman', 'displayName rating')
        .sort(sort)
        .skip(skip)
        .limit(limit)
        .lean(),
      Request.countDocuments(query),
    ]);

    return {
      requests: requests as IRequest[],
      total,
      page,
      totalPages: Math.ceil(total / limit),
    };
  }

  // Get request by ID
  async getRequestById(id: string): Promise<IRequest | null> {
    return Request.findById(id)
      .populate('customer', 'name phone avatar')
      .populate('category', 'name nameAr icon')
      .populate('assignedCraftsman')
      .populate({
        path: 'quotes.craftsman',
        select: 'displayName rating profileImage completedJobs',
      });
  }

  // Get requests by customer
  async getCustomerRequests(
    customerId: string,
    status?: RequestStatus | RequestStatus[],
    page: number = 1,
    limit: number = 20
  ) {
    return this.getRequests(
      { customer: customerId, status },
      page,
      limit
    );
  }

  // Get available requests for craftsman (matching their categories and location)
  async getAvailableRequestsForCraftsman(
    craftsmanId: string,
    page: number = 1,
    limit: number = 20
  ) {
    const craftsman = await Craftsman.findById(craftsmanId);
    if (!craftsman) {
      throw new Error('Craftsman not found');
    }

    // Get craftsman's categories and service areas
    const categoryIds = craftsman.categories;
    const serviceAreas = craftsman.serviceAreas || [];

    const query: FilterQuery<IRequest> = {
      status: RequestStatus.PENDING,
      category: { $in: categoryIds },
      // Don't show requests where this craftsman already quoted
      'quotes.craftsman': { $ne: craftsmanId },
    };

    // Filter by service areas if defined
    if (serviceAreas.length > 0) {
      query.$or = serviceAreas.map((area: any) => ({
        'location.governorate': area.governorate,
        ...(area.city && { 'location.city': area.city }),
      }));
    }

    const skip = (page - 1) * limit;

    const [requests, total] = await Promise.all([
      Request.find(query)
        .populate('customer', 'name avatar')
        .populate('category', 'name nameAr icon')
        .sort({ urgency: -1, createdAt: -1 }) // Urgent first, then newest
        .skip(skip)
        .limit(limit)
        .lean(),
      Request.countDocuments(query),
    ]);

    return {
      requests,
      total,
      page,
      totalPages: Math.ceil(total / limit),
    };
  }

  // Get craftsman's active jobs
  async getCraftsmanActiveJobs(
    craftsmanId: string,
    page: number = 1,
    limit: number = 20
  ) {
    return this.getRequests(
      {
        craftsman: craftsmanId,
        status: [
          RequestStatus.ACCEPTED,
          RequestStatus.IN_PROGRESS,
          RequestStatus.ARRIVED,
        ],
      },
      page,
      limit
    );
  }

  // Get craftsman's completed jobs
  async getCraftsmanCompletedJobs(
    craftsmanId: string,
    page: number = 1,
    limit: number = 20
  ) {
    return this.getRequests(
      {
        craftsman: craftsmanId,
        status: RequestStatus.COMPLETED,
      },
      page,
      limit,
      'completedAt',
      'desc'
    );
  }

  // Submit a quote for a request
  async submitQuote(requestId: string, quoteData: QuoteData): Promise<IRequest> {
    const request = await Request.findById(requestId);
    if (!request) {
      throw new Error('Request not found');
    }

    if (request.status !== RequestStatus.PENDING) {
      throw new Error('Can only quote on pending requests');
    }

    // Check if craftsman already quoted
    const existingQuote = request.quotes?.find(
      (q) => q.craftsman.toString() === quoteData.craftsman
    );
    if (existingQuote) {
      throw new Error('You have already submitted a quote for this request');
    }

    // Verify craftsman exists and is approved
    const craftsman = await Craftsman.findById(quoteData.craftsman);
    if (!craftsman || craftsman.status !== 'approved') {
      throw new Error('Invalid craftsman');
    }

    // Add the quote
    request.quotes = request.quotes || [];
    request.quotes.push({
      craftsman: new mongoose.Types.ObjectId(quoteData.craftsman),
      amount: quoteData.amount,
      estimatedDuration: quoteData.estimatedDuration,
      notes: quoteData.notes,
      validUntil: quoteData.validUntil,
      status: 'pending',
      submittedAt: new Date(),
    });

    // Update request status to quoted if it was pending
    if (request.status === RequestStatus.PENDING) {
      request.status = RequestStatus.QUOTED;
    }

    await request.save();
    return request.populate({
      path: 'quotes.craftsman',
      select: 'displayName rating profileImage completedJobs',
    });
  }

  // Accept a quote
  async acceptQuote(requestId: string, quoteId: string, customerId: string): Promise<IRequest> {
    const request = await Request.findById(requestId);
    if (!request) {
      throw new Error('Request not found');
    }

    if (request.customer.toString() !== customerId) {
      throw new Error('Not authorized to accept quotes for this request');
    }

    if (![RequestStatus.PENDING, RequestStatus.QUOTED].includes(request.status as RequestStatus)) {
      throw new Error('Request is not in a state to accept quotes');
    }

    const quote = request.quotes?.find((q) => q._id?.toString() === quoteId);
    if (!quote) {
      throw new Error('Quote not found');
    }

    // Mark the accepted quote
    quote.status = 'accepted';

    // Reject other quotes
    request.quotes?.forEach((q) => {
      if (q._id?.toString() !== quoteId) {
        q.status = 'rejected';
      }
    });

    // Assign the craftsman
    request.assignedCraftsman = quote.craftsman;
    request.status = RequestStatus.ACCEPTED;
    request.acceptedQuote = {
      amount: quote.amount,
      estimatedDuration: quote.estimatedDuration,
    };

    await request.save();
    return this.getRequestById(requestId) as Promise<IRequest>;
  }

  // Reject a quote
  async rejectQuote(requestId: string, quoteId: string, customerId: string): Promise<IRequest> {
    const request = await Request.findById(requestId);
    if (!request) {
      throw new Error('Request not found');
    }

    if (request.customer.toString() !== customerId) {
      throw new Error('Not authorized to reject quotes for this request');
    }

    const quote = request.quotes?.find((q) => q._id?.toString() === quoteId);
    if (!quote) {
      throw new Error('Quote not found');
    }

    quote.status = 'rejected';
    await request.save();

    return this.getRequestById(requestId) as Promise<IRequest>;
  }

  // Update request (for customers)
  async updateRequest(
    requestId: string,
    customerId: string,
    updates: Partial<CreateRequestData>
  ): Promise<IRequest> {
    const request = await Request.findById(requestId);
    if (!request) {
      throw new Error('Request not found');
    }

    if (request.customer.toString() !== customerId) {
      throw new Error('Not authorized to update this request');
    }

    if (request.status !== RequestStatus.PENDING) {
      throw new Error('Can only update pending requests');
    }

    // Apply updates
    if (updates.title) request.title = updates.title;
    if (updates.description) request.description = updates.description;
    if (updates.preferredDate) request.preferredDate = updates.preferredDate;
    if (updates.preferredTime) request.preferredTime = updates.preferredTime;
    if (updates.images) request.images = updates.images;
    if (updates.budget) request.budget = updates.budget;
    if (updates.urgency) request.urgency = updates.urgency;

    await request.save();
    return this.getRequestById(requestId) as Promise<IRequest>;
  }

  // Cancel request (by customer)
  async cancelRequest(requestId: string, customerId: string, reason?: string): Promise<IRequest> {
    const request = await Request.findById(requestId);
    if (!request) {
      throw new Error('Request not found');
    }

    if (request.customer.toString() !== customerId) {
      throw new Error('Not authorized to cancel this request');
    }

    const cancellableStatuses = [
      RequestStatus.PENDING,
      RequestStatus.QUOTED,
      RequestStatus.ACCEPTED,
    ];

    if (!cancellableStatuses.includes(request.status as RequestStatus)) {
      throw new Error('Request cannot be cancelled in its current state');
    }

    request.status = RequestStatus.CANCELLED;
    request.cancellationReason = reason;
    request.cancelledAt = new Date();
    request.cancelledBy = 'customer';

    await request.save();
    return this.getRequestById(requestId) as Promise<IRequest>;
  }

  // Get request statistics for admin dashboard
  async getRequestStats(): Promise<{
    total: number;
    byStatus: Record<string, number>;
    byCategory: Array<{ category: string; count: number }>;
    todayCount: number;
    weekCount: number;
    monthCount: number;
  }> {
    const now = new Date();
    const startOfDay = new Date(now.setHours(0, 0, 0, 0));
    const startOfWeek = new Date(now);
    startOfWeek.setDate(startOfWeek.getDate() - 7);
    const startOfMonth = new Date(now);
    startOfMonth.setDate(startOfMonth.getDate() - 30);

    const [total, byStatus, byCategory, todayCount, weekCount, monthCount] =
      await Promise.all([
        Request.countDocuments(),
        Request.aggregate([
          { $group: { _id: '$status', count: { $sum: 1 } } },
        ]),
        Request.aggregate([
          { $group: { _id: '$category', count: { $sum: 1 } } },
          {
            $lookup: {
              from: 'categories',
              localField: '_id',
              foreignField: '_id',
              as: 'categoryInfo',
            },
          },
          { $unwind: '$categoryInfo' },
          {
            $project: {
              category: '$categoryInfo.nameAr',
              count: 1,
            },
          },
          { $sort: { count: -1 } },
          { $limit: 10 },
        ]),
        Request.countDocuments({ createdAt: { $gte: startOfDay } }),
        Request.countDocuments({ createdAt: { $gte: startOfWeek } }),
        Request.countDocuments({ createdAt: { $gte: startOfMonth } }),
      ]);

    const statusMap: Record<string, number> = {};
    byStatus.forEach((s) => {
      statusMap[s._id] = s.count;
    });

    return {
      total,
      byStatus: statusMap,
      byCategory,
      todayCount,
      weekCount,
      monthCount,
    };
  }

  // Delete request (admin only)
  async deleteRequest(requestId: string): Promise<void> {
    const result = await Request.findByIdAndDelete(requestId);
    if (!result) {
      throw new Error('Request not found');
    }
  }
}

export default new RequestService();
