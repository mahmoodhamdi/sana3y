import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../models/auth.dart';
import '../models/user.dart';
// Auth screens
import '../screens/auth/login_screen.dart';
import '../screens/auth/otp_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/reset_password_screen.dart';
import '../screens/auth/welcome_screen.dart';
import '../screens/auth/craftsman_register_screen.dart';
import '../screens/auth/craftsman_setup_screen.dart';
import '../screens/auth/documents_upload_screen.dart';
// Customer screens
import '../screens/customer/home_screen.dart';
import '../screens/customer/category_craftsmen_screen.dart';
import '../screens/customer/craftsman_profile_screen.dart';
import '../screens/customer/search_screen.dart';
import '../screens/customer/request/create_request_screen.dart';
import '../screens/customer/request/request_tracking_screen.dart';
import '../screens/customer/request/requests_history_screen.dart';
import '../screens/customer/nearby_craftsmen_screen.dart';
import '../screens/customer/quotes_list_screen.dart';
import '../screens/customer/request_details_screen.dart';
import '../screens/customer/rate_service_screen.dart';
import '../screens/customer/profile_screen.dart';
// Craftsman screens
import '../screens/craftsman/craftsman_home_screen.dart';
import '../screens/craftsman/manage_profile_screen.dart';
import '../screens/craftsman/available_requests_screen.dart';
import '../screens/craftsman/active_jobs_screen.dart';
import '../screens/craftsman/earnings_screen.dart';
import '../screens/craftsman/send_quote_screen.dart';
import '../screens/craftsman/job_details_screen.dart';
import '../screens/craftsman/complete_job_screen.dart';
import '../screens/craftsman/jobs_history_screen.dart';
import '../screens/craftsman/manage_services_screen.dart';
import '../screens/craftsman/work_photos_screen.dart';
import '../screens/craftsman/availability_screen.dart';
import '../screens/craftsman/earnings_history_screen.dart';
import '../screens/craftsman/withdrawal_screen.dart';
// Shared screens
import '../screens/shared/conversations_list_screen.dart';
import '../screens/shared/chat_screen.dart';
import '../screens/shared/craftsman_reviews_screen.dart';
import '../screens/shared/notifications_screen.dart';
import '../screens/shared/settings_screen.dart';
import '../screens/shared/addresses_screen.dart';
import '../screens/shared/add_address_screen.dart';
import '../screens/shared/edit_profile_screen.dart';
import '../screens/shared/switch_role_screen.dart';
import '../screens/shared/my_reviews_screen.dart';
// New customer screens
import '../screens/customer/request_submitted_screen.dart';
import '../screens/customer/quote_details_screen.dart';
import '../screens/customer/favorites_screen.dart';
// New craftsman screen
import '../screens/craftsman/request_details_screen.dart';

class AppRoutes {
  // Auth Routes
  static const String splash = '/';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String register = '/register';
  static const String resetPassword = '/reset-password';
  static const String craftsmanSetup = '/craftsman/setup';

  // Customer Routes
  static const String customerHome = '/customer';
  static const String categoryDetail = '/category/:id';
  static const String craftsmanProfile = '/craftsman/:id';
  static const String search = '/search';
  static const String createRequest = '/create-request';
  static const String requestTracking = '/request/:id';
  static const String requestHistory = '/requests';
  static const String customerProfile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String addresses = '/addresses';
  static const String addAddress = '/addresses/add';
  static const String favorites = '/favorites';
  static const String notifications = '/notifications';
  static const String conversations = '/conversations';
  static const String chat = '/chat/:id';
  static const String rateService = '/rate/:requestId';
  static const String craftsmanReviews = '/craftsman/:id/reviews';

  // Craftsman Routes
  static const String craftsmanHome = '/craftsman';
  static const String craftsmanRequests = '/craftsman/requests';
  static const String craftsmanAvailableRequests = '/craftsman/requests/available';
  static const String craftsmanActiveJobs = '/craftsman/jobs';
  static const String craftsmanJobDetail = '/craftsman/job/:id';
  static const String craftsmanEarnings = '/craftsman/earnings';
  static const String craftsmanWithdrawal = '/craftsman/withdrawal';
  static const String craftsmanProfileManagement = '/craftsman/profile';
  static const String craftsmanServices = '/craftsman/services';
  static const String craftsmanAvailability = '/craftsman/availability';
  static const String craftsmanWorkPhotos = '/craftsman/photos';
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isAuthRoute = state.uri.path == AppRoutes.login ||
          state.uri.path == AppRoutes.otp ||
          state.uri.path == AppRoutes.register ||
          state.uri.path == AppRoutes.resetPassword;
      final isSplash = state.uri.path == AppRoutes.splash;
      final isCraftsmanSetup = state.uri.path == AppRoutes.craftsmanSetup;

      // Still loading auth state
      if (authState.status == AuthStatus.initial) {
        return null;
      }

      // Redirect to login if not authenticated and not on auth route
      if (!isAuthenticated && !isAuthRoute && !isSplash) {
        return AppRoutes.login;
      }

      // Allow craftsman setup route for authenticated craftsmen
      if (isAuthenticated && isCraftsmanSetup) {
        return null; // Allow access
      }

      // Redirect to home if authenticated and on auth route
      if (isAuthenticated && isAuthRoute) {
        final role = authState.user?.role;
        return role == UserRole.craftsman ? AppRoutes.craftsmanHome : AppRoutes.customerHome;
      }

      // Redirect from splash based on auth state
      if (isSplash && authState.status != AuthStatus.initial) {
        if (isAuthenticated) {
          final role = authState.user?.role;
          return role == UserRole.craftsman ? AppRoutes.craftsmanHome : AppRoutes.customerHome;
        }
        return AppRoutes.login;
      }

      return null;
    },
    routes: [
      // Splash Screen
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.handyman, size: 80, color: Colors.blue),
                SizedBox(height: 16),
                CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),

      // Auth Routes
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return OtpScreen(
            email: extra?['email'] ?? '',
            isPasswordReset: extra?['isPasswordReset'] ?? false,
            isRegistration: extra?['isRegistration'] ?? false,
            devCode: extra?['devCode'],
          );
        },
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return RegisterScreen(
            email: extra?['email'],
            otp: extra?['otp'],
          );
        },
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return ResetPasswordScreen(
            email: extra?['email'] ?? '',
            otp: extra?['otp'] ?? '',
          );
        },
      ),
      GoRoute(
        path: AppRoutes.craftsmanSetup,
        builder: (context, state) => const CraftsmanSetupScreen(),
      ),

      // Customer Home
      GoRoute(
        path: AppRoutes.customerHome,
        builder: (context, state) => const CustomerHomeScreen(),
      ),

      // Craftsman Home
      GoRoute(
        path: AppRoutes.craftsmanHome,
        builder: (context, state) => const CraftsmanHomeScreen(),
      ),

      // Category Craftsmen
      GoRoute(
        path: '/category/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return CategoryCraftsmenScreen(categoryId: id);
        },
      ),

      // Craftsman Profile
      GoRoute(
        path: '/craftsman/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return CraftsmanProfileScreen(craftsmanId: id);
        },
      ),

      // Search
      GoRoute(
        path: AppRoutes.search,
        builder: (context, state) => const SearchScreen(),
      ),

      // Craftsman Profile Management
      GoRoute(
        path: AppRoutes.craftsmanProfileManagement,
        builder: (context, state) => const ManageProfileScreen(),
      ),

      // Notifications
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: AppRoutes.requestHistory,
        builder: (context, state) => const RequestsHistoryScreen(),
      ),
      GoRoute(
        path: '/request/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return RequestTrackingScreen(requestId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.createRequest,
        builder: (context, state) => const CreateRequestScreen(),
      ),
      GoRoute(
        path: AppRoutes.conversations,
        builder: (context, state) => const ConversationsListScreen(),
      ),
      GoRoute(
        path: '/chat/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return ChatScreen(conversationId: id);
        },
      ),
      GoRoute(
        path: '/rate/:requestId',
        builder: (context, state) {
          final requestId = state.pathParameters['requestId'] ?? '';
          final extra = state.extra as Map<String, dynamic>?;
          return RateServiceScreen(
            requestId: requestId,
            craftsmanName: extra?['craftsmanName'] ?? 'الصنايعي',
          );
        },
      ),
      GoRoute(
        path: '/craftsman/:id/reviews',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          final extra = state.extra as Map<String, dynamic>?;
          return CraftsmanReviewsScreen(
            craftsmanId: id,
            craftsmanName: extra?['craftsmanName'] ?? 'الصنايعي',
          );
        },
      ),
      GoRoute(
        path: AppRoutes.customerProfile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.craftsmanRequests,
        builder: (context, state) => const _PlaceholderScreen(
          title: 'الطلبات',
          icon: Icons.work,
        ),
      ),
      GoRoute(
        path: AppRoutes.craftsmanAvailableRequests,
        builder: (context, state) => const AvailableRequestsScreen(),
      ),
      GoRoute(
        path: AppRoutes.craftsmanActiveJobs,
        builder: (context, state) => const ActiveJobsScreen(),
      ),
      GoRoute(
        path: AppRoutes.craftsmanEarnings,
        builder: (context, state) => const EarningsScreen(),
      ),
      GoRoute(
        path: AppRoutes.craftsmanWorkPhotos,
        builder: (context, state) => const WorkPhotosScreen(),
      ),
      GoRoute(
        path: AppRoutes.craftsmanServices,
        builder: (context, state) => const ManageServicesScreen(),
      ),
      GoRoute(
        path: AppRoutes.craftsmanAvailability,
        builder: (context, state) => const AvailabilityScreen(),
      ),
      GoRoute(
        path: AppRoutes.craftsmanWithdrawal,
        builder: (context, state) => const WithdrawalScreen(),
      ),
      // Send Quote
      GoRoute(
        path: '/craftsman/request/:id/quote',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return SendQuoteScreen(requestId: id);
        },
      ),
      // Job Details
      GoRoute(
        path: '/craftsman/job/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return JobDetailsScreen(jobId: id);
        },
      ),
      // Complete Job
      GoRoute(
        path: '/craftsman/job/:id/complete',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return CompleteJobScreen(jobId: id);
        },
      ),
      // Jobs History
      GoRoute(
        path: '/craftsman/jobs/history',
        builder: (context, state) => const JobsHistoryScreen(),
      ),
      // Earnings History
      GoRoute(
        path: '/craftsman/earnings/history',
        builder: (context, state) => const EarningsHistoryScreen(),
      ),
      // Customer - Nearby Craftsmen
      GoRoute(
        path: '/nearby',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return NearbyCraftsmenScreen(categoryId: extra?['categoryId']);
        },
      ),
      // Customer - Quotes List
      GoRoute(
        path: '/request/:id/quotes',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return QuotesListScreen(requestId: id);
        },
      ),
      // Customer - Request Details
      GoRoute(
        path: '/request/:id/details',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return RequestDetailsScreen(requestId: id);
        },
      ),
      // Shared - Settings
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      // Shared - Addresses
      GoRoute(
        path: AppRoutes.addresses,
        builder: (context, state) => const AddressesScreen(),
      ),
      // Shared - Add Address
      GoRoute(
        path: AppRoutes.addAddress,
        builder: (context, state) {
          final editId = state.uri.queryParameters['edit'];
          return AddAddressScreen(editId: editId);
        },
      ),
      // Shared - Edit Profile
      GoRoute(
        path: AppRoutes.editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
      // Auth - Welcome
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      // Auth - Craftsman Register
      GoRoute(
        path: '/craftsman/register',
        builder: (context, state) => const CraftsmanRegisterScreen(),
      ),
      // Auth - Documents Upload
      GoRoute(
        path: '/craftsman/register/documents',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return DocumentsUploadScreen(registrationData: extra);
        },
      ),
      // Customer - Request Submitted Success
      GoRoute(
        path: '/request/:id/submitted',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          final extra = state.extra as Map<String, dynamic>?;
          return RequestSubmittedScreen(
            requestId: id,
            requestNumber: extra?['requestNumber'],
          );
        },
      ),
      // Customer - Quote Details
      GoRoute(
        path: '/quote/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          final extra = state.extra as Map<String, dynamic>?;
          return QuoteDetailsScreen(
            quoteId: id,
            requestId: extra?['requestId'] ?? '',
            quote: extra?['quote'],
          );
        },
      ),
      // Customer - Favorites
      GoRoute(
        path: AppRoutes.favorites,
        builder: (context, state) => const FavoritesScreen(),
      ),
      // Shared - Switch Role
      GoRoute(
        path: '/switch-role',
        builder: (context, state) => const SwitchRoleScreen(),
      ),
      // Shared - My Reviews
      GoRoute(
        path: '/my-reviews',
        builder: (context, state) => const MyReviewsScreen(),
      ),
      // Craftsman - Request Details (for available requests)
      GoRoute(
        path: '/craftsman/request/:id/details',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return CraftsmanRequestDetailsScreen(requestId: id);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('الصفحة غير موجودة: ${state.uri.path}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.splash),
              child: const Text('الرئيسية'),
            ),
          ],
        ),
      ),
    ),
  );
});

// Placeholder screen for unimplemented routes
class _PlaceholderScreen extends ConsumerWidget {
  final String title;
  final IconData icon;

  const _PlaceholderScreen({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'مرحباً ${user?.name ?? ""}!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'سيتم إضافة المزيد من الميزات قريباً',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
