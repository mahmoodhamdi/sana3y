// User Roles
export const USER_ROLES = {
  CUSTOMER: 'customer',
  CRAFTSMAN: 'craftsman',
  ADMIN: 'admin',
} as const;

// Craftsman Status
export const CRAFTSMAN_STATUS = {
  PENDING: 'pending',
  APPROVED: 'approved',
  REJECTED: 'rejected',
  SUSPENDED: 'suspended',
} as const;

// Request Status
export const REQUEST_STATUS = {
  PENDING: 'pending',
  QUOTED: 'quoted',
  ACCEPTED: 'accepted',
  IN_PROGRESS: 'in_progress',
  COMPLETED: 'completed',
  CANCELLED: 'cancelled',
} as const;

// Payment Status
export const PAYMENT_STATUS = {
  PENDING: 'pending',
  PAID: 'paid',
  REFUNDED: 'refunded',
} as const;

// Payment Methods
export const PAYMENT_METHODS = {
  CASH: 'cash',
  CARD: 'card',
  WALLET: 'wallet',
} as const;

// Urgency Types
export const URGENCY_TYPES = {
  URGENT: 'urgent',
  TODAY: 'today',
  SCHEDULED: 'scheduled',
} as const;

// Address Labels
export const ADDRESS_LABELS = {
  HOME: 'home',
  WORK: 'work',
  OTHER: 'other',
} as const;

// Price Types
export const PRICE_TYPES = {
  FIXED: 'fixed',
  HOURLY: 'hourly',
  QUOTE: 'quote',
} as const;

// Default Values
export const DEFAULTS = {
  COMMISSION: 15,
  SERVICE_FEE: 5,
  URGENT_FEE: 20,
  MIN_WITHDRAWAL: 100,
  PAGE_SIZE: 20,
  SERVICE_RADIUS: 10,
  OTP_LENGTH: 6,
  OTP_EXPIRATION_MINUTES: 5,
  MAX_IMAGES_PER_REQUEST: 5,
  MAX_WORK_PHOTOS: 10,
  MAX_ADDRESSES: 10,
} as const;

// Location (الباجور)
export const DEFAULT_LOCATION = {
  LAT: 30.4522,
  LNG: 30.9667,
  CITY: 'الباجور',
  GOVERNORATE: 'المنوفية',
} as const;

// Working Days
export const DAYS_OF_WEEK = [
  { day: 0, name: 'الأحد', nameEn: 'Sunday' },
  { day: 1, name: 'الاثنين', nameEn: 'Monday' },
  { day: 2, name: 'الثلاثاء', nameEn: 'Tuesday' },
  { day: 3, name: 'الأربعاء', nameEn: 'Wednesday' },
  { day: 4, name: 'الخميس', nameEn: 'Thursday' },
  { day: 5, name: 'الجمعة', nameEn: 'Friday' },
  { day: 6, name: 'السبت', nameEn: 'Saturday' },
] as const;

// Quality Ratings
export const QUALITY_RATINGS = [
  { key: 'punctuality', nameAr: 'الالتزام بالموعد', nameEn: 'Punctuality' },
  { key: 'professionalism', nameAr: 'الاحترافية', nameEn: 'Professionalism' },
  { key: 'quality', nameAr: 'جودة الشغل', nameEn: 'Quality' },
  { key: 'cleanliness', nameAr: 'النظافة', nameEn: 'Cleanliness' },
  { key: 'communication', nameAr: 'التواصل', nameEn: 'Communication' },
] as const;

// Badges
export const BADGES = {
  VERIFIED: 'verified',
  TOP_RATED: 'top-rated',
  FAST_RESPONSE: 'fast-response',
} as const;

// Egyptian Phone Regex
export const EGYPT_PHONE_REGEX = /^\+20[0-9]{10}$/;

// Notification Types
export const NOTIFICATION_TYPES = {
  REQUEST: 'request',
  QUOTE: 'quote',
  STATUS: 'status',
  CHAT: 'chat',
  REVIEW: 'review',
  SYSTEM: 'system',
  PROMOTION: 'promotion',
} as const;
