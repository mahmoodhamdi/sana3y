import { Request, Response, NextFunction } from 'express';
import { sendSuccess, sendPaginated, sendCreated } from '@utils/response';
import { BadRequestError, NotFoundError } from '@utils/errors';
import User from '@models/User';
import Customer from '@models/Customer';
import Craftsman from '@models/Craftsman';
import ServiceRequest from '@models/ServiceRequest';
import Transaction from '@models/Transaction';
import Zone from '@models/Zone';
import Setting from '@models/Setting';
import Notification from '@models/Notification';
import ServiceCategory from '@models/ServiceCategory';
import Joi from 'joi';

// ============================================
// Dashboard Stats
// ============================================

/**
 * Get dashboard statistics
 * GET /api/v1/admin/dashboard
 */
export const getDashboardStats = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const [
      totalRequests,
      activeRequests,
      completedRequests,
      totalCraftsmen,
      activeCraftsmen,
      pendingCraftsmen,
      totalCustomers,
      activeCustomers,
      recentRequests,
      recentCraftsmen,
      transactions,
    ] = await Promise.all([
      ServiceRequest.countDocuments(),
      ServiceRequest.countDocuments({ status: { $in: ['pending', 'quoted', 'accepted', 'in_progress'] } }),
      ServiceRequest.countDocuments({ status: 'completed' }),
      Craftsman.countDocuments(),
      Craftsman.countDocuments({ status: 'approved', isOnline: true }),
      Craftsman.countDocuments({ status: 'pending' }),
      Customer.countDocuments(),
      User.countDocuments({ role: 'customer', isActive: true }),
      ServiceRequest.find()
        .sort({ createdAt: -1 })
        .limit(5)
        .populate('customerId', 'userId')
        .populate({
          path: 'customerId',
          populate: { path: 'userId', select: 'name' },
        })
        .lean(),
      Craftsman.find({ status: 'pending' })
        .sort({ createdAt: -1 })
        .limit(5)
        .populate('userId', 'name')
        .populate('categoryId', 'nameAr')
        .lean(),
      Transaction.aggregate([
        {
          $group: {
            _id: null,
            totalRevenue: { $sum: { $cond: [{ $eq: ['$status', 'completed'] }, '$fee', 0] } },
            monthlyRevenue: {
              $sum: {
                $cond: [
                  {
                    $and: [
                      { $eq: ['$status', 'completed'] },
                      { $gte: ['$createdAt', new Date(new Date().setDate(1))] },
                    ],
                  },
                  '$fee',
                  0,
                ],
              },
            },
            pendingPayouts: { $sum: { $cond: [{ $eq: ['$status', 'pending'] }, '$amount', 0] } },
          },
        },
      ]),
    ]);

    const stats = {
      totalRequests,
      activeRequests,
      completedRequests,
      totalCraftsmen,
      activeCraftsmen,
      pendingCraftsmen,
      totalCustomers,
      activeCustomers,
      totalRevenue: transactions[0]?.totalRevenue || 0,
      monthlyRevenue: transactions[0]?.monthlyRevenue || 0,
      pendingPayouts: transactions[0]?.pendingPayouts || 0,
      recentRequests: recentRequests.map((r: any) => ({
        _id: r._id,
        title: r.title || r.description?.substring(0, 50),
        status: r.status,
        customerName: r.customerId?.userId?.name || 'Unknown',
        createdAt: r.createdAt,
      })),
      recentCraftsmen: recentCraftsmen.map((c: any) => ({
        _id: c._id,
        name: c.userId?.name || 'Unknown',
        category: c.categoryId?.nameAr || 'Unknown',
        status: c.status,
        createdAt: c.createdAt,
      })),
    };

    return sendSuccess(res, stats, 'تم جلب إحصائيات لوحة التحكم');
  } catch (err) {
    next(err);
  }
};

// ============================================
// Customers Management
// ============================================

/**
 * Get all customers with pagination
 * GET /api/v1/admin/customers
 */
export const getCustomers = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const page = parseInt(req.query.page as string) || 1;
    const limit = parseInt(req.query.limit as string) || 20;
    const search = req.query.search as string;
    const status = req.query.status as string;

    const skip = (page - 1) * limit;

    // Build user filter for search and status
    const userFilter: any = { role: 'customer' };
    if (search) {
      userFilter.$or = [
        { name: { $regex: search, $options: 'i' } },
        { email: { $regex: search, $options: 'i' } },
      ];
    }
    if (status === 'active') userFilter.isActive = true;
    if (status === 'inactive') userFilter.isActive = false;

    // Get matching user IDs
    const matchingUsers = await User.find(userFilter).select('_id').lean();
    const userIds = matchingUsers.map((u) => u._id);

    const [customers, total] = await Promise.all([
      Customer.find({ userId: { $in: userIds } })
        .populate('userId', 'name email isActive createdAt')
        .sort({ createdAt: -1 })
        .skip(skip)
        .limit(limit)
        .lean(),
      Customer.countDocuments({ userId: { $in: userIds } }),
    ]);

    return sendPaginated(res, customers, page, limit, total, 'تم جلب قائمة العملاء');
  } catch (err) {
    next(err);
  }
};

/**
 * Get single customer details
 * GET /api/v1/admin/customers/:id
 */
export const getCustomerById = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const customer = await Customer.findById(req.params.id)
      .populate('userId', 'name email avatar isActive isVerified createdAt lastLoginAt')
      .populate('favoriteCraftsmen', 'userId')
      .lean();

    if (!customer) {
      throw new NotFoundError('العميل غير موجود');
    }

    return sendSuccess(res, customer, 'تم جلب بيانات العميل');
  } catch (err) {
    next(err);
  }
};

/**
 * Toggle customer status (active/inactive)
 * PUT /api/v1/admin/customers/:id/status
 */
export const toggleCustomerStatus = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { isActive } = req.body;

    const customer = await Customer.findById(req.params.id);
    if (!customer) {
      throw new NotFoundError('العميل غير موجود');
    }

    await User.findByIdAndUpdate(customer.userId, { isActive });

    return sendSuccess(res, { isActive }, isActive ? 'تم تفعيل الحساب' : 'تم تعطيل الحساب');
  } catch (err) {
    next(err);
  }
};

// ============================================
// Craftsmen Management (Admin)
// ============================================

/**
 * Get all craftsmen for admin
 * GET /api/v1/admin/craftsmen
 */
export const getCraftsmenAdmin = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const page = parseInt(req.query.page as string) || 1;
    const limit = parseInt(req.query.limit as string) || 20;
    const search = req.query.search as string;
    const status = req.query.status as string;
    const category = req.query.category as string;

    const skip = (page - 1) * limit;

    const filter: any = {};
    if (status) filter.status = status;
    if (category) filter.categoryId = category;

    // Search by name
    if (search) {
      const matchingUsers = await User.find({
        role: 'craftsman',
        name: { $regex: search, $options: 'i' },
      })
        .select('_id')
        .lean();
      filter.userId = { $in: matchingUsers.map((u) => u._id) };
    }

    const [craftsmen, total] = await Promise.all([
      Craftsman.find(filter)
        .populate('userId', 'name email avatar isActive createdAt')
        .populate('services.categoryId', 'nameAr icon')
        .sort({ createdAt: -1 })
        .skip(skip)
        .limit(limit)
        .lean(),
      Craftsman.countDocuments(filter),
    ]);

    return sendPaginated(res, craftsmen, page, limit, total, 'تم جلب قائمة الصنايعية');
  } catch (err) {
    next(err);
  }
};

/**
 * Get pending craftsmen for approval
 * GET /api/v1/admin/craftsmen/pending
 */
export const getPendingCraftsmenAdmin = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const page = parseInt(req.query.page as string) || 1;
    const limit = parseInt(req.query.limit as string) || 20;
    const skip = (page - 1) * limit;

    const [craftsmen, total] = await Promise.all([
      Craftsman.find({ status: 'pending' })
        .populate('userId', 'name email avatar createdAt')
        .populate('services.categoryId', 'nameAr icon')
        .sort({ createdAt: -1 })
        .skip(skip)
        .limit(limit)
        .lean(),
      Craftsman.countDocuments({ status: 'pending' }),
    ]);

    return sendPaginated(res, craftsmen, page, limit, total, 'تم جلب قائمة الصنايعية المعلقين');
  } catch (err) {
    next(err);
  }
};

/**
 * Update craftsman status (approve/reject/suspend)
 * PUT /api/v1/admin/craftsmen/:id/status
 */
export const updateCraftsmanStatusAdmin = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const schema = Joi.object({
      status: Joi.string().valid('approved', 'rejected', 'suspended').required(),
      reason: Joi.string().when('status', {
        is: Joi.valid('rejected', 'suspended'),
        then: Joi.string().required(),
        otherwise: Joi.string().optional(),
      }),
    });

    const { error, value } = schema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const craftsman = await Craftsman.findById(req.params.id);
    if (!craftsman) {
      throw new NotFoundError('الصنايعي غير موجود');
    }

    craftsman.status = value.status;
    if (value.reason) {
      craftsman.rejectionReason = value.reason;
    }
    await craftsman.save();

    // Send notification to craftsman
    const statusMessages: Record<string, string> = {
      approved: 'تهانينا! تم قبول طلبك وأصبحت صنايعي معتمد',
      rejected: `تم رفض طلبك: ${value.reason}`,
      suspended: `تم تعليق حسابك: ${value.reason}`,
    };

    await Notification.create({
      userId: craftsman.userId,
      type: 'system',
      title: 'تحديث حالة الحساب',
      body: statusMessages[value.status],
    });

    return sendSuccess(res, { status: value.status }, 'تم تحديث حالة الصنايعي');
  } catch (err) {
    next(err);
  }
};

/**
 * Approve craftsman (convenience endpoint)
 * POST /api/v1/admin/craftsmen/:id/approve
 */
export const approveCraftsman = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const craftsman = await Craftsman.findById(req.params.id);
    if (!craftsman) {
      throw new NotFoundError('الصنايعي غير موجود');
    }

    craftsman.status = 'approved';
    await craftsman.save();

    await Notification.create({
      userId: craftsman.userId,
      type: 'system',
      title: 'تحديث حالة الحساب',
      body: 'تهانينا! تم قبول طلبك وأصبحت صنايعي معتمد',
    });

    return sendSuccess(res, { status: 'approved' }, 'تم قبول الصنايعي');
  } catch (err) {
    next(err);
  }
};

/**
 * Reject craftsman (convenience endpoint)
 * POST /api/v1/admin/craftsmen/:id/reject
 */
export const rejectCraftsman = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { reason } = req.body;
    if (!reason) {
      throw new BadRequestError('يجب ذكر سبب الرفض');
    }

    const craftsman = await Craftsman.findById(req.params.id);
    if (!craftsman) {
      throw new NotFoundError('الصنايعي غير موجود');
    }

    craftsman.status = 'rejected';
    craftsman.rejectionReason = reason;
    await craftsman.save();

    await Notification.create({
      userId: craftsman.userId,
      type: 'system',
      title: 'تحديث حالة الحساب',
      body: `تم رفض طلبك: ${reason}`,
    });

    return sendSuccess(res, { status: 'rejected' }, 'تم رفض الصنايعي');
  } catch (err) {
    next(err);
  }
};

/**
 * Suspend craftsman (convenience endpoint)
 * POST /api/v1/admin/craftsmen/:id/suspend
 */
export const suspendCraftsman = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { reason } = req.body;
    if (!reason) {
      throw new BadRequestError('يجب ذكر سبب التعليق');
    }

    const craftsman = await Craftsman.findById(req.params.id);
    if (!craftsman) {
      throw new NotFoundError('الصنايعي غير موجود');
    }

    craftsman.status = 'suspended';
    craftsman.rejectionReason = reason;
    await craftsman.save();

    await Notification.create({
      userId: craftsman.userId,
      type: 'system',
      title: 'تحديث حالة الحساب',
      body: `تم تعليق حسابك: ${reason}`,
    });

    return sendSuccess(res, { status: 'suspended' }, 'تم تعليق الصنايعي');
  } catch (err) {
    next(err);
  }
};

// ============================================
// Requests Management (Admin)
// ============================================

/**
 * Get all requests for admin
 * GET /api/v1/admin/requests
 */
export const getRequestsAdmin = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const page = parseInt(req.query.page as string) || 1;
    const limit = parseInt(req.query.limit as string) || 20;
    const status = req.query.status as string;
    const category = req.query.category as string;
    const dateFrom = req.query.dateFrom as string;
    const dateTo = req.query.dateTo as string;
    const search = req.query.search as string;

    const skip = (page - 1) * limit;

    const filter: any = {};
    if (status) filter.status = status;
    if (category) filter.categoryId = category;
    if (dateFrom || dateTo) {
      filter.createdAt = {};
      if (dateFrom) filter.createdAt.$gte = new Date(dateFrom);
      if (dateTo) filter.createdAt.$lte = new Date(dateTo);
    }

    const [requests, total] = await Promise.all([
      ServiceRequest.find(filter)
        .populate({
          path: 'customerId',
          populate: { path: 'userId', select: 'name' },
        })
        .populate({
          path: 'craftsmanId',
          populate: { path: 'userId', select: 'name' },
        })
        .populate('categoryId', 'nameAr')
        .sort({ createdAt: -1 })
        .skip(skip)
        .limit(limit)
        .lean(),
      ServiceRequest.countDocuments(filter),
    ]);

    return sendPaginated(res, requests, page, limit, total, 'تم جلب قائمة الطلبات');
  } catch (err) {
    next(err);
  }
};

// ============================================
// Transactions/Finance
// ============================================

/**
 * Get all transactions
 * GET /api/v1/admin/transactions
 */
export const getTransactions = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const page = parseInt(req.query.page as string) || 1;
    const limit = parseInt(req.query.limit as string) || 20;
    const type = req.query.type as string;
    const status = req.query.status as string;
    const dateFrom = req.query.dateFrom as string;
    const dateTo = req.query.dateTo as string;

    const skip = (page - 1) * limit;

    const filter: any = {};
    if (type) filter.type = type;
    if (status) filter.status = status;
    if (dateFrom || dateTo) {
      filter.createdAt = {};
      if (dateFrom) filter.createdAt.$gte = new Date(dateFrom);
      if (dateTo) filter.createdAt.$lte = new Date(dateTo);
    }

    const [transactions, total] = await Promise.all([
      Transaction.find(filter)
        .populate('fromUserId', 'name email')
        .populate('toUserId', 'name email')
        .sort({ createdAt: -1 })
        .skip(skip)
        .limit(limit)
        .lean(),
      Transaction.countDocuments(filter),
    ]);

    return sendPaginated(res, transactions, page, limit, total, 'تم جلب المعاملات');
  } catch (err) {
    next(err);
  }
};

/**
 * Get finance statistics
 * GET /api/v1/admin/transactions/stats
 */
export const getFinanceStats = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const startOfMonth = new Date(new Date().setDate(1));
    startOfMonth.setHours(0, 0, 0, 0);

    const stats = await Transaction.aggregate([
      {
        $facet: {
          totals: [
            {
              $group: {
                _id: null,
                totalRevenue: { $sum: { $cond: [{ $eq: ['$status', 'completed'] }, '$fee', 0] } },
                totalCommissions: {
                  $sum: { $cond: [{ $eq: ['$type', 'commission'] }, '$amount', 0] },
                },
                pendingPayouts: {
                  $sum: {
                    $cond: [
                      { $and: [{ $eq: ['$type', 'payout'] }, { $eq: ['$status', 'pending'] }] },
                      '$amount',
                      0,
                    ],
                  },
                },
                completedPayouts: {
                  $sum: {
                    $cond: [
                      { $and: [{ $eq: ['$type', 'payout'] }, { $eq: ['$status', 'completed'] }] },
                      '$amount',
                      0,
                    ],
                  },
                },
              },
            },
          ],
          monthly: [
            {
              $match: { createdAt: { $gte: startOfMonth } },
            },
            {
              $group: {
                _id: null,
                monthlyRevenue: { $sum: { $cond: [{ $eq: ['$status', 'completed'] }, '$fee', 0] } },
              },
            },
          ],
        },
      },
    ]);

    const result = {
      totalRevenue: stats[0].totals[0]?.totalRevenue || 0,
      monthlyRevenue: stats[0].monthly[0]?.monthlyRevenue || 0,
      totalCommissions: stats[0].totals[0]?.totalCommissions || 0,
      pendingPayouts: stats[0].totals[0]?.pendingPayouts || 0,
      completedPayouts: stats[0].totals[0]?.completedPayouts || 0,
    };

    return sendSuccess(res, result, 'تم جلب إحصائيات المالية');
  } catch (err) {
    next(err);
  }
};

// ============================================
// Zones Management
// ============================================

/**
 * Get all zones
 * GET /api/v1/admin/zones
 */
export const getZones = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const page = parseInt(req.query.page as string) || 1;
    const limit = parseInt(req.query.limit as string) || 50;
    const skip = (page - 1) * limit;

    const [zones, total] = await Promise.all([
      Zone.find().sort({ createdAt: -1 }).skip(skip).limit(limit).lean(),
      Zone.countDocuments(),
    ]);

    return sendPaginated(res, zones, page, limit, total, 'تم جلب المناطق');
  } catch (err) {
    next(err);
  }
};

/**
 * Create new zone
 * POST /api/v1/admin/zones
 */
export const createZone = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const schema = Joi.object({
      name: Joi.string().required(),
      nameAr: Joi.string().required(),
      type: Joi.string().valid('polygon', 'circle').required(),
      polygon: Joi.when('type', {
        is: 'polygon',
        then: Joi.object({
          type: Joi.string().valid('Polygon').default('Polygon'),
          coordinates: Joi.array().items(Joi.array().items(Joi.array().items(Joi.number()))).required(),
        }).required(),
        otherwise: Joi.forbidden(),
      }),
      center: Joi.when('type', {
        is: 'circle',
        then: Joi.object({
          type: Joi.string().valid('Point').default('Point'),
          coordinates: Joi.array().items(Joi.number()).length(2).required(),
        }).required(),
        otherwise: Joi.forbidden(),
      }),
      radius: Joi.when('type', {
        is: 'circle',
        then: Joi.number().positive().required(),
        otherwise: Joi.forbidden(),
      }),
      serviceFee: Joi.number().min(0).default(5),
      isActive: Joi.boolean().default(true),
    });

    const { error, value } = schema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const zone = await Zone.create(value);

    return sendCreated(res, zone, 'تم إنشاء المنطقة');
  } catch (err) {
    next(err);
  }
};

/**
 * Update zone
 * PUT /api/v1/admin/zones/:id
 */
export const updateZone = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const zone = await Zone.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
      runValidators: true,
    });

    if (!zone) {
      throw new NotFoundError('المنطقة غير موجودة');
    }

    return sendSuccess(res, zone, 'تم تحديث المنطقة');
  } catch (err) {
    next(err);
  }
};

/**
 * Delete zone
 * DELETE /api/v1/admin/zones/:id
 */
export const deleteZone = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const zone = await Zone.findByIdAndDelete(req.params.id);

    if (!zone) {
      throw new NotFoundError('المنطقة غير موجودة');
    }

    return sendSuccess(res, null, 'تم حذف المنطقة');
  } catch (err) {
    next(err);
  }
};

// ============================================
// Settings Management
// ============================================

/**
 * Get all settings
 * GET /api/v1/admin/settings
 */
export const getSettings = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const settings = await Setting.find().lean();

    // Convert to key-value object
    const settingsObj: Record<string, unknown> = {};
    settings.forEach((s) => {
      settingsObj[s.key] = s.value;
    });

    // Add defaults if not set
    const defaults: Record<string, unknown> = {
      commissionRate: 15,
      serviceFee: 5,
      urgentFee: 20,
      defaultRadius: 10,
      minWithdrawal: 100,
      maxWithdrawal: 10000,
      supportPhone: '+201000000000',
      supportEmail: 'support@sana3y.com',
    };

    const result = { ...defaults, ...settingsObj };

    return sendSuccess(res, result, 'تم جلب الإعدادات');
  } catch (err) {
    next(err);
  }
};

/**
 * Update settings
 * PUT /api/v1/admin/settings
 */
export const updateSettings = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const userId = req.user?._id;
    const updates = req.body;

    const settingTypes: Record<string, 'string' | 'number' | 'boolean'> = {
      commissionRate: 'number',
      serviceFee: 'number',
      urgentFee: 'number',
      defaultRadius: 'number',
      minWithdrawal: 'number',
      maxWithdrawal: 'number',
      supportPhone: 'string',
      supportEmail: 'string',
      termsUrl: 'string',
      privacyUrl: 'string',
    };

    const results: Record<string, unknown> = {};

    for (const [key, value] of Object.entries(updates)) {
      if (settingTypes[key]) {
        await Setting.findOneAndUpdate(
          { key },
          {
            value,
            type: settingTypes[key],
            isPublic: ['supportPhone', 'supportEmail', 'termsUrl', 'privacyUrl'].includes(key),
            updatedBy: userId,
          },
          { upsert: true, new: true }
        );
        results[key] = value;
      }
    }

    return sendSuccess(res, results, 'تم تحديث الإعدادات');
  } catch (err) {
    next(err);
  }
};

// ============================================
// Notifications Management
// ============================================

/**
 * Get sent notifications (admin)
 * GET /api/v1/admin/notifications
 */
export const getAdminNotifications = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const page = parseInt(req.query.page as string) || 1;
    const limit = parseInt(req.query.limit as string) || 20;
    const skip = (page - 1) * limit;

    // Get broadcast notifications sent by admins
    const [notifications, total] = await Promise.all([
      Notification.find({ type: 'system', isBroadcast: true })
        .sort({ createdAt: -1 })
        .skip(skip)
        .limit(limit)
        .lean(),
      Notification.countDocuments({ type: 'system', isBroadcast: true }),
    ]);

    return sendPaginated(res, notifications, page, limit, total, 'تم جلب الإشعارات');
  } catch (err) {
    next(err);
  }
};

/**
 * Send broadcast notification
 * POST /api/v1/admin/notifications
 */
export const sendBroadcastNotification = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const schema = Joi.object({
      title: Joi.string().required(),
      titleAr: Joi.string().required(),
      body: Joi.string().required(),
      bodyAr: Joi.string().required(),
      type: Joi.string().valid('all', 'customers', 'craftsmen').required(),
    });

    const { error, value } = schema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    // Get target users based on type
    let userFilter: any = {};
    if (value.type === 'customers') {
      userFilter.role = 'customer';
    } else if (value.type === 'craftsmen') {
      userFilter.role = 'craftsman';
    }

    const users = await User.find(userFilter).select('_id').lean();

    // Create notifications for all users
    const notifications = users.map((user) => ({
      userId: user._id,
      type: 'system',
      title: value.titleAr,
      body: value.bodyAr,
      isBroadcast: true,
    }));

    await Notification.insertMany(notifications);

    // TODO: Send FCM push notifications

    return sendCreated(
      res,
      { recipientCount: users.length },
      `تم إرسال الإشعار إلى ${users.length} مستخدم`
    );
  } catch (err) {
    next(err);
  }
};
