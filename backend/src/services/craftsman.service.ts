import { Types, PipelineStage } from 'mongoose';
import Craftsman from '@models/Craftsman';
import User from '@models/User';
import { ICraftsman, ICraftsmanService, IWorkingHour, ICraftsmanDocuments } from '../types';
import { NotFoundError, BadRequestError, ConflictError } from '@utils/errors';
import categoryService from './category.service';

interface CreateCraftsmanInput {
  displayName: string;
  bio?: string;
  whatsapp?: string;
  alternatePhone?: string;
  services: ICraftsmanService[];
  address?: string;
  location?: {
    type: 'Point';
    coordinates: [number, number];
  };
  serviceRadius?: number;
  serviceZones?: string[];
  workingHours?: IWorkingHour[];
  documents?: ICraftsmanDocuments;
}

interface UpdateCraftsmanInput {
  displayName?: string;
  bio?: string;
  profileImage?: string;
  coverImage?: string;
  workPhotos?: string[];
  whatsapp?: string;
  alternatePhone?: string;
  services?: ICraftsmanService[];
  address?: string;
  location?: {
    type: 'Point';
    coordinates: [number, number];
  };
  serviceRadius?: number;
  serviceZones?: string[];
  workingHours?: IWorkingHour[];
  isAvailable?: boolean;
  documents?: ICraftsmanDocuments;
}

interface UpdateStatusInput {
  status: 'approved' | 'rejected' | 'suspended';
  rejectionReason?: string;
  suspensionReason?: string;
}

interface GetCraftsmenQuery {
  page?: number;
  limit?: number;
  sort?: string;
  order?: 'asc' | 'desc';
  categoryId?: string;
  subcategory?: string;
  status?: string;
  isOnline?: boolean;
  isAvailable?: boolean;
  isFeatured?: boolean;
  minRating?: number;
  search?: string;
  lat?: number;
  lng?: number;
  radius?: number;
  zoneId?: string;
}

interface PaginatedResult<T> {
  data: T[];
  page: number;
  limit: number;
  total: number;
  totalPages: number;
}

class CraftsmanService {
  /**
   * Get craftsmen with filters and pagination
   */
  async getCraftsmen(query: GetCraftsmenQuery): Promise<PaginatedResult<ICraftsman>> {
    const {
      page = 1,
      limit = 20,
      sort = 'rating',
      order = 'desc',
      categoryId,
      subcategory,
      status,
      isOnline,
      isAvailable,
      isFeatured,
      minRating,
      search,
      lat,
      lng,
      radius,
      zoneId,
    } = query;

    const filter: Record<string, unknown> = {};

    // Status filter
    if (status) {
      filter.status = status;
    }

    // Online filter
    if (typeof isOnline === 'boolean') {
      filter.isOnline = isOnline;
    }

    // Availability filter
    if (typeof isAvailable === 'boolean') {
      filter.isAvailable = isAvailable;
    }

    // Featured filter
    if (typeof isFeatured === 'boolean') {
      filter.isFeatured = isFeatured;
      if (isFeatured) {
        filter.featuredUntil = { $gte: new Date() };
      }
    }

    // Category filter
    if (categoryId) {
      filter['services.categoryId'] = new Types.ObjectId(categoryId);
    }

    // Subcategory filter
    if (subcategory) {
      filter['services.subcategories'] = subcategory;
    }

    // Minimum rating filter
    if (minRating) {
      filter.rating = { $gte: minRating };
    }

    // Search filter
    if (search) {
      filter.$or = [
        { displayName: { $regex: search, $options: 'i' } },
        { bio: { $regex: search, $options: 'i' } },
      ];
    }

    // Zone filter
    if (zoneId) {
      filter.serviceZones = new Types.ObjectId(zoneId);
    }

    const skip = (page - 1) * limit;
    const sortOrder = order === 'desc' ? -1 : 1;

    let aggregatePipeline: PipelineStage[] = [{ $match: filter }];

    // Geo-spatial query if coordinates provided
    if (lat && lng && radius) {
      aggregatePipeline = [
        {
          $geoNear: {
            near: {
              type: 'Point',
              coordinates: [lng, lat],
            },
            distanceField: 'distance',
            maxDistance: radius * 1000, // Convert km to meters
            spherical: true,
            query: filter,
          },
        },
      ];
    }

    // Add sorting
    aggregatePipeline.push({ $sort: { [sort]: sortOrder } });

    // Get total count
    const countPipeline = [...aggregatePipeline, { $count: 'total' }];
    const countResult = await Craftsman.aggregate(countPipeline);
    const total = countResult.length > 0 ? countResult[0].total : 0;

    // Add pagination
    aggregatePipeline.push({ $skip: skip }, { $limit: limit });

    // Populate user details
    aggregatePipeline.push({
      $lookup: {
        from: 'users',
        localField: 'userId',
        foreignField: '_id',
        as: 'user',
      },
    });
    aggregatePipeline.push({
      $unwind: {
        path: '$user',
        preserveNullAndEmptyArrays: true,
      },
    });

    // Populate service categories
    aggregatePipeline.push({
      $lookup: {
        from: 'servicecategories',
        localField: 'services.categoryId',
        foreignField: '_id',
        as: 'categoryDetails',
      },
    });

    const craftsmen = await Craftsman.aggregate(aggregatePipeline);

    return {
      data: craftsmen as ICraftsman[],
      page,
      limit,
      total,
      totalPages: Math.ceil(total / limit),
    };
  }

  /**
   * Get approved craftsmen for public listing
   */
  async getApprovedCraftsmen(query: GetCraftsmenQuery): Promise<PaginatedResult<ICraftsman>> {
    return this.getCraftsmen({ ...query, status: 'approved' });
  }

  /**
   * Get craftsman by ID
   */
  async getCraftsmanById(id: string): Promise<ICraftsman> {
    if (!Types.ObjectId.isValid(id)) {
      throw new BadRequestError('معرف الصنايعي غير صالح');
    }

    const craftsman = await Craftsman.findById(id)
      .populate('userId', 'name phone avatar')
      .populate('services.categoryId', 'name nameAr slug icon')
      .populate('serviceZones', 'name nameAr')
      .lean();

    if (!craftsman) {
      throw new NotFoundError('الصنايعي غير موجود');
    }

    return craftsman as unknown as ICraftsman;
  }

  /**
   * Get craftsman by user ID
   */
  async getCraftsmanByUserId(userId: string): Promise<ICraftsman> {
    if (!Types.ObjectId.isValid(userId)) {
      throw new BadRequestError('معرف المستخدم غير صالح');
    }

    const craftsman = await Craftsman.findOne({ userId })
      .populate('userId', 'name phone avatar')
      .populate('services.categoryId', 'name nameAr slug icon')
      .populate('serviceZones', 'name nameAr')
      .lean();

    if (!craftsman) {
      throw new NotFoundError('لم يتم العثور على ملف الصنايعي');
    }

    return craftsman as unknown as ICraftsman;
  }

  /**
   * Create craftsman profile
   */
  async createCraftsmanProfile(
    userId: string,
    input: CreateCraftsmanInput
  ): Promise<ICraftsman> {
    if (!Types.ObjectId.isValid(userId)) {
      throw new BadRequestError('معرف المستخدم غير صالح');
    }

    // Check if user exists and is a craftsman
    const user = await User.findById(userId);
    if (!user) {
      throw new NotFoundError('المستخدم غير موجود');
    }

    if (user.role !== 'craftsman') {
      throw new BadRequestError('المستخدم ليس صنايعي');
    }

    // Check if profile already exists
    const existingProfile = await Craftsman.findOne({ userId });
    if (existingProfile) {
      throw new ConflictError('الصنايعي لديه ملف مسجل بالفعل');
    }

    // Validate category IDs
    for (const service of input.services) {
      if (!Types.ObjectId.isValid(service.categoryId.toString())) {
        throw new BadRequestError('معرف الفئة غير صالح');
      }
      await categoryService.getCategoryById(service.categoryId.toString());
    }

    // Convert serviceZones strings to ObjectIds
    const serviceZoneIds = input.serviceZones?.map((id) => new Types.ObjectId(id)) || [];

    const craftsman = await Craftsman.create({
      userId,
      ...input,
      serviceZones: serviceZoneIds,
    });

    // Update category craftsmen counts
    for (const service of input.services) {
      await categoryService.incrementCraftsmenCount(service.categoryId.toString());
    }

    return craftsman.toObject() as unknown as ICraftsman;
  }

  /**
   * Update craftsman profile
   */
  async updateCraftsmanProfile(
    userId: string,
    input: UpdateCraftsmanInput
  ): Promise<ICraftsman> {
    const craftsman = await Craftsman.findOne({ userId });
    if (!craftsman) {
      throw new NotFoundError('الصنايعي غير موجود');
    }

    // If services are being updated, validate and update category counts
    if (input.services) {
      // Get old category IDs
      const oldCategoryIds = craftsman.services.map((s) => s.categoryId.toString());

      // Validate new category IDs
      for (const service of input.services) {
        if (!Types.ObjectId.isValid(service.categoryId.toString())) {
          throw new BadRequestError('معرف الفئة غير صالح');
        }
        await categoryService.getCategoryById(service.categoryId.toString());
      }

      // Get new category IDs
      const newCategoryIds = input.services.map((s) => s.categoryId.toString());

      // Decrement counts for removed categories
      for (const catId of oldCategoryIds) {
        if (!newCategoryIds.includes(catId)) {
          await categoryService.decrementCraftsmenCount(catId);
        }
      }

      // Increment counts for new categories
      for (const catId of newCategoryIds) {
        if (!oldCategoryIds.includes(catId)) {
          await categoryService.incrementCraftsmenCount(catId);
        }
      }
    }

    Object.assign(craftsman, input);
    await craftsman.save();

    return craftsman.toObject() as ICraftsman;
  }

  /**
   * Update craftsman status (Admin only)
   */
  async updateCraftsmanStatus(
    craftsmanId: string,
    adminId: string,
    input: UpdateStatusInput
  ): Promise<ICraftsman> {
    if (!Types.ObjectId.isValid(craftsmanId)) {
      throw new BadRequestError('معرف الصنايعي غير صالح');
    }

    const craftsman = await Craftsman.findById(craftsmanId);
    if (!craftsman) {
      throw new NotFoundError('الصنايعي غير موجود');
    }

    craftsman.status = input.status;

    if (input.status === 'approved') {
      craftsman.approvedAt = new Date();
      craftsman.approvedBy = new Types.ObjectId(adminId);
      craftsman.rejectionReason = undefined;
      craftsman.suspensionReason = undefined;
    } else if (input.status === 'rejected') {
      craftsman.rejectionReason = input.rejectionReason;
      craftsman.suspensionReason = undefined;
    } else if (input.status === 'suspended') {
      craftsman.suspensionReason = input.suspensionReason;
    }

    await craftsman.save();

    return craftsman.toObject() as ICraftsman;
  }

  /**
   * Toggle online status
   */
  async toggleOnlineStatus(userId: string, isOnline: boolean): Promise<ICraftsman> {
    const craftsman = await Craftsman.findOne({ userId });
    if (!craftsman) {
      throw new NotFoundError('الصنايعي غير موجود');
    }

    craftsman.isOnline = isOnline;
    await craftsman.save();

    return craftsman.toObject() as ICraftsman;
  }

  /**
   * Toggle availability
   */
  async toggleAvailability(userId: string, isAvailable: boolean): Promise<ICraftsman> {
    const craftsman = await Craftsman.findOne({ userId });
    if (!craftsman) {
      throw new NotFoundError('الصنايعي غير موجود');
    }

    craftsman.isAvailable = isAvailable;
    await craftsman.save();

    return craftsman.toObject() as ICraftsman;
  }

  /**
   * Get craftsmen by category
   */
  async getCraftsmenByCategory(categoryId: string, limit = 10): Promise<ICraftsman[]> {
    const craftsmen = await Craftsman.find({
      'services.categoryId': new Types.ObjectId(categoryId),
      status: 'approved',
      isAvailable: true,
    })
      .sort({ rating: -1, completedJobs: -1 })
      .limit(limit)
      .populate('userId', 'name phone avatar')
      .lean();

    return craftsmen as unknown as ICraftsman[];
  }

  /**
   * Get nearby craftsmen
   */
  async getNearbyCraftsmen(
    lng: number,
    lat: number,
    radiusKm = 10,
    categoryId?: string,
    limit = 20
  ): Promise<ICraftsman[]> {
    const filter: Record<string, unknown> = {
      status: 'approved',
      isAvailable: true,
      location: {
        $geoWithin: {
          $centerSphere: [[lng, lat], radiusKm / 6378.1], // Earth radius in km
        },
      },
    };

    if (categoryId) {
      filter['services.categoryId'] = new Types.ObjectId(categoryId);
    }

    const craftsmen = await Craftsman.find(filter)
      .sort({ rating: -1 })
      .limit(limit)
      .populate('userId', 'name phone avatar')
      .lean();

    return craftsmen as unknown as ICraftsman[];
  }

  /**
   * Get featured craftsmen
   */
  async getFeaturedCraftsmen(limit = 10): Promise<ICraftsman[]> {
    const craftsmen = await Craftsman.find({
      status: 'approved',
      isFeatured: true,
      featuredUntil: { $gte: new Date() },
    })
      .sort({ rating: -1 })
      .limit(limit)
      .populate('userId', 'name phone avatar')
      .populate('services.categoryId', 'name nameAr icon')
      .lean();

    return craftsmen as unknown as ICraftsman[];
  }

  /**
   * Get pending approval craftsmen (Admin)
   */
  async getPendingCraftsmen(page = 1, limit = 20): Promise<PaginatedResult<ICraftsman>> {
    return this.getCraftsmen({ page, limit, status: 'pending', sort: 'createdAt', order: 'asc' });
  }

  /**
   * Add work photos
   */
  async addWorkPhotos(userId: string, photos: string[]): Promise<ICraftsman> {
    const craftsman = await Craftsman.findOne({ userId });
    if (!craftsman) {
      throw new NotFoundError('الصنايعي غير موجود');
    }

    if (craftsman.workPhotos.length + photos.length > 10) {
      throw new BadRequestError('لا يمكن إضافة أكثر من 10 صور للأعمال');
    }

    craftsman.workPhotos.push(...photos);
    await craftsman.save();

    return craftsman.toObject() as ICraftsman;
  }

  /**
   * Remove work photo
   */
  async removeWorkPhoto(userId: string, photoUrl: string): Promise<ICraftsman> {
    const craftsman = await Craftsman.findOne({ userId });
    if (!craftsman) {
      throw new NotFoundError('الصنايعي غير موجود');
    }

    const photoIndex = craftsman.workPhotos.indexOf(photoUrl);
    if (photoIndex === -1) {
      throw new NotFoundError('الصورة غير موجودة');
    }

    craftsman.workPhotos.splice(photoIndex, 1);
    await craftsman.save();

    return craftsman.toObject() as ICraftsman;
  }

  /**
   * Update craftsman statistics
   */
  async updateStats(
    craftsmanId: string,
    updates: Partial<{
      totalJobs: number;
      completedJobs: number;
      cancelledJobs: number;
      totalEarnings: number;
    }>
  ): Promise<void> {
    await Craftsman.findByIdAndUpdate(craftsmanId, { $inc: updates });
  }
}

export default new CraftsmanService();
