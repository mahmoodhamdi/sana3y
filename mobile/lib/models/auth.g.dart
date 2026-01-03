// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthTokens _$AuthTokensFromJson(Map<String, dynamic> json) => _AuthTokens(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: json['expiresIn'] as String,
    );

Map<String, dynamic> _$AuthTokensToJson(_AuthTokens instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
    };

_AuthResult _$AuthResultFromJson(Map<String, dynamic> json) => _AuthResult(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      tokens: AuthTokens.fromJson(json['tokens'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResultToJson(_AuthResult instance) =>
    <String, dynamic>{
      'user': instance.user,
      'tokens': instance.tokens,
    };

_OtpSendResult _$OtpSendResultFromJson(Map<String, dynamic> json) =>
    _OtpSendResult(
      success: json['success'] as bool,
      message: json['message'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      code: json['code'] as String?,
    );

Map<String, dynamic> _$OtpSendResultToJson(_OtpSendResult instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'code': instance.code,
    };

_SendOtpRequest _$SendOtpRequestFromJson(Map<String, dynamic> json) =>
    _SendOtpRequest(
      phone: json['phone'] as String,
      type: json['type'] as String? ?? 'verification',
    );

Map<String, dynamic> _$SendOtpRequestToJson(_SendOtpRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'type': instance.type,
    };

_VerifyOtpRequest _$VerifyOtpRequestFromJson(Map<String, dynamic> json) =>
    _VerifyOtpRequest(
      phone: json['phone'] as String,
      code: json['code'] as String,
      type: json['type'] as String? ?? 'verification',
    );

Map<String, dynamic> _$VerifyOtpRequestToJson(_VerifyOtpRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'code': instance.code,
      'type': instance.type,
    };

_RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    _RegisterRequest(
      phone: json['phone'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$RegisterRequestToJson(_RegisterRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'name': instance.name,
      'role': instance.role,
      'email': instance.email,
      'password': instance.password,
    };

_LoginOtpRequest _$LoginOtpRequestFromJson(Map<String, dynamic> json) =>
    _LoginOtpRequest(
      phone: json['phone'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$LoginOtpRequestToJson(_LoginOtpRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'otp': instance.otp,
    };

_LoginPasswordRequest _$LoginPasswordRequestFromJson(
        Map<String, dynamic> json) =>
    _LoginPasswordRequest(
      phone: json['phone'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginPasswordRequestToJson(
        _LoginPasswordRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'password': instance.password,
    };

_ChangePasswordRequest _$ChangePasswordRequestFromJson(
        Map<String, dynamic> json) =>
    _ChangePasswordRequest(
      currentPassword: json['currentPassword'] as String,
      newPassword: json['newPassword'] as String,
    );

Map<String, dynamic> _$ChangePasswordRequestToJson(
        _ChangePasswordRequest instance) =>
    <String, dynamic>{
      'currentPassword': instance.currentPassword,
      'newPassword': instance.newPassword,
    };

_ResetPasswordRequest _$ResetPasswordRequestFromJson(
        Map<String, dynamic> json) =>
    _ResetPasswordRequest(
      phone: json['phone'] as String,
      otp: json['otp'] as String,
      newPassword: json['newPassword'] as String,
    );

Map<String, dynamic> _$ResetPasswordRequestToJson(
        _ResetPasswordRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'otp': instance.otp,
      'newPassword': instance.newPassword,
    };

_UpdateProfileRequest _$UpdateProfileRequestFromJson(
        Map<String, dynamic> json) =>
    _UpdateProfileRequest(
      name: json['name'] as String?,
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$UpdateProfileRequestToJson(
        _UpdateProfileRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
    };

_AuthState _$AuthStateFromJson(Map<String, dynamic> json) => _AuthState(
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

Map<String, dynamic> _$AuthStateToJson(_AuthState instance) =>
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
