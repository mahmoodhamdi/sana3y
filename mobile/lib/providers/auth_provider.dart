import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/auth.dart';
import '../models/user.dart';
import '../services/api_client.dart';
import '../services/auth_service.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
ApiClient apiClient(ApiClientRef ref) {
  return ApiClient();
}

@Riverpod(keepAlive: true)
AuthService authService(AuthServiceRef ref) {
  return AuthService(ref.watch(apiClientProvider));
}

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  AuthState build() {
    _checkAuthStatus();
    return const AuthState();
  }

  Future<void> _checkAuthStatus() async {
    final authService = ref.read(authServiceProvider);
    final isLoggedIn = await authService.isLoggedIn();

    if (isLoggedIn) {
      try {
        final user = await authService.getProfile();
        state = AuthState(
          status: AuthStatus.authenticated,
          user: user,
        );
      } catch (e) {
        state = const AuthState(status: AuthStatus.unauthenticated);
      }
    } else {
      state = const AuthState(status: AuthStatus.unauthenticated);
    }
  }

  // Send verification OTP to email
  Future<OtpSendResult> sendVerificationOTP(String email) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final authService = ref.read(authServiceProvider);
      final result = await authService.sendVerificationOTP(
        SendVerificationOTPRequest(email: email),
      );
      state = state.copyWith(isLoading: false);
      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getErrorMessage(e),
      );
      rethrow;
    }
  }

  // Send password reset OTP to email
  Future<OtpSendResult> sendPasswordResetOTP(String email) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final authService = ref.read(authServiceProvider);
      final result = await authService.sendPasswordResetOTP(
        SendPasswordResetOTPRequest(email: email),
      );
      state = state.copyWith(isLoading: false);
      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getErrorMessage(e),
      );
      rethrow;
    }
  }

  // Verify OTP
  Future<bool> verifyOtp(String email, String code, {String type = 'verification'}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final authService = ref.read(authServiceProvider);
      final result = await authService.verifyOtp(
        VerifyOtpRequest(email: email, code: code, type: type),
      );
      state = state.copyWith(isLoading: false);
      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getErrorMessage(e),
      );
      rethrow;
    }
  }

  // Register with email and password
  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String role,
    required String otp,
  }) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      final authService = ref.read(authServiceProvider);
      final result = await authService.register(
        RegisterRequest(
          email: email,
          password: password,
          name: name,
          role: role,
          otp: otp,
        ),
      );
      state = AuthState(
        status: AuthStatus.authenticated,
        user: result.user,
        tokens: result.tokens,
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: _getErrorMessage(e),
      );
      rethrow;
    }
  }

  // Login with email and password
  Future<void> loginWithPassword(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      final authService = ref.read(authServiceProvider);
      final result = await authService.loginWithPassword(
        LoginPasswordRequest(email: email, password: password),
      );
      state = AuthState(
        status: AuthStatus.authenticated,
        user: result.user,
        tokens: result.tokens,
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: _getErrorMessage(e),
      );
      rethrow;
    }
  }

  // Login with Google
  Future<void> loginWithGoogle({String role = 'customer'}) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      final authService = ref.read(authServiceProvider);
      final result = await authService.loginWithGoogle(role: role);
      state = AuthState(
        status: AuthStatus.authenticated,
        user: result.user,
        tokens: result.tokens,
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: _getErrorMessage(e),
      );
      rethrow;
    }
  }

  // Check if email exists
  Future<bool> checkEmailExists(String email) async {
    try {
      final authService = ref.read(authServiceProvider);
      return await authService.checkEmailExists(CheckEmailRequest(email: email));
    } catch (e) {
      return false;
    }
  }

  // Update profile
  Future<void> updateProfile({
    String? name,
    String? avatar,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final authService = ref.read(authServiceProvider);
      final user = await authService.updateProfile(
        UpdateProfileRequest(name: name, avatar: avatar),
      );
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getErrorMessage(e),
      );
      rethrow;
    }
  }

  // Change password
  Future<void> changePassword(String currentPassword, String newPassword) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final authService = ref.read(authServiceProvider);
      await authService.changePassword(
        ChangePasswordRequest(
          currentPassword: currentPassword,
          newPassword: newPassword,
        ),
      );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getErrorMessage(e),
      );
      rethrow;
    }
  }

  // Reset password with OTP
  Future<void> resetPassword(String email, String otp, String newPassword) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final authService = ref.read(authServiceProvider);
      await authService.resetPassword(
        ResetPasswordRequest(email: email, otp: otp, newPassword: newPassword),
      );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getErrorMessage(e),
      );
      rethrow;
    }
  }

  // Logout
  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    try {
      final authService = ref.read(authServiceProvider);
      await authService.logout();
    } finally {
      state = const AuthState(status: AuthStatus.unauthenticated);
    }
  }

  // Switch user role
  Future<void> switchRole(UserRole newRole) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final authService = ref.read(authServiceProvider);
      final roleStr = newRole == UserRole.customer ? 'customer' : 'craftsman';
      final result = await authService.switchRole(roleStr);
      state = AuthState(
        status: AuthStatus.authenticated,
        user: result.user,
        tokens: result.tokens,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getErrorMessage(e),
      );
      rethrow;
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  String _getErrorMessage(dynamic error) {
    if (error is Exception) {
      return error.toString().replaceAll('Exception: ', '');
    }
    return 'حدث خطأ غير متوقع';
  }
}

// Helper providers
@riverpod
bool isAuthenticated(IsAuthenticatedRef ref) {
  final authState = ref.watch(authProvider);
  return authState.status == AuthStatus.authenticated;
}

@riverpod
User? currentUser(CurrentUserRef ref) {
  return ref.watch(authProvider).user;
}

@riverpod
UserRole? userRole(UserRoleRef ref) {
  return ref.watch(authProvider).user?.role;
}
