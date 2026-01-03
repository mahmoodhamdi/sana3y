import { Types } from 'mongoose';
import ServiceCategory, { IServiceCategory } from '@models/ServiceCategory';
import { NotFoundError, ConflictError, BadRequestError } from '@utils/errors';

interface CreateCategoryInput {
  name: string;
  nameAr: string;
  slug?: string;
  icon?: string;
  image?: string;
  description?: string;
  descriptionAr?: string;
  subcategories?: Array<{
    name: string;
    nameAr: string;
    suggestedPrice?: { min: number; max: number };
  }>;
  sortOrder?: number;
  isActive?: boolean;
  isPopular?: boolean;
}

interface UpdateCategoryInput {
  name?: string;
  nameAr?: string;
  slug?: string;
  icon?: string;
  image?: string;
  description?: string;
  descriptionAr?: string;
  sortOrder?: number;
  isActive?: boolean;
  isPopular?: boolean;
}

interface SubcategoryInput {
  name: string;
  nameAr: string;
  suggestedPrice?: { min: number; max: number };
}

interface GetCategoriesQuery {
  page?: number;
  limit?: number;
  sort?: string;
  order?: 'asc' | 'desc';
  isActive?: boolean;
  isPopular?: boolean;
  search?: string;
}

interface PaginatedResult<T> {
  data: T[];
  page: number;
  limit: number;
  total: number;
  totalPages: number;
}

class CategoryService {
  /**
   * Get all categories with pagination and filters
   */
  async getCategories(query: GetCategoriesQuery): Promise<PaginatedResult<IServiceCategory>> {
    const {
      page = 1,
      limit = 20,
      sort = 'sortOrder',
      order = 'asc',
      isActive,
      isPopular,
      search,
    } = query;

    const filter: Record<string, unknown> = {};

    if (typeof isActive === 'boolean') {
      filter.isActive = isActive;
    }

    if (typeof isPopular === 'boolean') {
      filter.isPopular = isPopular;
    }

    if (search) {
      filter.$or = [
        { name: { $regex: search, $options: 'i' } },
        { nameAr: { $regex: search, $options: 'i' } },
      ];
    }

    const skip = (page - 1) * limit;
    const sortOrder = order === 'desc' ? -1 : 1;

    const [categories, total] = await Promise.all([
      ServiceCategory.find(filter)
        .sort({ [sort]: sortOrder })
        .skip(skip)
        .limit(limit)
        .lean(),
      ServiceCategory.countDocuments(filter),
    ]);

    return {
      data: categories as IServiceCategory[],
      page,
      limit,
      total,
      totalPages: Math.ceil(total / limit),
    };
  }

  /**
   * Get active categories for public listing
   */
  async getActiveCategories(): Promise<IServiceCategory[]> {
    return ServiceCategory.find({ isActive: true })
      .sort({ sortOrder: 1, nameAr: 1 })
      .lean() as Promise<IServiceCategory[]>;
  }

  /**
   * Get popular categories
   */
  async getPopularCategories(limit = 6): Promise<IServiceCategory[]> {
    return ServiceCategory.find({ isActive: true, isPopular: true })
      .sort({ sortOrder: 1 })
      .limit(limit)
      .lean() as Promise<IServiceCategory[]>;
  }

  /**
   * Get a single category by ID
   */
  async getCategoryById(id: string): Promise<IServiceCategory> {
    if (!Types.ObjectId.isValid(id)) {
      throw new BadRequestError('معرف الفئة غير صالح');
    }

    const category = await ServiceCategory.findById(id).lean();

    if (!category) {
      throw new NotFoundError('الفئة غير موجودة');
    }

    return category as IServiceCategory;
  }

  /**
   * Get a category by slug
   */
  async getCategoryBySlug(slug: string): Promise<IServiceCategory> {
    const category = await ServiceCategory.findOne({ slug }).lean();

    if (!category) {
      throw new NotFoundError('الفئة غير موجودة');
    }

    return category as IServiceCategory;
  }

  /**
   * Create a new category (Admin only)
   */
  async createCategory(input: CreateCategoryInput): Promise<IServiceCategory> {
    // Check if category with same name exists
    const existingCategory = await ServiceCategory.findOne({
      $or: [{ name: input.name }, { nameAr: input.nameAr }],
    });

    if (existingCategory) {
      throw new ConflictError('فئة بهذا الاسم موجودة بالفعل');
    }

    // Generate slug if not provided
    if (!input.slug) {
      input.slug = input.name
        .toLowerCase()
        .replace(/[^a-z0-9]+/g, '-')
        .replace(/(^-|-$)/g, '');
    }

    // Check if slug is unique
    const slugExists = await ServiceCategory.findOne({ slug: input.slug });
    if (slugExists) {
      throw new ConflictError('هذا الرابط مستخدم بالفعل');
    }

    const category = await ServiceCategory.create(input);
    return category.toObject() as IServiceCategory;
  }

  /**
   * Update a category (Admin only)
   */
  async updateCategory(id: string, input: UpdateCategoryInput): Promise<IServiceCategory> {
    if (!Types.ObjectId.isValid(id)) {
      throw new BadRequestError('معرف الفئة غير صالح');
    }

    // Check if category exists
    const category = await ServiceCategory.findById(id);
    if (!category) {
      throw new NotFoundError('الفئة غير موجودة');
    }

    // Check for name conflicts
    if (input.name || input.nameAr) {
      const existingCategory = await ServiceCategory.findOne({
        _id: { $ne: id },
        $or: [
          ...(input.name ? [{ name: input.name }] : []),
          ...(input.nameAr ? [{ nameAr: input.nameAr }] : []),
        ],
      });

      if (existingCategory) {
        throw new ConflictError('فئة بهذا الاسم موجودة بالفعل');
      }
    }

    // Check for slug conflicts
    if (input.slug) {
      const slugExists = await ServiceCategory.findOne({
        _id: { $ne: id },
        slug: input.slug,
      });

      if (slugExists) {
        throw new ConflictError('هذا الرابط مستخدم بالفعل');
      }
    }

    Object.assign(category, input);
    await category.save();

    return category.toObject() as IServiceCategory;
  }

  /**
   * Delete a category (Admin only)
   */
  async deleteCategory(id: string): Promise<void> {
    if (!Types.ObjectId.isValid(id)) {
      throw new BadRequestError('معرف الفئة غير صالح');
    }

    const category = await ServiceCategory.findById(id);
    if (!category) {
      throw new NotFoundError('الفئة غير موجودة');
    }

    // Check if there are craftsmen using this category
    if (category.totalCraftsmen > 0) {
      throw new BadRequestError('لا يمكن حذف هذه الفئة لأنها تحتوي على صنايعية');
    }

    await ServiceCategory.findByIdAndDelete(id);
  }

  /**
   * Add a subcategory to a category (Admin only)
   */
  async addSubcategory(categoryId: string, input: SubcategoryInput): Promise<IServiceCategory> {
    if (!Types.ObjectId.isValid(categoryId)) {
      throw new BadRequestError('معرف الفئة غير صالح');
    }

    const category = await ServiceCategory.findById(categoryId);
    if (!category) {
      throw new NotFoundError('الفئة غير موجودة');
    }

    // Check if subcategory with same name exists
    const exists = category.subcategories.some(
      (sub) => sub.name === input.name || sub.nameAr === input.nameAr
    );

    if (exists) {
      throw new ConflictError('فئة فرعية بهذا الاسم موجودة بالفعل');
    }

    category.subcategories.push(input as any);
    await category.save();

    return category.toObject() as IServiceCategory;
  }

  /**
   * Update a subcategory (Admin only)
   */
  async updateSubcategory(
    categoryId: string,
    subcategoryId: string,
    input: Partial<SubcategoryInput>
  ): Promise<IServiceCategory> {
    if (!Types.ObjectId.isValid(categoryId) || !Types.ObjectId.isValid(subcategoryId)) {
      throw new BadRequestError('معرف غير صالح');
    }

    const category = await ServiceCategory.findById(categoryId);
    if (!category) {
      throw new NotFoundError('الفئة غير موجودة');
    }

    const subcategoryIndex = category.subcategories.findIndex(
      (sub) => sub._id.toString() === subcategoryId
    );

    if (subcategoryIndex === -1) {
      throw new NotFoundError('الفئة الفرعية غير موجودة');
    }

    // Check for name conflicts with other subcategories
    if (input.name || input.nameAr) {
      const exists = category.subcategories.some(
        (sub, index) =>
          index !== subcategoryIndex &&
          (sub.name === input.name || sub.nameAr === input.nameAr)
      );

      if (exists) {
        throw new ConflictError('فئة فرعية بهذا الاسم موجودة بالفعل');
      }
    }

    Object.assign(category.subcategories[subcategoryIndex], input);
    await category.save();

    return category.toObject() as IServiceCategory;
  }

  /**
   * Remove a subcategory (Admin only)
   */
  async removeSubcategory(categoryId: string, subcategoryId: string): Promise<IServiceCategory> {
    if (!Types.ObjectId.isValid(categoryId) || !Types.ObjectId.isValid(subcategoryId)) {
      throw new BadRequestError('معرف غير صالح');
    }

    const category = await ServiceCategory.findById(categoryId);
    if (!category) {
      throw new NotFoundError('الفئة غير موجودة');
    }

    const subcategoryIndex = category.subcategories.findIndex(
      (sub) => sub._id.toString() === subcategoryId
    );

    if (subcategoryIndex === -1) {
      throw new NotFoundError('الفئة الفرعية غير موجودة');
    }

    category.subcategories.splice(subcategoryIndex, 1);
    await category.save();

    return category.toObject() as IServiceCategory;
  }

  /**
   * Reorder categories (Admin only)
   */
  async reorderCategories(
    categoryOrders: Array<{ id: string; sortOrder: number }>
  ): Promise<void> {
    const bulkOps = categoryOrders.map(({ id, sortOrder }) => ({
      updateOne: {
        filter: { _id: new Types.ObjectId(id) },
        update: { $set: { sortOrder } },
      },
    }));

    await ServiceCategory.bulkWrite(bulkOps);
  }

  /**
   * Increment craftsmen count for a category
   */
  async incrementCraftsmenCount(categoryId: string): Promise<void> {
    await ServiceCategory.findByIdAndUpdate(categoryId, {
      $inc: { totalCraftsmen: 1 },
    });
  }

  /**
   * Decrement craftsmen count for a category
   */
  async decrementCraftsmenCount(categoryId: string): Promise<void> {
    await ServiceCategory.findByIdAndUpdate(categoryId, {
      $inc: { totalCraftsmen: -1 },
    });
  }

  /**
   * Increment jobs count for a category
   */
  async incrementJobsCount(categoryId: string): Promise<void> {
    await ServiceCategory.findByIdAndUpdate(categoryId, {
      $inc: { totalJobs: 1 },
    });
  }
}

export default new CategoryService();
