import { Router } from 'express';
import { authenticate, requireAdmin } from '@middleware/auth';
import {
  createReview,
  getReview,
  getCraftsmanReviews,
  getCraftsmanReviewsSummary,
  getMyReviews,
  updateReview,
  respondToReview,
  reportReview,
  toggleReviewVisibility,
} from '@controllers/review.controller';
import {
  validateCreateReview,
  validateUpdateReview,
  validateRespondToReview,
  validateReportReview,
  validateToggleVisibility,
  validateGetReviewsQuery,
} from '@validators/review.validator';

const router = Router();

/**
 * @route   GET /api/v1/reviews/craftsman/:id
 * @desc    Get craftsman reviews
 * @access  Public
 */
router.get('/craftsman/:id', validateGetReviewsQuery, getCraftsmanReviews);

/**
 * @route   GET /api/v1/reviews/craftsman/:id/summary
 * @desc    Get craftsman reviews summary
 * @access  Public
 */
router.get('/craftsman/:id/summary', getCraftsmanReviewsSummary);

/**
 * @route   GET /api/v1/reviews/:id
 * @desc    Get single review
 * @access  Public
 */
router.get('/:id', getReview);

// Protected routes - require authentication
router.use(authenticate);

/**
 * @route   POST /api/v1/reviews
 * @desc    Create a review
 * @access  Private (Customer)
 */
router.post('/', validateCreateReview, createReview);

/**
 * @route   GET /api/v1/reviews/my
 * @desc    Get my reviews (customer)
 * @access  Private
 */
router.get('/my', getMyReviews);

/**
 * @route   PUT /api/v1/reviews/:id
 * @desc    Update review
 * @access  Private (Review owner)
 */
router.put('/:id', validateUpdateReview, updateReview);

/**
 * @route   POST /api/v1/reviews/:id/respond
 * @desc    Respond to review (craftsman)
 * @access  Private (Craftsman)
 */
router.post('/:id/respond', validateRespondToReview, respondToReview);

/**
 * @route   POST /api/v1/reviews/:id/report
 * @desc    Report a review
 * @access  Private
 */
router.post('/:id/report', validateReportReview, reportReview);

/**
 * @route   PUT /api/v1/admin/reviews/:id/visibility
 * @desc    Toggle review visibility
 * @access  Private (Admin)
 */
router.put(
  '/admin/:id/visibility',
  requireAdmin,
  validateToggleVisibility,
  toggleReviewVisibility
);

export default router;
