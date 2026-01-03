import '../models/auth.dart';
import '../models/user.dart';
import 'api_client.dart';

class AuthService {
  final ApiClient _client;

  AuthService(this._client);

  Future<OtpSendResult> sendOtp(SendOtpRequest request) async {
    final response = await _client.post(
      '/auth/send-otp',
      data: request.toJson(),
    );
    return OtpSendResult.fromJson(response.data['data']);
  }

  Future<bool> verifyOtp(VerifyOtpRequest request) async {
    final response = await _client.post(
      '/auth/verify-otp',
      data: request.toJson(),
    );
    return response.data['success'] == true;
  }

  Future<AuthResult> register(RegisterRequest request) async {
    final response = await _client.post(
      '/auth/register',
      data: request.toJson(),
    );
    final result = AuthResult.fromJson(response.data['data']);
    await _client.setTokens(
      token: result.tokens.token,
      refreshToken: result.tokens.refreshToken,
    );
    return result;
  }

  Future<AuthResult> loginWithOtp(LoginOtpRequest request) async {
    final response = await _client.post(
      '/auth/login/otp',
      data: request.toJson(),
    );
    final result = AuthResult.fromJson(response.data['data']);
    await _client.setTokens(
      token: result.tokens.token,
      refreshToken: result.tokens.refreshToken,
    );
    return result;
  }

  Future<AuthResult> loginWithPassword(LoginPasswordRequest request) async {
    final response = await _client.post(
      '/auth/login/password',
      data: request.toJson(),
    );
    final result = AuthResult.fromJson(response.data['data']);
    await _client.setTokens(
      token: result.tokens.token,
      refreshToken: result.tokens.refreshToken,
    );
    return result;
  }

  Future<User> getProfile() async {
    final response = await _client.get('/auth/me');
    return User.fromJson(response.data['data']['user']);
  }

  Future<User> updateProfile(UpdateProfileRequest request) async {
    final response = await _client.put(
      '/auth/me',
      data: request.toJson(),
    );
    return User.fromJson(response.data['data']['user']);
  }

  Future<void> changePassword(ChangePasswordRequest request) async {
    await _client.post(
      '/auth/change-password',
      data: request.toJson(),
    );
  }

  Future<void> resetPassword(ResetPasswordRequest request) async {
    await _client.post(
      '/auth/reset-password',
      data: request.toJson(),
    );
  }

  Future<void> logout() async {
    try {
      await _client.post('/auth/logout');
    } finally {
      await _client.clearTokens();
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _client.getToken();
    return token != null;
  }
}
