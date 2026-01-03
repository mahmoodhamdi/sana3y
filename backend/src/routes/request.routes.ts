import { Router } from 'express';
import {
  createRequest,
  getAllRequests,
  getRequestById,
  getMyRequests,
  getAvailableRequests,
  getMyActiveJobs,
  getMyCompletedJobs,
  submitQuote,
  acceptQuote,
  rejectQuote,
  updateRequestStatus,
  updateRequest,
  cancelRequest,
  getRequestStats,
  getStatusTimeline,
  getStatuses,
  deleteRequest,
} from '../controllers/request.controller';
import { authenticate, authorize } from '../middleware/auth';
import {
  validateCreateRequest,
  validateUpdateRequest,
  validateSubmitQuote,
  validateUpdateStatus,
  validateCancelRequest,
  validateGetRequestsQuery,
} from '../validators/request.validator';

const router = Router();

// Public routes
router.get('/statuses', getStatuses);

// Customer routes
router.post(
  '/',
  authenticate,
  authorize('customer'),
  validateCreateRequest,
  createRequest
);

router.get('/my', authenticate, validateGetRequestsQuery, getMyRequests);

router.put(
  '/:id',
  authenticate,
  authorize('customer'),
  validateUpdateRequest,
  updateRequest
);

router.post(
  '/:id/cancel',
  authenticate,
  validateCancelRequest,
  cancelRequest
);

router.post(
  '/:id/quotes/:quoteId/accept',
  authenticate,
  authorize('customer'),
  acceptQuote
);

router.post(
  '/:id/quotes/:quoteId/reject',
  authenticate,
  authorize('customer'),
  rejectQuote
);

// Craftsman routes
router.get(
  '/available',
  authenticate,
  authorize('craftsman'),
  validateGetRequestsQuery,
  getAvailableRequests
);

router.get(
  '/my-jobs/active',
  authenticate,
  authorize('craftsman'),
  validateGetRequestsQuery,
  getMyActiveJobs
);

router.get(
  '/my-jobs/completed',
  authenticate,
  authorize('craftsman'),
  validateGetRequestsQuery,
  getMyCompletedJobs
);

router.post(
  '/:id/quotes',
  authenticate,
  authorize('craftsman'),
  validateSubmitQuote,
  submitQuote
);

// Status updates (customer or craftsman based on permission)
router.put(
  '/:id/status',
  authenticate,
  validateUpdateStatus,
  updateRequestStatus
);

// Get single request (any authenticated user)
router.get('/:id', authenticate, getRequestById);

// Get status timeline
router.get('/:id/timeline', authenticate, getStatusTimeline);

// Admin routes
router.get(
  '/',
  authenticate,
  authorize('admin'),
  validateGetRequestsQuery,
  getAllRequests
);

router.get(
  '/stats',
  authenticate,
  authorize('admin'),
  getRequestStats
);

router.delete(
  '/:id',
  authenticate,
  authorize('admin'),
  deleteRequest
);

export default router;
