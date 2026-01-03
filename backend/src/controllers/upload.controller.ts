import { Request, Response, NextFunction } from 'express';
import uploadService, { ImageFolder } from '@services/upload.service';
import { sendSuccess } from '@utils/response';
import { BadRequestError, UnauthorizedError } from '@utils/errors';

/**
 * Upload a single image
 * POST /api/v1/upload/image
 */
export const uploadImage = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    if (!req.file) {
      throw new BadRequestError('يرجى اختيار صورة للرفع');
    }

    const folder = (req.query.folder as ImageFolder) || 'profiles';
    const validFolders: ImageFolder[] = [
      'profiles',
      'covers',
      'work-photos',
      'documents',
      'categories',
      'requests',
    ];

    if (!validFolders.includes(folder)) {
      throw new BadRequestError('مجلد غير صالح');
    }

    const result = await uploadService.uploadImage(req.file.buffer, { folder });
    sendSuccess(res, result, 'تم رفع الصورة بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Upload multiple images
 * POST /api/v1/upload/images
 */
export const uploadImages = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    const files = req.files as Express.Multer.File[];
    if (!files || files.length === 0) {
      throw new BadRequestError('يرجى اختيار صور للرفع');
    }

    const folder = (req.query.folder as ImageFolder) || 'work-photos';
    const buffers = files.map((file) => file.buffer);

    const results = await uploadService.uploadImages(buffers, { folder });
    sendSuccess(res, results, 'تم رفع الصور بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Upload profile image
 * POST /api/v1/upload/profile
 */
export const uploadProfileImage = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    if (!req.file) {
      throw new BadRequestError('يرجى اختيار صورة للرفع');
    }

    const result = await uploadService.uploadImage(req.file.buffer, {
      folder: 'profiles',
    });

    sendSuccess(res, result, 'تم رفع الصورة الشخصية بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Upload cover image
 * POST /api/v1/upload/cover
 */
export const uploadCoverImage = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    if (!req.file) {
      throw new BadRequestError('يرجى اختيار صورة للرفع');
    }

    const result = await uploadService.uploadImage(req.file.buffer, {
      folder: 'covers',
    });

    sendSuccess(res, result, 'تم رفع صورة الغلاف بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Upload work photos
 * POST /api/v1/upload/work-photos
 */
export const uploadWorkPhotos = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    const files = req.files as Express.Multer.File[];
    if (!files || files.length === 0) {
      throw new BadRequestError('يرجى اختيار صور للرفع');
    }

    const buffers = files.map((file) => file.buffer);
    const results = await uploadService.uploadImages(buffers, {
      folder: 'work-photos',
    });

    sendSuccess(res, results, 'تم رفع صور الأعمال بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Upload document
 * POST /api/v1/upload/document
 */
export const uploadDocument = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    if (!req.file) {
      throw new BadRequestError('يرجى اختيار مستند للرفع');
    }

    const result = await uploadService.uploadDocument(
      req.file.buffer,
      req.file.mimetype
    );

    sendSuccess(res, result, 'تم رفع المستند بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Upload category image (Admin only)
 * POST /api/v1/upload/category
 */
export const uploadCategoryImage = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    if (!req.file) {
      throw new BadRequestError('يرجى اختيار صورة للرفع');
    }

    const result = await uploadService.uploadImage(req.file.buffer, {
      folder: 'categories',
    });

    sendSuccess(res, result, 'تم رفع صورة الفئة بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Delete an image
 * DELETE /api/v1/upload
 */
export const deleteImage = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    const { url, publicId } = req.body;

    if (!url && !publicId) {
      throw new BadRequestError('يجب توفير رابط الصورة أو معرفها');
    }

    const idToDelete = publicId || uploadService.getPublicIdFromUrl(url);

    if (!idToDelete) {
      throw new BadRequestError('معرف الصورة غير صالح');
    }

    const success = await uploadService.deleteImage(idToDelete);

    if (success) {
      sendSuccess(res, null, 'تم حذف الصورة بنجاح');
    } else {
      throw new BadRequestError('فشل في حذف الصورة');
    }
  } catch (err) {
    next(err);
  }
};

/**
 * Upload image from base64
 * POST /api/v1/upload/base64
 */
export const uploadBase64Image = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    const { image, folder = 'profiles' } = req.body;

    if (!image) {
      throw new BadRequestError('يرجى توفير الصورة');
    }

    const validFolders: ImageFolder[] = [
      'profiles',
      'covers',
      'work-photos',
      'documents',
      'categories',
      'requests',
    ];

    if (!validFolders.includes(folder as ImageFolder)) {
      throw new BadRequestError('مجلد غير صالح');
    }

    const result = await uploadService.uploadImageBase64(image, {
      folder: folder as ImageFolder,
    });

    sendSuccess(res, result, 'تم رفع الصورة بنجاح');
  } catch (err) {
    next(err);
  }
};
