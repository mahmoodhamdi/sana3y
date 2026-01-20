import { Request, Response, NextFunction } from 'express';

/**
 * Sanitize object recursively to prevent NoSQL injection
 * Removes keys starting with $ or containing .
 */
const sanitizeObject = (obj: any): any => {
  if (obj === null || obj === undefined) {
    return obj;
  }

  if (Array.isArray(obj)) {
    return obj.map(sanitizeObject);
  }

  if (typeof obj === 'object') {
    const sanitized: any = {};
    for (const key of Object.keys(obj)) {
      // Skip keys that could be MongoDB operators
      if (key.startsWith('$') || key.includes('.')) {
        continue;
      }
      sanitized[key] = sanitizeObject(obj[key]);
    }
    return sanitized;
  }

  // Sanitize strings to prevent XSS
  if (typeof obj === 'string') {
    return obj
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#x27;')
      .replace(/\//g, '&#x2F;');
  }

  return obj;
};

/**
 * Middleware to sanitize request body, query, and params
 */
export const sanitizeInput = (req: Request, _res: Response, next: NextFunction): void => {
  if (req.body) {
    req.body = sanitizeObject(req.body);
  }
  if (req.query) {
    req.query = sanitizeObject(req.query);
  }
  if (req.params) {
    req.params = sanitizeObject(req.params);
  }
  next();
};

/**
 * NoSQL injection prevention middleware
 * Checks for MongoDB operators in request
 */
export const preventNoSQLInjection = (req: Request, res: Response, next: NextFunction): void => {
  const checkForInjection = (obj: any, path: string = ''): boolean => {
    if (obj === null || obj === undefined) {
      return false;
    }

    if (Array.isArray(obj)) {
      return obj.some((item, index) => checkForInjection(item, `${path}[${index}]`));
    }

    if (typeof obj === 'object') {
      for (const key of Object.keys(obj)) {
        if (key.startsWith('$')) {
          return true;
        }
        if (checkForInjection(obj[key], `${path}.${key}`)) {
          return true;
        }
      }
    }

    return false;
  };

  if (checkForInjection(req.body) || checkForInjection(req.query)) {
    res.status(400).json({
      success: false,
      message: 'Invalid request data',
    });
    return;
  }

  next();
};

/**
 * Security headers middleware (additional to helmet)
 */
export const securityHeaders = (_req: Request, res: Response, next: NextFunction): void => {
  // Additional security headers
  res.setHeader('X-Content-Type-Options', 'nosniff');
  res.setHeader('X-Frame-Options', 'DENY');
  res.setHeader('X-XSS-Protection', '1; mode=block');
  res.setHeader('Strict-Transport-Security', 'max-age=31536000; includeSubDomains');
  res.setHeader('Cache-Control', 'no-store, no-cache, must-revalidate, proxy-revalidate');
  res.setHeader('Pragma', 'no-cache');
  res.setHeader('Expires', '0');

  // Remove potentially sensitive headers
  res.removeHeader('X-Powered-By');

  next();
};

/**
 * Request size limiter for specific routes
 */
export const requestSizeLimiter = (maxSize: number) => {
  return (req: Request, res: Response, next: NextFunction): void => {
    const contentLength = parseInt(req.headers['content-length'] || '0', 10);

    if (contentLength > maxSize) {
      res.status(413).json({
        success: false,
        message: 'Request entity too large',
      });
      return;
    }

    next();
  };
};

/**
 * Validate content type middleware
 */
export const validateContentType = (allowedTypes: string[]) => {
  return (req: Request, res: Response, next: NextFunction): void => {
    // Skip for GET, HEAD, OPTIONS requests
    if (['GET', 'HEAD', 'OPTIONS'].includes(req.method)) {
      next();
      return;
    }

    const contentType = req.headers['content-type'];

    if (!contentType || !allowedTypes.some(type => contentType.includes(type))) {
      res.status(415).json({
        success: false,
        message: 'Unsupported Media Type',
      });
      return;
    }

    next();
  };
};
