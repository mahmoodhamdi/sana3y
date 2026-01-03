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
import { authenticate, requireCustomer, requireCraftsman, requireAdmin } from '../middleware/auth';
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
  requireCustomer,
  validateCreateRequest,
  createRequest
);

router.get('/my', authenticate, validateGetRequestsQuery, getMyRequests);

router.put(
  '/:id',
  authenticate,
  requireCustomer,
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
  requireCustomer,
  acceptQuote
);

router.post(
  '/:id/quotes/:quoteId/reject',
  authenticate,
  requireCustomer,
  rejectQuote
);

// Craftsman routes
router.get(
  '/available',
  authenticate,
  requireCraftsman,
  validateGetRequestsQuery,
  getAvailableRequests
);

router.get(
  '/my-jobs/active',
  authenticate,
  requireCraftsman,
  validateGetRequestsQuery,
  getMyActiveJobs
);

router.get(
  '/my-jobs/completed',
  authenticate,
  requireCraftsman,
  validateGetRequestsQuery,
  getMyCompletedJobs
);

router.post(
  '/:id/quotes',
  authenticate,
  requireCraftsman,
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
  requireAdmin,
  validateGetRequestsQuery,
  getAllRequests
);

router.get(
  '/stats',
  authenticate,
  requireAdmin,
  getRequestStats
);

router.delete(
  '/:id',
  authenticate,
  requireAdmin,
  deleteRequest
);

export default router;
