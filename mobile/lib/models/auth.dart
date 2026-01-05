import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'auth.freezed.dart';
part 'auth.g.dart';

@freezed
class AuthTokens with _$AuthTokens {
  const factory AuthTokens({
    required String token,
    required String refreshToken,
    required String expiresIn,
  }) = _AuthTokens;

  factory AuthTokens.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensFromJson(json);
}

@freezed
class AuthResult with _$AuthResult {
  const factory AuthResult({
    required User user,
    required AuthTokens tokens,
  }) = _AuthResult;

  factory AuthResult.fromJson(Map<String, dynamic> json) =>
      _$AuthResultFromJson(json);
}

@freezed
class OtpSendResult with _$OtpSendResult {
  const factory OtpSendResult({
    required bool success,
    required String message,
    required DateTime expiresAt,
    String? code, // Only in development
  }) = _OtpSendResult;

  factory OtpSendResult.fromJson(Map<String, dynamic> json) =>
      _$OtpSendResultFromJson(json);
}

@freezed
class SendVerificationOTPRequest with _$SendVerificationOTPRequest {
  const factory SendVerificationOTPRequest({
    required String email,
  }) = _SendVerificationOTPRequest;

  factory SendVerificationOTPRequest.fromJson(Map<String, dynamic> json) =>
      _$SendVerificationOTPRequestFromJson(json);
}

@freezed
class SendPasswordResetOTPRequest with _$SendPasswordResetOTPRequest {
  const factory SendPasswordResetOTPRequest({
    required String email,
  }) = _SendPasswordResetOTPRequest;

  factory SendPasswordResetOTPRequest.fromJson(Map<String, dynamic> json) =>
      _$SendPasswordResetOTPRequestFromJson(json);
}

@freezed
class VerifyOtpRequest with _$VerifyOtpRequest {
  const factory VerifyOtpRequest({
    required String email,
    required String code,
    @Default('verification') String type,
  }) = _VerifyOtpRequest;

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);
}

@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String email,
    required String password,
    required String name,
    required String role,
    required String otp,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}

@freezed
class LoginPasswordRequest with _$LoginPasswordRequest {
  const factory LoginPasswordRequest({
    required String email,
    required String password,
  }) = _LoginPasswordRequest;

  factory LoginPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginPasswordRequestFromJson(json);
}

@freezed
class LoginGoogleRequest with _$LoginGoogleRequest {
  const factory LoginGoogleRequest({
    required String idToken,
    @Default('customer') String role,
  }) = _LoginGoogleRequest;

  factory LoginGoogleRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginGoogleRequestFromJson(json);
}

@freezed
class ChangePasswordRequest with _$ChangePasswordRequest {
  const factory ChangePasswordRequest({
    required String currentPassword,
    required String newPassword,
  }) = _ChangePasswordRequest;

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);
}

@freezed
class ResetPasswordRequest with _$ResetPasswordRequest {
  const factory ResetPasswordRequest({
    required String email,
    required String otp,
    required String newPassword,
  }) = _ResetPasswordRequest;

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);
}

@freezed
class UpdateProfileRequest with _$UpdateProfileRequest {
  const factory UpdateProfileRequest({
    String? name,
    String? avatar,
  }) = _UpdateProfileRequest;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);
}

@freezed
class CheckEmailRequest with _$CheckEmailRequest {
  const factory CheckEmailRequest({
    required String email,
  }) = _CheckEmailRequest;

  factory CheckEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckEmailRequestFromJson(json);
}

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    User? user,
    AuthTokens? tokens,
    String? errorMessage,
    @Default(false) bool isLoading,
  }) = _AuthState;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}
