import { Request, Response, NextFunction } from 'express';
import { verifyAccessToken, extractTokenFromHeader, DecodedToken } from '@utils/jwt';
import { UnauthorizedError, ForbiddenError } from '@utils/errors';
import User from '@models/User';

// Extend Express Request to include user
declare global {
  // eslint-disable-next-line @typescript-eslint/no-namespace
  namespace Express {
    interface Request {
      user?: DecodedToken;
    }
  }
}

/**
 * Authenticate user via JWT token
 */
export const authenticate = async (
  req: Request,
  _res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const token = extractTokenFromHeader(req.headers.authorization);

    if (!token) {
      throw new UnauthorizedError('الرجاء تسجيل الدخول');
    }

    const decoded = verifyAccessToken(token);

    // Optionally verify user still exists and is active
    const user = await User.findById(decoded.userId).select('isActive');
    if (!user) {
      throw new UnauthorizedError('المستخدم غير موجود');
    }

    if (!user.isActive) {
      throw new UnauthorizedError('حسابك موقوف. تواصل مع الدعم');
    }

    req.user = decoded;
    next();
  } catch (error) {
    if (error instanceof UnauthorizedError || error instanceof ForbiddenError) {
      next(error);
    } else {
      next(new UnauthorizedError('جلسة غير صالحة'));
    }
  }
};

/**
 * Optional authentication - doesn't fail if no token
 */
export const optionalAuth = async (
  req: Request,
  _res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const token = extractTokenFromHeader(req.headers.authorization);

    if (token) {
      const decoded = verifyAccessToken(token);
      req.user = decoded;
    }

    next();
  } catch {
    // Token invalid or expired, continue without user
    next();
  }
};

/**
 * Require specific roles
 */
export const requireRole = (...roles: Array<'customer' | 'craftsman' | 'admin'>) => {
  return (req: Request, _res: Response, next: NextFunction): void => {
    if (!req.user) {
      return next(new UnauthorizedError('الرجاء تسجيل الدخول'));
    }

    if (!roles.includes(req.user.role)) {
      return next(new ForbiddenError('غير مصرح لك بالوصول'));
    }

    next();
  };
};

/**
 * Require admin role
 */
export const requireAdmin = requireRole('admin');

/**
 * Require craftsman role
 */
export const requireCraftsman = requireRole('craftsman');

/**
 * Require customer role
 */
export const requireCustomer = requireRole('customer');

/**
 * Require craftsman or admin role
 */
export const requireCraftsmanOrAdmin = requireRole('craftsman', 'admin');
