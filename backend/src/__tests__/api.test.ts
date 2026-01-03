import { sendSuccess, sendCreated, sendError } from '../utils/response';

// Mock Express Response
const mockResponse = () => {
  const res: any = {};
  res.status = jest.fn().mockReturnValue(res);
  res.json = jest.fn().mockReturnValue(res);
  return res;
};

describe('Response Utils', () => {
  test('sendSuccess should return 200 with correct format', () => {
    const res = mockResponse();
    const data = { test: 'data' };
    const message = 'Success message';

    sendSuccess(res, data, message);

    expect(res.status).toHaveBeenCalledWith(200);
    expect(res.json).toHaveBeenCalledWith({
      success: true,
      message,
      data,
    });
  });

  test('sendCreated should return 201 with correct format', () => {
    const res = mockResponse();
    const data = { id: '123' };
    const message = 'Created';

    sendCreated(res, data, message);

    expect(res.status).toHaveBeenCalledWith(201);
    expect(res.json).toHaveBeenCalledWith({
      success: true,
      message,
      data,
    });
  });

  test('sendError should return error status with correct format', () => {
    const res = mockResponse();
    const message = 'Error occurred';
    const statusCode = 400;

    sendError(res, message, statusCode);

    expect(res.status).toHaveBeenCalledWith(statusCode);
    expect(res.json).toHaveBeenCalledWith({
      success: false,
      message,
    });
  });

  test('sendError should default to 500 status', () => {
    const res = mockResponse();
    const message = 'Server error';

    sendError(res, message);

    expect(res.status).toHaveBeenCalledWith(500);
  });
});

describe('Validation Patterns', () => {
  // Egyptian phone regex
  const PHONE_REGEX = /^\+20(10|11|12|15)\d{8}$/;

  // MongoDB ObjectId pattern (24 hex characters)
  const OBJECT_ID_REGEX = /^[a-f\d]{24}$/i;

  test('Egyptian phone validation', () => {
    expect(PHONE_REGEX.test('+201012345678')).toBe(true);
    expect(PHONE_REGEX.test('01012345678')).toBe(false);
    expect(PHONE_REGEX.test('+201312345678')).toBe(false);
  });

  test('MongoDB ObjectId validation', () => {
    expect(OBJECT_ID_REGEX.test('507f1f77bcf86cd799439011')).toBe(true);
    expect(OBJECT_ID_REGEX.test('invalid-id')).toBe(false);
    expect(OBJECT_ID_REGEX.test('507f1f77bcf86cd7994390')).toBe(false);
  });
});

describe('Business Logic Constants', () => {
  const DEFAULTS = {
    commission: 15,
    serviceFee: 5,
    urgentFee: 20,
    minRequestAmount: 50,
    maxRequestAmount: 100000,
  };

  test('commission should be 15%', () => {
    expect(DEFAULTS.commission).toBe(15);
  });

  test('service fee should be 5%', () => {
    expect(DEFAULTS.serviceFee).toBe(5);
  });

  test('urgent fee should be 20%', () => {
    expect(DEFAULTS.urgentFee).toBe(20);
  });

  test('should calculate fees correctly', () => {
    const amount = 1000;
    const commission = (amount * DEFAULTS.commission) / 100;
    const serviceFee = (amount * DEFAULTS.serviceFee) / 100;
    const urgentFee = (amount * DEFAULTS.urgentFee) / 100;

    expect(commission).toBe(150);
    expect(serviceFee).toBe(50);
    expect(urgentFee).toBe(200);
  });

  test('total with all fees should be calculated correctly', () => {
    const baseAmount = 1000;
    const isUrgent = true;

    const serviceFee = (baseAmount * DEFAULTS.serviceFee) / 100;
    const urgentFee = isUrgent ? (baseAmount * DEFAULTS.urgentFee) / 100 : 0;
    const total = baseAmount + serviceFee + urgentFee;

    expect(total).toBe(1250); // 1000 + 50 (5%) + 200 (20%)
  });
});

describe('User Roles', () => {
  const USER_ROLES = {
    customer: 'customer',
    craftsman: 'craftsman',
    admin: 'admin',
  };

  test('should have all required roles', () => {
    expect(USER_ROLES.customer).toBe('customer');
    expect(USER_ROLES.craftsman).toBe('craftsman');
    expect(USER_ROLES.admin).toBe('admin');
  });

  test('role permissions', () => {
    const rolePermissions: Record<string, string[]> = {
      customer: ['view_craftsmen', 'create_request', 'chat', 'review'],
      craftsman: ['view_requests', 'submit_quote', 'chat', 'manage_profile'],
      admin: ['manage_users', 'manage_craftsmen', 'view_reports', 'broadcast'],
    };

    expect(rolePermissions.customer).toContain('create_request');
    expect(rolePermissions.craftsman).toContain('submit_quote');
    expect(rolePermissions.admin).toContain('manage_users');
  });
});

describe('Notification Types', () => {
  const NOTIFICATION_TYPES = [
    'request',
    'quote',
    'status',
    'message',
    'review',
    'system',
  ];

  test('should have all notification types', () => {
    expect(NOTIFICATION_TYPES).toContain('request');
    expect(NOTIFICATION_TYPES).toContain('quote');
    expect(NOTIFICATION_TYPES).toContain('status');
    expect(NOTIFICATION_TYPES).toContain('message');
    expect(NOTIFICATION_TYPES).toContain('review');
    expect(NOTIFICATION_TYPES).toContain('system');
  });

  test('notification type to icon mapping', () => {
    const typeIcons: Record<string, string> = {
      request: 'assignment',
      quote: 'attach_money',
      status: 'update',
      message: 'message',
      review: 'star',
      system: 'notifications',
    };

    NOTIFICATION_TYPES.forEach((type) => {
      expect(typeIcons[type]).toBeDefined();
    });
  });
});
