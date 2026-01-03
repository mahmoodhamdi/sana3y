import { Request, Response, NextFunction } from 'express';
import requestService from '../services/request.service';
import statusService from '../services/status.service';
import { RequestStatus } from '../models/Request';

// Create a new service request
export const createRequest = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = (req as any).user.id;

    const requestData = {
      customer: userId,
      title: req.body.title,
      description: req.body.description,
      category: req.body.category,
      subcategory: req.body.subcategory,
      location: req.body.location,
      preferredDate: req.body.preferredDate,
      preferredTime: req.body.preferredTime,
      images: req.body.images,
      budget: req.body.budget,
      urgency: req.body.urgency || 'normal',
    };

    const request = await requestService.createRequest(requestData);

    res.status(201).json({
      success: true,
      data: request,
      message: 'تم إنشاء الطلب بنجاح',
    });
  } catch (error) {
    next(error);
  }
};

// Get all requests (admin)
export const getAllRequests = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const {
      page = 1,
      limit = 20,
      status,
      category,
      governorate,
      city,
      urgency,
      dateFrom,
      dateTo,
      search,
      sortBy = 'createdAt',
      sortOrder = 'desc',
    } = req.query;

    const filters = {
      status: status as RequestStatus | RequestStatus[],
      category: category as string,
      governorate: governorate as string,
      city: city as string,
      urgency: urgency as string,
      dateFrom: dateFrom ? new Date(dateFrom as string) : undefined,
      dateTo: dateTo ? new Date(dateTo as string) : undefined,
      search: search as string,
    };

    const result = await requestService.getRequests(
      filters,
      Number(page),
      Number(limit),
      sortBy as string,
      sortOrder as 'asc' | 'desc'
    );

    res.json({
      success: true,
      data: result.requests,
      pagination: {
        page: result.page,
        totalPages: result.totalPages,
        total: result.total,
        limit: Number(limit),
      },
    });
  } catch (error) {
    next(error);
  }
};

// Get single request by ID
export const getRequestById = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { id } = req.params;
    const request = await requestService.getRequestById(id);

    if (!request) {
      return res.status(404).json({
        success: false,
        message: 'الطلب غير موجود',
      });
    }

    res.json({
      success: true,
      data: request,
    });
  } catch (error) {
    next(error);
  }
};

// Get customer's requests
export const getMyRequests = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = (req as any).user.id;
    const { page = 1, limit = 20, status } = req.query;

    const result = await requestService.getCustomerRequests(
      userId,
      status as RequestStatus | RequestStatus[],
      Number(page),
      Number(limit)
    );

    res.json({
      success: true,
      data: result.requests,
      pagination: {
        page: result.page,
        totalPages: result.totalPages,
        total: result.total,
        limit: Number(limit),
      },
    });
  } catch (error) {
    next(error);
  }
};

// Get available requests for craftsman
export const getAvailableRequests = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const craftsmanId = (req as any).craftsman?.id;
    if (!craftsmanId) {
      return res.status(400).json({
        success: false,
        message: 'يجب أن تكون صنايعي للوصول لهذه الصفحة',
      });
    }

    const { page = 1, limit = 20 } = req.query;

    const result = await requestService.getAvailableRequestsForCraftsman(
      craftsmanId,
      Number(page),
      Number(limit)
    );

    res.json({
      success: true,
      data: result.requests,
      pagination: {
        page: result.page,
        totalPages: result.totalPages,
        total: result.total,
        limit: Number(limit),
      },
    });
  } catch (error) {
    next(error);
  }
};

// Get craftsman's active jobs
export const getMyActiveJobs = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const craftsmanId = (req as any).craftsman?.id;
    if (!craftsmanId) {
      return res.status(400).json({
        success: false,
        message: 'يجب أن تكون صنايعي للوصول لهذه الصفحة',
      });
    }

    const { page = 1, limit = 20 } = req.query;

    const result = await requestService.getCraftsmanActiveJobs(
      craftsmanId,
      Number(page),
      Number(limit)
    );

    res.json({
      success: true,
      data: result.requests,
      pagination: {
        page: result.page,
        totalPages: result.totalPages,
        total: result.total,
        limit: Number(limit),
      },
    });
  } catch (error) {
    next(error);
  }
};

// Get craftsman's completed jobs
export const getMyCompletedJobs = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const craftsmanId = (req as any).craftsman?.id;
    if (!craftsmanId) {
      return res.status(400).json({
        success: false,
        message: 'يجب أن تكون صنايعي للوصول لهذه الصفحة',
      });
    }

    const { page = 1, limit = 20 } = req.query;

    const result = await requestService.getCraftsmanCompletedJobs(
      craftsmanId,
      Number(page),
      Number(limit)
    );

    res.json({
      success: true,
      data: result.requests,
      pagination: {
        page: result.page,
        totalPages: result.totalPages,
        total: result.total,
        limit: Number(limit),
      },
    });
  } catch (error) {
    next(error);
  }
};

// Submit a quote for a request
export const submitQuote = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { id } = req.params;
    const craftsmanId = (req as any).craftsman?.id;

    if (!craftsmanId) {
      return res.status(400).json({
        success: false,
        message: 'يجب أن تكون صنايعي لتقديم عرض سعر',
      });
    }

    const quoteData = {
      craftsman: craftsmanId,
      amount: req.body.amount,
      estimatedDuration: req.body.estimatedDuration,
      notes: req.body.notes,
      validUntil: req.body.validUntil,
    };

    const request = await requestService.submitQuote(id, quoteData);

    res.json({
      success: true,
      data: request,
      message: 'تم تقديم عرض السعر بنجاح',
    });
  } catch (error) {
    next(error);
  }
};

// Accept a quote
export const acceptQuote = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { id, quoteId } = req.params;
    const userId = (req as any).user.id;

    const request = await requestService.acceptQuote(id, quoteId, userId);

    res.json({
      success: true,
      data: request,
      message: 'تم قبول العرض بنجاح',
    });
  } catch (error) {
    next(error);
  }
};

// Reject a quote
export const rejectQuote = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { id, quoteId } = req.params;
    const userId = (req as any).user.id;

    const request = await requestService.rejectQuote(id, quoteId, userId);

    res.json({
      success: true,
      data: request,
      message: 'تم رفض العرض',
    });
  } catch (error) {
    next(error);
  }
};

// Update request status
export const updateRequestStatus = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { id } = req.params;
    const { status, cancellationReason, completionNotes, disputeReason, actualAmount } = req.body;
    const userId = (req as any).user.id;
    const userRole = (req as any).user.role;

    // Determine the role for status service
    let role: 'customer' | 'craftsman' | 'admin' = 'customer';
    if (userRole === 'admin') {
      role = 'admin';
    } else if ((req as any).craftsman) {
      role = 'craftsman';
    }

    const request = await statusService.updateStatus(
      id,
      status as RequestStatus,
      role === 'craftsman' ? (req as any).craftsman.id : userId,
      role,
      { cancellationReason, completionNotes, disputeReason, actualAmount }
    );

    res.json({
      success: true,
      data: request,
      message: 'تم تحديث حالة الطلب',
    });
  } catch (error) {
    next(error);
  }
};

// Update request (customer only, pending requests)
export const updateRequest = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { id } = req.params;
    const userId = (req as any).user.id;

    const updates = {
      title: req.body.title,
      description: req.body.description,
      preferredDate: req.body.preferredDate,
      preferredTime: req.body.preferredTime,
      images: req.body.images,
      budget: req.body.budget,
      urgency: req.body.urgency,
    };

    const request = await requestService.updateRequest(id, userId, updates);

    res.json({
      success: true,
      data: request,
      message: 'تم تحديث الطلب بنجاح',
    });
  } catch (error) {
    next(error);
  }
};

// Cancel request
export const cancelRequest = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { id } = req.params;
    const userId = (req as any).user.id;
    const { reason } = req.body;

    const request = await requestService.cancelRequest(id, userId, reason);

    res.json({
      success: true,
      data: request,
      message: 'تم إلغاء الطلب',
    });
  } catch (error) {
    next(error);
  }
};

// Get request statistics (admin)
export const getRequestStats = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const stats = await requestService.getRequestStats();

    res.json({
      success: true,
      data: stats,
    });
  } catch (error) {
    next(error);
  }
};

// Get status timeline
export const getStatusTimeline = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { id } = req.params;
    const timeline = await statusService.getStatusTimeline(id);

    res.json({
      success: true,
      data: timeline,
    });
  } catch (error) {
    next(error);
  }
};

// Get all statuses info
export const getStatuses = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const statuses = statusService.getAllStatuses();

    res.json({
      success: true,
      data: statuses,
    });
  } catch (error) {
    next(error);
  }
};

// Delete request (admin only)
export const deleteRequest = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { id } = req.params;
    await requestService.deleteRequest(id);

    res.json({
      success: true,
      message: 'تم حذف الطلب',
    });
  } catch (error) {
    next(error);
  }
};
