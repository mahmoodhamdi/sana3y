import { Request, Response, NextFunction } from 'express';
import AuditLog from '@models/AuditLog';
import { logger } from '@utils/logger';

const REDACT_KEYS = new Set([
  'password',
  'passwordConfirm',
  'newPassword',
  'oldPassword',
  'otp',
  'otpCode',
  'code',
  'token',
  'accessToken',
  'refreshToken',
  'idToken',
  'jwt',
  'authorization',
  'apiKey',
  'secret',
  'firebaseToken',
  'fcmToken',
  'creditCard',
  'cardNumber',
  'cvv',
]);

const redact = (value: unknown, depth = 0): unknown => {
  if (depth > 4) return '[depth-limit]';
  if (value == null) return value;
  if (Array.isArray(value)) return value.map((v) => redact(v, depth + 1));
  if (typeof value === 'object') {
    const out: Record<string, unknown> = {};
    for (const [k, v] of Object.entries(value as Record<string, unknown>)) {
      if (REDACT_KEYS.has(k)) {
        out[k] = '[REDACTED]';
      } else {
        out[k] = redact(v, depth + 1);
      }
    }
    return out;
  }
  return value;
};

const MUTATING_METHODS = new Set(['POST', 'PUT', 'PATCH', 'DELETE']);

/**
 * Records mutating admin actions to the AuditLog collection. Wraps res.json so the final
 * status + (when present) the response document id can be captured. Failures are logged
 * but never block the request.
 */
export const auditLog = (req: Request, res: Response, next: NextFunction): void => {
  if (!MUTATING_METHODS.has(req.method)) return next();

  const originalJson = res.json.bind(res);
  res.json = ((body: unknown) => {
    const result = originalJson(body);
    void (async () => {
      try {
        const actorUserId =
          (req as Request & { user?: { _id?: unknown; userId?: unknown } }).user?._id ??
          (req as Request & { user?: { userId?: unknown } }).user?.userId;
        const actorRole =
          (req as Request & { user?: { role?: string } }).user?.role ?? 'anonymous';
        const targetId =
          (body as { data?: { id?: string; _id?: string } } | undefined)?.data?.id ??
          (body as { data?: { _id?: string } } | undefined)?.data?._id ??
          (req.params && (req.params.id || req.params.userId)) ??
          undefined;
        await AuditLog.create({
          actorUserId: actorUserId ? String(actorUserId) : undefined,
          actorRole,
          action: `${req.method} ${req.baseUrl ?? ''}${req.path}`,
          method: req.method,
          path: `${req.baseUrl ?? ''}${req.path}`,
          targetType: req.baseUrl?.split('/').filter(Boolean).pop(),
          targetId: targetId ? String(targetId) : undefined,
          ip: req.ip,
          userAgent: req.headers['user-agent'],
          payload: redact(req.body) as Record<string, unknown>,
          status: res.statusCode,
        });
      } catch (err) {
        const msg = err instanceof Error ? err.message : 'audit log error';
        logger.warn(`auditLog: failed to record (${msg})`);
      }
    })();
    return result;
  }) as typeof res.json;

  next();
};
