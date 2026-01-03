import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  // Auth Routes
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String phone = '/phone';
  static const String otp = '/otp';
  static const String registerCustomer = '/register/customer';
  static const String registerCraftsman = '/register/craftsman';
  static const String craftsmanDocuments = '/register/craftsman/documents';
  static const String pendingApproval = '/pending-approval';

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
  static const String rateService = '/rate/:id';

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

// This will be properly configured when we implement the screens
GoRouter createRouter() {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      // More routes will be added as screens are implemented
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Page not found: ${state.uri.path}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.splash),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
