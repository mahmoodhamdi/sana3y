class AppConstants {
  // API
  static const String baseUrl = 'http://localhost:5000/api/v1';
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
  static const String sendOtp = '/auth/send-otp';
  static const String verifyOtp = '/auth/verify-otp';
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh-token';
  static const String me = '/auth/me';
  static const String updateProfile = '/auth/profile';

  // Categories
  static const String categories = '/categories';

  // Craftsmen
  static const String craftsmen = '/craftsmen';
  static const String nearbyCraftsmen = '/craftsmen/nearby';
  static const String searchCraftsmen = '/craftsmen/search';
  static const String craftsmanProfile = '/craftsman/profile';
  static const String craftsmanServices = '/craftsman/services';
  static const String craftsmanAvailability = '/craftsman/availability';
  static const String craftsmanOnlineStatus = '/craftsman/online-status';
  static const String craftsmanWorkPhotos = '/craftsman/work-photos';
  static const String craftsmanStatistics = '/craftsman/statistics';
  static const String craftsmanRequests = '/craftsman/requests';

  // Requests
  static const String requests = '/requests';
  static const String customerRequests = '/requests';
  static const String availableRequests = '/craftsman/requests/available';

  // Conversations
  static const String conversations = '/conversations';

  // Upload
  static const String upload = '/upload';
  static const String uploadMultiple = '/upload/multiple';

  // Settings
  static const String settings = '/settings';
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
