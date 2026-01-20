import { Request, Response, NextFunction, RequestHandler } from 'express';

/**
 * Async handler wrapper to catch errors in async route handlers
 * Eliminates the need for try/catch blocks in every controller
 *
 * Usage:
 * router.get('/route', asyncHandler(async (req, res) => {
 *   const data = await someAsyncOperation();
 *   res.json(data);
 * }));
 */
export const asyncHandler = (
  fn: (req: Request, res: Response, next: NextFunction) => Promise<unknown>
): RequestHandler => {
  return (req: Request, res: Response, next: NextFunction) => {
    Promise.resolve(fn(req, res, next)).catch(next);
  };
};

export default asyncHandler;
