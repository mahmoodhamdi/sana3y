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

_$SendOtpRequestImpl _$$SendOtpRequestImplFromJson(Map<String, dynamic> json) =>
    _$SendOtpRequestImpl(
      phone: json['phone'] as String,
      type: json['type'] as String? ?? 'verification',
    );

Map<String, dynamic> _$$SendOtpRequestImplToJson(
        _$SendOtpRequestImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'type': instance.type,
    };

_$VerifyOtpRequestImpl _$$VerifyOtpRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$VerifyOtpRequestImpl(
      phone: json['phone'] as String,
      code: json['code'] as String,
      type: json['type'] as String? ?? 'verification',
    );

Map<String, dynamic> _$$VerifyOtpRequestImplToJson(
        _$VerifyOtpRequestImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'code': instance.code,
      'type': instance.type,
    };

_$RegisterRequestImpl _$$RegisterRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$RegisterRequestImpl(
      phone: json['phone'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$$RegisterRequestImplToJson(
        _$RegisterRequestImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'name': instance.name,
      'role': instance.role,
      'email': instance.email,
      'password': instance.password,
    };

_$LoginOtpRequestImpl _$$LoginOtpRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginOtpRequestImpl(
      phone: json['phone'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$$LoginOtpRequestImplToJson(
        _$LoginOtpRequestImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'otp': instance.otp,
    };

_$LoginPasswordRequestImpl _$$LoginPasswordRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginPasswordRequestImpl(
      phone: json['phone'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$LoginPasswordRequestImplToJson(
        _$LoginPasswordRequestImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'password': instance.password,
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
      phone: json['phone'] as String,
      otp: json['otp'] as String,
      newPassword: json['newPassword'] as String,
    );

Map<String, dynamic> _$$ResetPasswordRequestImplToJson(
        _$ResetPasswordRequestImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'otp': instance.otp,
      'newPassword': instance.newPassword,
    };

_$UpdateProfileRequestImpl _$$UpdateProfileRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateProfileRequestImpl(
      name: json['name'] as String?,
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$$UpdateProfileRequestImplToJson(
        _$UpdateProfileRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
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
