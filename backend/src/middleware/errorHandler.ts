import { Request, Response, NextFunction } from 'express';
import { StatusCodes } from 'http-status-codes';
import { AppError, ValidationError } from '../utils/errors';
import { sendError } from '../utils/response';
import { logger } from '../utils/logger';

interface MongoError extends Error {
  code?: number;
  keyValue?: Record<string, unknown>;
}

export const errorHandler = (
  err: Error,
  _req: Request,
  res: Response,
  _next: NextFunction
): Response => {
  logger.error('Error:', err.message);

  if (process.env.NODE_ENV === 'development') {
    logger.error('Stack:', err.stack);
  }

  // Handle known AppError instances
  if (err instanceof AppError) {
    if (err instanceof ValidationError) {
      return sendError(res, err.message, err.statusCode, err.errors);
    }
    return sendError(res, err.message, err.statusCode);
  }

  // Handle MongoDB duplicate key error
  const mongoError = err as MongoError;
  if (mongoError.code === 11000 && mongoError.keyValue) {
    const field = Object.keys(mongoError.keyValue)[0];
    return sendError(
      res,
      `${field} already exists`,
      StatusCodes.CONFLICT
    );
  }

  // Handle MongoDB validation error
  if (err.name === 'ValidationError') {
    return sendError(
      res,
      'Validation Error',
      StatusCodes.BAD_REQUEST
    );
  }

  // Handle MongoDB CastError (invalid ObjectId)
  if (err.name === 'CastError') {
    return sendError(
      res,
      'Invalid ID format',
      StatusCodes.BAD_REQUEST
    );
  }

  // Handle JWT errors
  if (err.name === 'JsonWebTokenError') {
    return sendError(
      res,
      'Invalid token',
      StatusCodes.UNAUTHORIZED
    );
  }

  if (err.name === 'TokenExpiredError') {
    return sendError(
      res,
      'Token expired',
      StatusCodes.UNAUTHORIZED
    );
  }

  // Default to 500 Internal Server Error
  return sendError(
    res,
    process.env.NODE_ENV === 'production'
      ? 'Something went wrong'
      : err.message,
    StatusCodes.INTERNAL_SERVER_ERROR
  );
};
