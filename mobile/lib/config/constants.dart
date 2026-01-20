class AppConstants {
  // API
  static const String baseUrl = 'https://sherman-workers-directors-leonard.trycloudflare.com/api/v1';
  static const Duration apiTimeout = Duration(seconds: 30);

  // App Info
  static const String appName = 'صنايعي';
  static const String appNameEn = 'Sana3y';
  static const String appTagline = 'كل الصنايعية في إيدك';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';
  static const String onboardingKey = 'onboarding_completed';
  static const String languageKey = 'app_language';
  static const String themeKey = 'app_theme';

  // Firebase
  static const String fcmTopicAll = 'all';
  static const String fcmTopicCustomers = 'customers';
  static const String fcmTopicCraftsmen = 'craftsmen';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxImagesPerRequest = 5;
  static const int maxWorkPhotos = 10;
  static const int maxAddresses = 10;

  // Location
  static const double defaultLatitude = 30.4522; // الباجور
  static const double defaultLongitude = 30.9667;
  static const double defaultRadius = 10.0; // km

  // Validation
  static const int minPasswordLength = 6;
  static const int otpLength = 6;
  static const int otpExpirationMinutes = 5;
  static const String egyptPhonePattern = r'^\+20[0-9]{10}$';

  // Fees
  static const double defaultCommission = 15.0;
  static const double defaultServiceFee = 5.0;
  static const double urgentFee = 20.0;
  static const double minWithdrawal = 100.0;

  // Animation Durations
  static const Duration shortDuration = Duration(milliseconds: 200);
  static const Duration mediumDuration = Duration(milliseconds: 350);
  static const Duration longDuration = Duration(milliseconds: 500);

  // Image Sizes
  static const int thumbnailSize = 150;
  static const int mediumImageSize = 400;
  static const int largeImageSize = 800;
}

class ApiEndpoints {
  // Auth
  static const String sendVerificationOtp = '/auth/send-verification-otp';
  static const String sendResetOtp = '/auth/send-reset-otp';
  static const String verifyOtp = '/auth/verify-otp';
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String loginGoogle = '/auth/login/google';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String me = '/auth/me';
  static const String changePassword = '/auth/change-password';
  static const String resetPassword = '/auth/reset-password';
  static const String checkEmail = '/auth/check-email';
  static const String switchRole = '/auth/switch-role';
  static const String roles = '/auth/roles';

  // Categories
  static const String categories = '/categories';

  // Craftsmen
  static const String craftsmen = '/craftsmen';
  static const String craftsmenPublic = '/craftsmen/public';
  static const String craftsmenFeatured = '/craftsmen/featured';
  static const String nearbyCraftsmen = '/craftsmen/nearby';
  static const String craftsmenByCategory = '/craftsmen/category'; // + /:categoryId
  static const String craftsmanMe = '/craftsmen/me';
  static const String craftsmanProfile = '/craftsmen/profile';
  static const String craftsmanOnline = '/craftsmen/online';
  static const String craftsmanAvailability = '/craftsmen/availability';
  static const String craftsmanPhotos = '/craftsmen/photos';
  static const String craftsmanEarnings = '/craftsmen/earnings';
  static const String craftsmanPayout = '/craftsmen/payout';
  static const String craftsmanPayoutHistory = '/craftsmen/payout/history';

  // Requests
  static const String requests = '/requests';
  static const String myRequests = '/requests/my';
  static const String availableRequests = '/requests/available';
  static const String activeJobs = '/requests/my-jobs/active';
  static const String completedJobs = '/requests/my-jobs/completed';
  static const String requestStatuses = '/requests/statuses';

  // Chat
  static const String chatConversations = '/chat/conversations';
  static const String chatUnreadCount = '/chat/unread-count';

  // Notifications
  static const String notifications = '/notifications';
  static const String notificationsUnreadCount = '/notifications/unread-count';
  static const String notificationsReadAll = '/notifications/read-all';
  static const String notificationsFcmToken = '/notifications/fcm-token';

  // Reviews
  static const String reviews = '/reviews';

  // Upload
  static const String upload = '/upload';
  static const String uploadMultiple = '/upload/multiple';

  // Payments
  static const String payments = '/payments';
  static const String paymentsInitialize = '/payments/initialize';
  static const String paymentsWallet = '/payments/wallet';
  static const String paymentsWebhook = '/payments/webhook';

  // Customer
  static const String customerMe = '/customers/me';
  static const String customerAddresses = '/customers/addresses';
  static const String customerFavorites = '/customers/favorites';

  // Admin
  static const String adminDashboard = '/admin/dashboard';
  static const String adminCustomers = '/admin/customers';
  static const String adminCraftsmen = '/admin/craftsmen';
  static const String adminCraftsmenPending = '/admin/craftsmen/pending';
  static const String adminRequests = '/admin/requests';
  static const String adminTransactions = '/admin/transactions';
  static const String adminZones = '/admin/zones';
  static const String adminSettings = '/admin/settings';
  static const String adminNotifications = '/admin/notifications';
}

class SocketEvents {
  // Server -> Client
  static const String requestNew = 'request:new';
  static const String requestQuote = 'request:quote';
  static const String requestAccepted = 'request:accepted';
  static const String requestStatus = 'request:status';
  static const String messageNew = 'message:new';
  static const String messageRead = 'message:read';
  static const String typingStart = 'typing:start';
  static const String typingStop = 'typing:stop';

  // Client -> Server
  static const String joinUser = 'join:user';
  static const String joinRequest = 'join:request';
  static const String leaveRequest = 'leave:request';
  static const String craftsmanOnline = 'craftsman:online';
  static const String craftsmanOffline = 'craftsman:offline';
}
