import { Request, Response, NextFunction } from 'express';
import paymentService from '@services/payment.service';
import { sendSuccess } from '@utils/response';
import { BadRequestError, UnauthorizedError, NotFoundError } from '@utils/errors';
import User from '@models/User';

/**
 * Initialize payment for a service request
 * POST /api/v1/payments/initialize
 */
export const initializePayment = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    const { requestId, amount, phone } = req.body;

    if (!requestId || !amount) {
      throw new BadRequestError('يجب توفير رقم الطلب والمبلغ');
    }

    // Get user details
    const user = await User.findById(req.user.userId);
    if (!user) {
      throw new NotFoundError('المستخدم غير موجود');
    }

    // Initialize payment
    const result = await paymentService.initializePayment({
      userId: req.user.userId,
      requestId,
      amount,
      customerName: user.name,
      customerEmail: user.email,
      customerPhone: phone, // Optional phone from request body
    });

    sendSuccess(res, result, 'تم إنشاء طلب الدفع بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Initialize wallet payment (Vodafone Cash, etc.)
 * POST /api/v1/payments/wallet
 */
export const initializeWalletPayment = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    const { requestId, amount, walletPhone } = req.body;

    if (!requestId || !amount || !walletPhone) {
      throw new BadRequestError('يجب توفير رقم الطلب والمبلغ ورقم المحفظة');
    }

    // Get user details
    const user = await User.findById(req.user.userId);
    if (!user) {
      throw new NotFoundError('المستخدم غير موجود');
    }

    // Initialize wallet payment
    const result = await paymentService.initializeWalletPayment(
      {
        userId: req.user.userId,
        requestId,
        amount,
        customerName: user.name,
        customerEmail: user.email,
        customerPhone: walletPhone,
      },
      walletPhone
    );

    sendSuccess(res, result, 'تم إنشاء طلب الدفع بالمحفظة بنجاح');
  } catch (err) {
    next(err);
  }
};

/**
 * Handle Paymob webhook callback
 * POST /api/v1/payments/webhook
 */
export const handleWebhook = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { obj, hmac } = req.body;

    if (!obj || !hmac) {
      throw new BadRequestError('بيانات غير صالحة');
    }

    const result = await paymentService.handlePaymentCallback({ obj, hmac });

    // If payment was successful, update the request status
    if (result.success && result.transactionId) {
      // You can add logic here to update request status, notify craftsman, etc.
    }

    sendSuccess(res, result, 'تم معالجة الإشعار');
  } catch (err) {
    next(err);
  }
};

/**
 * Get payment status
 * GET /api/v1/payments/:transactionId/status
 */
export const getPaymentStatus = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    if (!req.user) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    const { transactionId } = req.params;

    const status = await paymentService.getTransactionStatus(transactionId);
    if (!status) {
      throw new NotFoundError('المعاملة غير موجودة');
    }

    sendSuccess(res, status, 'تم جلب حالة الدفع');
  } catch (err) {
    next(err);
  }
};
