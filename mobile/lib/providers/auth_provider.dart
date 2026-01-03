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

  Future<OtpSendResult> sendOtp(String phone, {String type = 'verification'}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final authService = ref.read(authServiceProvider);
      final result = await authService.sendOtp(
        SendOtpRequest(phone: phone, type: type),
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

  Future<bool> verifyOtp(String phone, String code, {String type = 'verification'}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final authService = ref.read(authServiceProvider);
      final result = await authService.verifyOtp(
        VerifyOtpRequest(phone: phone, code: code, type: type),
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

  Future<void> register({
    required String phone,
    required String name,
    required String role,
    String? email,
    String? password,
  }) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      final authService = ref.read(authServiceProvider);
      final result = await authService.register(
        RegisterRequest(
          phone: phone,
          name: name,
          role: role,
          email: email,
          password: password,
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

  Future<void> loginWithOtp(String phone, String otp) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      final authService = ref.read(authServiceProvider);
      final result = await authService.loginWithOtp(
        LoginOtpRequest(phone: phone, otp: otp),
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

  Future<void> loginWithPassword(String phone, String password) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      final authService = ref.read(authServiceProvider);
      final result = await authService.loginWithPassword(
        LoginPasswordRequest(phone: phone, password: password),
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

  Future<void> updateProfile({
    String? name,
    String? email,
    String? avatar,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final authService = ref.read(authServiceProvider);
      final user = await authService.updateProfile(
        UpdateProfileRequest(name: name, email: email, avatar: avatar),
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

  Future<void> resetPassword(String phone, String otp, String newPassword) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final authService = ref.read(authServiceProvider);
      await authService.resetPassword(
        ResetPasswordRequest(phone: phone, otp: otp, newPassword: newPassword),
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

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    try {
      final authService = ref.read(authServiceProvider);
      await authService.logout();
    } finally {
      state = const AuthState(status: AuthStatus.unauthenticated);
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
