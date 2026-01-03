import { Request, Response, NextFunction } from 'express';
import { reviewService } from '@services/review.service';
import Customer from '@models/Customer';
import Craftsman from '@models/Craftsman';
import { sendSuccess, sendCreated, sendPaginated } from '@utils/response';
import { ForbiddenError } from '@utils/errors';

/**
 * Create a review
 * POST /api/v1/reviews
 */
export const createReview = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = req.user!.userId;
    const { requestId, score, comment, qualities, images } = req.body;

    // Get customer ID
    const customer = await Customer.findOne({ userId });
    if (!customer) {
      throw new ForbiddenError('يجب أن تكون عميلاً لإضافة تقييم');
    }

    const review = await reviewService.createReview({
      requestId,
      customerId: customer._id.toString(),
      score,
      comment,
      qualities,
      images,
    });

    return sendCreated(res, review, 'تم إضافة التقييم بنجاح');
  } catch (error) {
    next(error);
  }
};

/**
 * Get review by ID
 * GET /api/v1/reviews/:id
 */
export const getReview = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const reviewId = req.params.id;
    const review = await reviewService.getReviewById(reviewId);

    return sendSuccess(res, review, 'تم جلب التقييم بنجاح');
  } catch (error) {
    next(error);
  }
};

/**
 * Get craftsman reviews
 * GET /api/v1/reviews/craftsman/:id
 */
export const getCraftsmanReviews = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const craftsmanId = req.params.id;
    const page = parseInt(req.query.page as string) || 1;
    const limit = parseInt(req.query.limit as string) || 20;
    const minScore = req.query.minScore
      ? parseInt(req.query.minScore as string)
      : undefined;
    const sortBy = (req.query.sortBy as 'createdAt' | 'score') || 'createdAt';
    const sortOrder = (req.query.sortOrder as 'asc' | 'desc') || 'desc';

    const result = await reviewService.getReviews({
      craftsmanId,
      minScore,
      page,
      limit,
      sortBy,
      sortOrder,
    });

    return sendPaginated(
      res,
      result.data,
      result.pagination.page,
      result.pagination.limit,
      result.pagination.total,
      'تم جلب التقييمات بنجاح'
    );
  } catch (error) {
    next(error);
  }
};

/**
 * Get craftsman reviews summary
 * GET /api/v1/reviews/craftsman/:id/summary
 */
export const getCraftsmanReviewsSummary = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const craftsmanId = req.params.id;
    const summary = await reviewService.getCraftsmanReviewsSummary(craftsmanId);

    return sendSuccess(res, summary, 'تم جلب ملخص التقييمات بنجاح');
  } catch (error) {
    next(error);
  }
};

/**
 * Get my reviews (customer)
 * GET /api/v1/reviews/my
 */
export const getMyReviews = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = req.user!.userId;
    const customer = await Customer.findOne({ userId });

    if (!customer) {
      return sendPaginated(res, [], 1, 20, 0, 'تم جلب التقييمات بنجاح');
    }

    const page = parseInt(req.query.page as string) || 1;
    const limit = parseInt(req.query.limit as string) || 20;

    const result = await reviewService.getReviews({
      customerId: customer._id.toString(),
      page,
      limit,
    });

    return sendPaginated(
      res,
      result.data,
      result.pagination.page,
      result.pagination.limit,
      result.pagination.total,
      'تم جلب التقييمات بنجاح'
    );
  } catch (error) {
    next(error);
  }
};

/**
 * Update review
 * PUT /api/v1/reviews/:id
 */
export const updateReview = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = req.user!.userId;
    const reviewId = req.params.id;
    const { comment, images } = req.body;

    const customer = await Customer.findOne({ userId });
    if (!customer) {
      throw new ForbiddenError('يجب أن تكون عميلاً لتعديل التقييم');
    }

    const review = await reviewService.updateReview(
      reviewId,
      customer._id.toString(),
      { comment, images }
    );

    return sendSuccess(res, review, 'تم تعديل التقييم بنجاح');
  } catch (error) {
    next(error);
  }
};

/**
 * Respond to review (craftsman)
 * POST /api/v1/reviews/:id/respond
 */
export const respondToReview = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = req.user!.userId;
    const reviewId = req.params.id;
    const { response } = req.body;

    const craftsman = await Craftsman.findOne({ userId });
    if (!craftsman) {
      throw new ForbiddenError('يجب أن تكون صنايعياً للرد على التقييم');
    }

    const review = await reviewService.respondToReview(
      reviewId,
      craftsman._id.toString(),
      response
    );

    return sendSuccess(res, review, 'تم إضافة الرد بنجاح');
  } catch (error) {
    next(error);
  }
};

/**
 * Report a review
 * POST /api/v1/reviews/:id/report
 */
export const reportReview = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = req.user!.userId;
    const reviewId = req.params.id;
    const { reason } = req.body;

    await reviewService.reportReview(reviewId, userId, reason);

    return sendSuccess(res, null, 'تم الإبلاغ عن التقييم');
  } catch (error) {
    next(error);
  }
};

/**
 * Admin: Toggle review visibility
 * PUT /api/v1/admin/reviews/:id/visibility
 */
export const toggleReviewVisibility = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const reviewId = req.params.id;
    const { isVisible } = req.body;

    const review = await reviewService.toggleReviewVisibility(
      reviewId,
      isVisible
    );

    return sendSuccess(res, review, 'تم تحديث حالة التقييم');
  } catch (error) {
    next(error);
  }
};
