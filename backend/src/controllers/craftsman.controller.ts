import { Request, Response, NextFunction } from 'express';
import craftsmanService from '@services/craftsman.service';
import { sendSuccess, sendCreated, sendPaginated } from '@utils/response';
import { BadRequestError, UnauthorizedError } from '@utils/errors';
import {
  createCraftsmanProfileSchema,
  updateCraftsmanProfileSchema,
  updateCraftsmanStatusSchema,
  getCraftsmenQuerySchema,
  toggleOnlineSchema,
  toggleAvailabilitySchema,
} from '@validators/craftsman.validator';

/**
 * Get all craftsmen (Admin - with filters)
 * GET /api/v1/craftsmen
 */
export const getCraftsmen = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { error, value } = getCraftsmenQuerySchema.validate(req.query);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const result = await craftsmanService.getCraftsmen(value);

    sendPaginated(
      res,
      result.data,
      result.page,
      result.limit,
      result.total,
      'تم جلب الصنايعية بنجاح'
    );
  } catch (err) {
    next(err);
  }
};

/**
 * Get approved craftsmen (Public)
 * GET /api/v1/craftsmen/public
 */
export const getApprovedCraftsmen = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { error, value } = getCraftsmenQuerySchema.validate(req.query);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const result = await craftsmanService.getApprovedCraftsmen(value);

    sendPaginated(
      res,
      result.data,
      result.page,
      result.limit,
      result.total,
      'تم جلب الصنايعية بنجاح'
    );
  } catch (err) {
    next(err);
  }
};

/**
 * Get craftsmen by category
 * GET /api/v1/craftsmen/category/:categoryId
 */
export const getCraftsmenByCategory = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { categoryId } = req.params;
    const limit = req.query.limit ? parseInt(req.query.limit as string, 10) : 10;

    const craftsmen = await craftsmanService.getCraftsmenByCategory(categoryId, limit);
    sendSuccess(res, craftsmen, 'تم جلب الصنايعية بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Get nearby craftsmen
 * GET /api/v1/craftsmen/nearby
 */
export const getNearbyCraftsmen = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { lat, lng, radius, categoryId, limit } = req.query;

    if (!lat || !lng) {
      throw new BadRequestError('الموقع مطلوب');
    }

    const craftsmen = await craftsmanService.getNearbyCraftsmen(
      parseFloat(lng as string),
      parseFloat(lat as string),
      radius ? parseFloat(radius as string) : 10,
      categoryId as string,
      limit ? parseInt(limit as string, 10) : 20
    );

    sendSuccess(res, craftsmen, 'تم جلب الصنايعية القريبين بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Get featured craftsmen
 * GET /api/v1/craftsmen/featured
 */
export const getFeaturedCraftsmen = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const limit = req.query.limit ? parseInt(req.query.limit as string, 10) : 10;
    const craftsmen = await craftsmanService.getFeaturedCraftsmen(limit);
    sendSuccess(res, craftsmen, 'تم جلب الصنايعية المميزين بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Get pending craftsmen (Admin)
 * GET /api/v1/craftsmen/pending
 */
export const getPendingCraftsmen = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const page = req.query.page ? parseInt(req.query.page as string, 10) : 1;
    const limit = req.query.limit ? parseInt(req.query.limit as string, 10) : 20;

    const result = await craftsmanService.getPendingCraftsmen(page, limit);

    sendPaginated(
      res,
      result.data,
      result.page,
      result.limit,
      result.total,
      'تم جلب طلبات الموافقة بنجاح'
    );
  } catch (err) {
    next(err);
  }
};

/**
 * Get craftsman by ID
 * GET /api/v1/craftsmen/:id
 */
export const getCraftsmanById = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { id } = req.params;
    const craftsman = await craftsmanService.getCraftsmanById(id);
    sendSuccess(res, craftsman, 'تم جلب بيانات الصنايعي بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Get my craftsman profile
 * GET /api/v1/craftsmen/me
 */
export const getMyProfile = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    const craftsman = await craftsmanService.getCraftsmanByUserId(req.user.userId);
    sendSuccess(res, craftsman, 'تم جلب بياناتك بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Create craftsman profile
 * POST /api/v1/craftsmen/profile
 */
export const createCraftsmanProfile = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    const { error, value } = createCraftsmanProfileSchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const craftsman = await craftsmanService.createCraftsmanProfile(req.user.userId, value);
    sendCreated(res, craftsman, 'تم إنشاء ملف الصنايعي بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Update craftsman profile
 * PUT /api/v1/craftsmen/profile
 */
export const updateCraftsmanProfile = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    const { error, value } = updateCraftsmanProfileSchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const craftsman = await craftsmanService.updateCraftsmanProfile(req.user.userId, value);
    sendSuccess(res, craftsman, 'تم تحديث بياناتك بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Update craftsman status (Admin only)
 * PUT /api/v1/craftsmen/:id/status
 */
export const updateCraftsmanStatus = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    const { id } = req.params;
    const { error, value } = updateCraftsmanStatusSchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const craftsman = await craftsmanService.updateCraftsmanStatus(id, req.user.userId, value);
    sendSuccess(res, craftsman, 'تم تحديث حالة الصنايعي بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Toggle online status
 * PUT /api/v1/craftsmen/online
 */
export const toggleOnline = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    const { error, value } = toggleOnlineSchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const craftsman = await craftsmanService.toggleOnlineStatus(req.user.userId, value.isOnline);
    sendSuccess(res, craftsman, value.isOnline ? 'أنت الآن متصل' : 'أنت الآن غير متصل');
  } catch (err) {
    next(err);
  }
};

/**
 * Toggle availability
 * PUT /api/v1/craftsmen/availability
 */
export const toggleAvailability = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    const { error, value } = toggleAvailabilitySchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const craftsman = await craftsmanService.toggleAvailability(req.user.userId, value.isAvailable);
    sendSuccess(res, craftsman, value.isAvailable ? 'أنت الآن متاح للعمل' : 'أنت الآن غير متاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Add work photos
 * POST /api/v1/craftsmen/photos
 */
export const addWorkPhotos = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    const { photos } = req.body;
    if (!photos || !Array.isArray(photos) || photos.length === 0) {
      throw new BadRequestError('يجب توفير الصور');
    }

    const craftsman = await craftsmanService.addWorkPhotos(req.user.userId, photos);
    sendSuccess(res, craftsman, 'تم إضافة الصور بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Remove work photo
 * DELETE /api/v1/craftsmen/photos
 */
export const removeWorkPhoto = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    const { photoUrl } = req.body;
    if (!photoUrl) {
      throw new BadRequestError('يجب توفير رابط الصورة');
    }

    const craftsman = await craftsmanService.removeWorkPhoto(req.user.userId, photoUrl);
    sendSuccess(res, craftsman, 'تم حذف الصورة بنجاح');
  } catch (err) {
    next(err);
  }
};
