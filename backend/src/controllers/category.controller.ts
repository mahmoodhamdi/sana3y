import { Request, Response, NextFunction } from 'express';
import categoryService from '@services/category.service';
import { sendSuccess, sendCreated, sendNoContent, sendPaginated } from '@utils/response';
import { BadRequestError } from '@utils/errors';
import {
  createCategorySchema,
  updateCategorySchema,
  addSubcategorySchema,
  updateSubcategorySchema,
  getCategoriesQuerySchema,
} from '@validators/category.validator';

/**
 * Get all categories (Admin - with pagination)
 * GET /api/v1/categories
 */
export const getCategories = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { error, value } = getCategoriesQuerySchema.validate(req.query);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const result = await categoryService.getCategories(value);

    sendPaginated(
      res,
      result.data,
      result.page,
      result.limit,
      result.total,
      'تم جلب الفئات بنجاح'
    );
  } catch (err) {
    next(err);
  }
};

/**
 * Get active categories (Public)
 * GET /api/v1/categories/active
 */
export const getActiveCategories = async (
  _req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const categories = await categoryService.getActiveCategories();
    sendSuccess(res, categories, 'تم جلب الفئات بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Get popular categories (Public)
 * GET /api/v1/categories/popular
 */
export const getPopularCategories = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const limit = req.query.limit ? parseInt(req.query.limit as string, 10) : 6;
    const categories = await categoryService.getPopularCategories(limit);
    sendSuccess(res, categories, 'تم جلب الفئات الشائعة بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Get category by ID
 * GET /api/v1/categories/:id
 */
export const getCategoryById = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { id } = req.params;
    const category = await categoryService.getCategoryById(id);
    sendSuccess(res, category, 'تم جلب الفئة بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Get category by slug
 * GET /api/v1/categories/slug/:slug
 */
export const getCategoryBySlug = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { slug } = req.params;
    const category = await categoryService.getCategoryBySlug(slug);
    sendSuccess(res, category, 'تم جلب الفئة بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Create a new category (Admin only)
 * POST /api/v1/categories
 */
export const createCategory = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { error, value } = createCategorySchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const category = await categoryService.createCategory(value);
    sendCreated(res, category, 'تم إنشاء الفئة بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Update a category (Admin only)
 * PUT /api/v1/categories/:id
 */
export const updateCategory = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { id } = req.params;
    const { error, value } = updateCategorySchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const category = await categoryService.updateCategory(id, value);
    sendSuccess(res, category, 'تم تحديث الفئة بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Delete a category (Admin only)
 * DELETE /api/v1/categories/:id
 */
export const deleteCategory = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { id } = req.params;
    await categoryService.deleteCategory(id);
    sendNoContent(res);
  } catch (err) {
    next(err);
  }
};

/**
 * Add a subcategory (Admin only)
 * POST /api/v1/categories/:id/subcategories
 */
export const addSubcategory = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { id } = req.params;
    const { error, value } = addSubcategorySchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const category = await categoryService.addSubcategory(id, value);
    sendCreated(res, category, 'تم إضافة الفئة الفرعية بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Update a subcategory (Admin only)
 * PUT /api/v1/categories/:id/subcategories/:subcategoryId
 */
export const updateSubcategory = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { id, subcategoryId } = req.params;
    const { error, value } = updateSubcategorySchema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const category = await categoryService.updateSubcategory(id, subcategoryId, value);
    sendSuccess(res, category, 'تم تحديث الفئة الفرعية بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Remove a subcategory (Admin only)
 * DELETE /api/v1/categories/:id/subcategories/:subcategoryId
 */
export const removeSubcategory = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { id, subcategoryId } = req.params;
    const category = await categoryService.removeSubcategory(id, subcategoryId);
    sendSuccess(res, category, 'تم حذف الفئة الفرعية بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Reorder categories (Admin only)
 * PUT /api/v1/categories/reorder
 */
export const reorderCategories = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { orders } = req.body;

    if (!Array.isArray(orders) || orders.length === 0) {
      throw new BadRequestError('يجب توفير قائمة الترتيب');
    }

    for (const order of orders) {
      if (!order.id || typeof order.sortOrder !== 'number') {
        throw new BadRequestError('كل عنصر يجب أن يحتوي على id و sortOrder');
      }
    }

    await categoryService.reorderCategories(orders);
    sendSuccess(res, null, 'تم إعادة ترتيب الفئات بنجاح');
  } catch (err) {
    next(err);
  }
};
