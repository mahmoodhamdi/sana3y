import { Request, Response } from 'express';
import { StatusCodes } from 'http-status-codes';
import { sendError } from '../utils/response';

export const notFoundHandler = (_req: Request, res: Response): Response => {
  return sendError(res, 'Route not found', StatusCodes.NOT_FOUND);
};
