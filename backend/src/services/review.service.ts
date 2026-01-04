import { Types } from 'mongoose';
import Review, { IReview } from '@models/Review';
import ServiceRequest from '@models/ServiceRequest';
import Craftsman from '@models/Craftsman';
import Customer from '@models/Customer';
import { NotFoundError, BadRequestError, ForbiddenError } from '@utils/errors';

interface CreateReviewParams {
  requestId: string;
  customerId: string;
  score: number;
  comment?: string;
  qualities?: {
    punctuality?: number;
    professionalism?: number;
    quality?: number;
    cleanliness?: number;
    communication?: number;
  };
  images?: string[];
}

interface GetReviewsParams {
  craftsmanId?: string;
  customerId?: string;
  minScore?: number;
  maxScore?: number;
  page?: number;
  limit?: number;
  sortBy?: 'createdAt' | 'score';
  sortOrder?: 'asc' | 'desc';
}

class ReviewService {
  /**
   * Create a review for a completed request
   */
  async createReview(params: CreateReviewParams): Promise<IReview> {
    const { requestId, customerId, score, comment, qualities, images } = params;

    // Validate request exists and is completed
    const request = await ServiceRequest.findById(requestId);
    if (!request) {
      throw new NotFoundError('الطلب غير موجود');
    }

    if (request.status !== 'completed') {
      throw new BadRequestError('لا يمكن تقييم طلب غير مكتمل');
    }

    // Validate customer owns the request
    const customer = await Customer.findById(customerId);
    if (!customer || request.customerId.toString() !== customerId) {
      throw new ForbiddenError('ليس لديك صلاحية لتقييم هذا الطلب');
    }

    // Check if already reviewed
    const existingReview = await Review.findOne({
      requestId: new Types.ObjectId(requestId),
    });
    if (existingReview) {
      throw new BadRequestError('تم تقييم هذا الطلب مسبقاً');
    }

    // Get craftsman ID
    if (!request.craftsmanId) {
      throw new BadRequestError('لا يوجد صنايعي مخصص لهذا الطلب');
    }

    const craftsmanId = request.craftsmanId;

    // Create review
    const review = await Review.create({
      requestId: new Types.ObjectId(requestId),
      customerId: new Types.ObjectId(customerId),
      craftsmanId: new Types.ObjectId(craftsmanId),
      score,
      comment,
      qualities: qualities || {},
      images: images || [],
    });

    // Update craftsman's rating
    await this.updateCraftsmanRating(craftsmanId.toString());

    // Populate and return
    return this.getReviewById(review._id.toString());
  }

  /**
   * Get review by ID
   */
  async getReviewById(reviewId: string): Promise<IReview> {
    const review = await Review.findById(reviewId)
      .populate({
        path: 'customerId',
        select: 'userId',
        populate: {
          path: 'userId',
          select: 'name avatar',
        },
      })
      .populate({
        path: 'requestId',
        select: 'requestNumber title categoryId',
        populate: {
          path: 'categoryId',
          select: 'nameAr',
        },
      });

    if (!review) {
      throw new NotFoundError('التقييم غير موجود');
    }

    return review;
  }

  /**
   * Get reviews with filters
   */
  async getReviews(params: GetReviewsParams) {
    const {
      craftsmanId,
      customerId,
      minScore,
      maxScore,
      page = 1,
      limit = 20,
      sortBy = 'createdAt',
      sortOrder = 'desc',
    } = params;

    const query: Record<string, unknown> = {
      isVisible: true,
    };

    if (craftsmanId) {
      query.craftsmanId = new Types.ObjectId(craftsmanId);
    }

    if (customerId) {
      query.customerId = new Types.ObjectId(customerId);
    }

    if (minScore !== undefined || maxScore !== undefined) {
      query.score = {};
      if (minScore !== undefined) {
        (query.score as Record<string, number>).$gte = minScore;
      }
      if (maxScore !== undefined) {
        (query.score as Record<string, number>).$lte = maxScore;
      }
    }

    const skip = (page - 1) * limit;
    const sort: Record<string, 1 | -1> = {
      [sortBy]: sortOrder === 'asc' ? 1 : -1,
    };

    const [reviews, total] = await Promise.all([
      Review.find(query)
        .sort(sort)
        .skip(skip)
        .limit(limit)
        .populate({
          path: 'customerId',
          select: 'userId',
          populate: {
            path: 'userId',
            select: 'name avatar',
          },
        })
        .populate({
          path: 'requestId',
          select: 'requestNumber title categoryId',
          populate: {
            path: 'categoryId',
            select: 'nameAr',
          },
        }),
      Review.countDocuments(query),
    ]);

    return {
      data: reviews,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  /**
   * Get craftsman reviews summary
   */
  async getCraftsmanReviewsSummary(craftsmanId: string) {
    const reviews = await Review.find({
      craftsmanId: new Types.ObjectId(craftsmanId),
      isVisible: true,
    });

    if (reviews.length === 0) {
      return {
        averageRating: 0,
        totalReviews: 0,
        ratingDistribution: { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0 },
        qualityAverages: {
          punctuality: 0,
          professionalism: 0,
          quality: 0,
          cleanliness: 0,
          communication: 0,
        },
      };
    }

    // Calculate average rating
    const totalScore = reviews.reduce((sum, r) => sum + r.score, 0);
    const averageRating = totalScore / reviews.length;

    // Calculate rating distribution
    const ratingDistribution = { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0 };
    reviews.forEach((r) => {
      ratingDistribution[r.score as keyof typeof ratingDistribution]++;
    });

    // Calculate quality averages
    const qualitySums = {
      punctuality: 0,
      professionalism: 0,
      quality: 0,
      cleanliness: 0,
      communication: 0,
    };
    const qualityCounts = { ...qualitySums };

    reviews.forEach((r) => {
      if (r.qualities) {
        Object.keys(qualitySums).forEach((key) => {
          const k = key as keyof typeof qualitySums;
          const qualityValue = r.qualities[k];
          if (qualityValue !== undefined && qualityValue !== null) {
            qualitySums[k] += qualityValue;
            qualityCounts[k]++;
          }
        });
      }
    });

    const qualityAverages = Object.keys(qualitySums).reduce(
      (acc, key) => {
        const k = key as keyof typeof qualitySums;
        acc[k] = qualityCounts[k] > 0 ? qualitySums[k] / qualityCounts[k] : 0;
        return acc;
      },
      {} as Record<string, number>
    );

    return {
      averageRating: Math.round(averageRating * 10) / 10,
      totalReviews: reviews.length,
      ratingDistribution,
      qualityAverages,
    };
  }

  /**
   * Update review (only comment/images within time limit)
   */
  async updateReview(
    reviewId: string,
    customerId: string,
    updates: { comment?: string; images?: string[] }
  ): Promise<IReview> {
    const review = await Review.findOne({
      _id: new Types.ObjectId(reviewId),
      customerId: new Types.ObjectId(customerId),
    });

    if (!review) {
      throw new NotFoundError('التقييم غير موجود أو ليس لديك صلاحية التعديل');
    }

    // Check if within 24 hours
    const hoursSinceCreation =
      (Date.now() - review.createdAt.getTime()) / (1000 * 60 * 60);
    if (hoursSinceCreation > 24) {
      throw new BadRequestError('لا يمكن تعديل التقييم بعد 24 ساعة');
    }

    if (updates.comment !== undefined) {
      review.comment = updates.comment;
    }

    if (updates.images !== undefined) {
      review.images = updates.images;
    }

    await review.save();

    return this.getReviewById(reviewId);
  }

  /**
   * Craftsman response to a review
   */
  async respondToReview(
    reviewId: string,
    craftsmanId: string,
    response: string
  ): Promise<IReview> {
    const review = await Review.findOne({
      _id: new Types.ObjectId(reviewId),
      craftsmanId: new Types.ObjectId(craftsmanId),
    });

    if (!review) {
      throw new NotFoundError('التقييم غير موجود أو ليس لديك صلاحية الرد');
    }

    if (review.craftsmanResponse) {
      throw new BadRequestError('تم الرد على هذا التقييم مسبقاً');
    }

    review.craftsmanResponse = response;
    review.respondedAt = new Date();
    await review.save();

    return this.getReviewById(reviewId);
  }

  /**
   * Report a review
   */
  async reportReview(
    reviewId: string,
    _reporterId: string,
    reason: string
  ): Promise<void> {
    const review = await Review.findById(reviewId);

    if (!review) {
      throw new NotFoundError('التقييم غير موجود');
    }

    review.isReported = true;
    review.reportReason = reason;
    await review.save();

    // TODO: Notify admin for review
  }

  /**
   * Update craftsman's overall rating
   */
  private async updateCraftsmanRating(craftsmanId: string): Promise<void> {
    const result = await Review.aggregate([
      {
        $match: {
          craftsmanId: new Types.ObjectId(craftsmanId),
          isVisible: true,
        },
      },
      {
        $group: {
          _id: null,
          averageRating: { $avg: '$score' },
          totalRatings: { $sum: 1 },
        },
      },
    ]);

    if (result.length > 0) {
      await Craftsman.findByIdAndUpdate(craftsmanId, {
        rating: Math.round(result[0].averageRating * 10) / 10,
        totalRatings: result[0].totalRatings,
      });
    }
  }

  /**
   * Admin: Hide/Show review
   */
  async toggleReviewVisibility(
    reviewId: string,
    isVisible: boolean
  ): Promise<IReview> {
    const review = await Review.findByIdAndUpdate(
      reviewId,
      { isVisible },
      { new: true }
    );

    if (!review) {
      throw new NotFoundError('التقييم غير موجود');
    }

    // Update craftsman rating
    await this.updateCraftsmanRating(review.craftsmanId.toString());

    return this.getReviewById(reviewId);
  }
}

export const reviewService = new ReviewService();
