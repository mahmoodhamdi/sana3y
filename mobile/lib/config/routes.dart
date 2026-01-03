import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../models/auth.dart';
import '../models/user.dart';
import '../screens/auth/phone_screen.dart';
import '../screens/auth/otp_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/customer/home_screen.dart';
import '../screens/customer/category_craftsmen_screen.dart';
import '../screens/customer/craftsman_profile_screen.dart';
import '../screens/customer/search_screen.dart';
import '../screens/customer/request/create_request_screen.dart';
import '../screens/customer/request/request_tracking_screen.dart';
import '../screens/customer/request/requests_history_screen.dart';
import '../screens/craftsman/craftsman_home_screen.dart';
import '../screens/craftsman/manage_profile_screen.dart';
import '../screens/craftsman/available_requests_screen.dart';
import '../screens/craftsman/active_jobs_screen.dart';
import '../screens/craftsman/earnings_screen.dart';
import '../screens/shared/conversations_list_screen.dart';
import '../screens/shared/chat_screen.dart';
import '../screens/shared/craftsman_reviews_screen.dart';
import '../screens/customer/rate_service_screen.dart';

class AppRoutes {
  // Auth Routes
  static const String splash = '/';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String register = '/register';

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
          state.uri.path == AppRoutes.register;
      final isSplash = state.uri.path == AppRoutes.splash;

      // Still loading auth state
      if (authState.status == AuthStatus.initial) {
        return null;
      }

      // Redirect to login if not authenticated and not on auth route
      if (!isAuthenticated && !isAuthRoute && !isSplash) {
        return AppRoutes.login;
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
        builder: (context, state) => const PhoneScreen(),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return OtpScreen(
            phone: extra?['phone'] ?? '',
            isLogin: extra?['isLogin'] ?? true,
            devCode: extra?['devCode'],
          );
        },
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return RegisterScreen(
            phone: extra?['phone'] ?? '',
          );
        },
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

      // Placeholder routes
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const _PlaceholderScreen(
          title: 'الإشعارات',
          icon: Icons.notifications,
        ),
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
        builder: (context, state) => const _PlaceholderScreen(
          title: 'حسابي',
          icon: Icons.person,
        ),
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
        builder: (context, state) => const _PlaceholderScreen(
          title: 'صور الأعمال',
          icon: Icons.photo_library,
        ),
      ),
      GoRoute(
        path: AppRoutes.craftsmanServices,
        builder: (context, state) => const _PlaceholderScreen(
          title: 'الخدمات',
          icon: Icons.build,
        ),
      ),
      GoRoute(
        path: AppRoutes.craftsmanAvailability,
        builder: (context, state) => const _PlaceholderScreen(
          title: 'أوقات العمل',
          icon: Icons.access_time,
        ),
      ),
      GoRoute(
        path: AppRoutes.craftsmanWithdrawal,
        builder: (context, state) => const _PlaceholderScreen(
          title: 'طلب سحب',
          icon: Icons.payments,
        ),
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
