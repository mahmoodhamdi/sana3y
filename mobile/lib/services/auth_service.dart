import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import '../models/auth.dart';
import '../models/user.dart';
import 'api_client.dart';

class AuthService {
  final ApiClient _client;
  final firebase_auth.FirebaseAuth _firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthService(this._client);

  // Send verification OTP to email
  Future<OtpSendResult> sendVerificationOTP(SendVerificationOTPRequest request) async {
    final response = await _client.post(
      '/auth/send-verification-otp',
      data: request.toJson(),
    );
    return OtpSendResult.fromJson(response.data['data']);
  }

  // Send password reset OTP to email
  Future<OtpSendResult> sendPasswordResetOTP(SendPasswordResetOTPRequest request) async {
    final response = await _client.post(
      '/auth/send-reset-otp',
      data: request.toJson(),
    );
    return OtpSendResult.fromJson(response.data['data']);
  }

  // Verify OTP
  Future<bool> verifyOtp(VerifyOtpRequest request) async {
    final response = await _client.post(
      '/auth/verify-otp',
      data: request.toJson(),
    );
    return response.data['success'] == true;
  }

  // Register with email and password
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

  // Login with email and password
  Future<AuthResult> loginWithPassword(LoginPasswordRequest request) async {
    final response = await _client.post(
      '/auth/login',
      data: request.toJson(),
    );
    final result = AuthResult.fromJson(response.data['data']);
    await _client.setTokens(
      token: result.tokens.token,
      refreshToken: result.tokens.refreshToken,
    );
    return result;
  }

  // Login with Google
  Future<AuthResult> loginWithGoogle({String role = 'customer'}) async {
    // Sign in with Google
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('تم إلغاء تسجيل الدخول');
    }

    // Get Google auth credentials
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create Firebase credential
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase
    final userCredential = await _firebaseAuth.signInWithCredential(credential);

    // Get the Firebase ID token
    final idToken = await userCredential.user?.getIdToken();
    if (idToken == null) {
      throw Exception('فشل في الحصول على رمز التوثيق');
    }

    // Send ID token to backend
    final response = await _client.post(
      '/auth/login/google',
      data: LoginGoogleRequest(idToken: idToken, role: role).toJson(),
    );
    final result = AuthResult.fromJson(response.data['data']);
    await _client.setTokens(
      token: result.tokens.token,
      refreshToken: result.tokens.refreshToken,
    );
    return result;
  }

  // Check if email exists
  Future<bool> checkEmailExists(CheckEmailRequest request) async {
    final response = await _client.post(
      '/auth/check-email',
      data: request.toJson(),
    );
    return response.data['data']['exists'] == true;
  }

  // Get user profile
  Future<User> getProfile() async {
    final response = await _client.get('/auth/me');
    return User.fromJson(response.data['data']['user']);
  }

  // Update user profile
  Future<User> updateProfile(UpdateProfileRequest request) async {
    final response = await _client.put(
      '/auth/me',
      data: request.toJson(),
    );
    return User.fromJson(response.data['data']['user']);
  }

  // Change password
  Future<void> changePassword(ChangePasswordRequest request) async {
    await _client.post(
      '/auth/change-password',
      data: request.toJson(),
    );
  }

  // Reset password with OTP
  Future<void> resetPassword(ResetPasswordRequest request) async {
    await _client.post(
      '/auth/reset-password',
      data: request.toJson(),
    );
  }

  // Logout
  Future<void> logout() async {
    try {
      await _client.post('/auth/logout');
      // Also sign out from Google/Firebase
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } finally {
      await _client.clearTokens();
    }
  }

  // Check if logged in
  Future<bool> isLoggedIn() async {
    final token = await _client.getToken();
    return token != null;
  }
}
