// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthTokensImpl _$$AuthTokensImplFromJson(Map<String, dynamic> json) =>
    _$AuthTokensImpl(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: json['expiresIn'] as String,
    );

Map<String, dynamic> _$$AuthTokensImplToJson(_$AuthTokensImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
    };

_$AuthResultImpl _$$AuthResultImplFromJson(Map<String, dynamic> json) =>
    _$AuthResultImpl(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      tokens: AuthTokens.fromJson(json['tokens'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AuthResultImplToJson(_$AuthResultImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'tokens': instance.tokens,
    };

_$OtpSendResultImpl _$$OtpSendResultImplFromJson(Map<String, dynamic> json) =>
    _$OtpSendResultImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      code: json['code'] as String?,
    );

Map<String, dynamic> _$$OtpSendResultImplToJson(_$OtpSendResultImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'code': instance.code,
    };

_$SendVerificationOTPRequestImpl _$$SendVerificationOTPRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SendVerificationOTPRequestImpl(
      email: json['email'] as String,
    );

Map<String, dynamic> _$$SendVerificationOTPRequestImplToJson(
        _$SendVerificationOTPRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

_$SendPasswordResetOTPRequestImpl _$$SendPasswordResetOTPRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SendPasswordResetOTPRequestImpl(
      email: json['email'] as String,
    );

Map<String, dynamic> _$$SendPasswordResetOTPRequestImplToJson(
        _$SendPasswordResetOTPRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

_$VerifyOtpRequestImpl _$$VerifyOtpRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$VerifyOtpRequestImpl(
      email: json['email'] as String,
      code: json['code'] as String,
      type: json['type'] as String? ?? 'verification',
    );

Map<String, dynamic> _$$VerifyOtpRequestImplToJson(
        _$VerifyOtpRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'code': instance.code,
      'type': instance.type,
    };

_$RegisterRequestImpl _$$RegisterRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$RegisterRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$$RegisterRequestImplToJson(
        _$RegisterRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'role': instance.role,
      'otp': instance.otp,
    };

_$LoginPasswordRequestImpl _$$LoginPasswordRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginPasswordRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$LoginPasswordRequestImplToJson(
        _$LoginPasswordRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

_$LoginGoogleRequestImpl _$$LoginGoogleRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginGoogleRequestImpl(
      idToken: json['idToken'] as String,
      role: json['role'] as String? ?? 'customer',
    );

Map<String, dynamic> _$$LoginGoogleRequestImplToJson(
        _$LoginGoogleRequestImpl instance) =>
    <String, dynamic>{
      'idToken': instance.idToken,
      'role': instance.role,
    };

_$ChangePasswordRequestImpl _$$ChangePasswordRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ChangePasswordRequestImpl(
      currentPassword: json['currentPassword'] as String,
      newPassword: json['newPassword'] as String,
    );

Map<String, dynamic> _$$ChangePasswordRequestImplToJson(
        _$ChangePasswordRequestImpl instance) =>
    <String, dynamic>{
      'currentPassword': instance.currentPassword,
      'newPassword': instance.newPassword,
    };

_$ResetPasswordRequestImpl _$$ResetPasswordRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ResetPasswordRequestImpl(
      email: json['email'] as String,
      otp: json['otp'] as String,
      newPassword: json['newPassword'] as String,
    );

Map<String, dynamic> _$$ResetPasswordRequestImplToJson(
        _$ResetPasswordRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'otp': instance.otp,
      'newPassword': instance.newPassword,
    };

_$UpdateProfileRequestImpl _$$UpdateProfileRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateProfileRequestImpl(
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$$UpdateProfileRequestImplToJson(
        _$UpdateProfileRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'avatar': instance.avatar,
    };

_$CheckEmailRequestImpl _$$CheckEmailRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CheckEmailRequestImpl(
      email: json['email'] as String,
    );

Map<String, dynamic> _$$CheckEmailRequestImplToJson(
        _$CheckEmailRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

_$AuthStateImpl _$$AuthStateImplFromJson(Map<String, dynamic> json) =>
    _$AuthStateImpl(
      status: $enumDecodeNullable(_$AuthStatusEnumMap, json['status']) ??
          AuthStatus.initial,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      tokens: json['tokens'] == null
          ? null
          : AuthTokens.fromJson(json['tokens'] as Map<String, dynamic>),
      errorMessage: json['errorMessage'] as String?,
      isLoading: json['isLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$$AuthStateImplToJson(_$AuthStateImpl instance) =>
    <String, dynamic>{
      'status': _$AuthStatusEnumMap[instance.status]!,
      'user': instance.user,
      'tokens': instance.tokens,
      'errorMessage': instance.errorMessage,
      'isLoading': instance.isLoading,
    };

const _$AuthStatusEnumMap = {
  AuthStatus.initial: 'initial',
  AuthStatus.loading: 'loading',
  AuthStatus.authenticated: 'authenticated',
  AuthStatus.unauthenticated: 'unauthenticated',
  AuthStatus.error: 'error',
};
