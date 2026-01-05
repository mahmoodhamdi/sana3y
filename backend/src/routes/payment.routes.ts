import { Router } from 'express';
import {
  initializePayment,
  initializeWalletPayment,
  handleWebhook,
  getPaymentStatus,
} from '@controllers/payment.controller';
import { authenticate } from '@middleware/auth';

const router = Router();

// Webhook route (no auth required - called by Paymob)
router.post('/webhook', handleWebhook);

// Protected routes
router.post('/initialize', authenticate, initializePayment);
router.post('/wallet', authenticate, initializeWalletPayment);
router.get('/:transactionId/status', authenticate, getPaymentStatus);

export default router;
