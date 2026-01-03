// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthTokens {
  String get token;
  String get refreshToken;
  String get expiresIn;

  /// Create a copy of AuthTokens
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthTokensCopyWith<AuthTokens> get copyWith =>
      _$AuthTokensCopyWithImpl<AuthTokens>(this as AuthTokens, _$identity);

  /// Serializes this AuthTokens to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthTokens &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token, refreshToken, expiresIn);

  @override
  String toString() {
    return 'AuthTokens(token: $token, refreshToken: $refreshToken, expiresIn: $expiresIn)';
  }
}

/// @nodoc
abstract mixin class $AuthTokensCopyWith<$Res> {
  factory $AuthTokensCopyWith(
          AuthTokens value, $Res Function(AuthTokens) _then) =
      _$AuthTokensCopyWithImpl;
  @useResult
  $Res call({String token, String refreshToken, String expiresIn});
}

/// @nodoc
class _$AuthTokensCopyWithImpl<$Res> implements $AuthTokensCopyWith<$Res> {
  _$AuthTokensCopyWithImpl(this._self, this._then);

  final AuthTokens _self;
  final $Res Function(AuthTokens) _then;

  /// Create a copy of AuthTokens
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? refreshToken = null,
    Object? expiresIn = null,
  }) {
    return _then(_self.copyWith(
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _self.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AuthTokens implements AuthTokens {
  const _AuthTokens(
      {required this.token,
      required this.refreshToken,
      required this.expiresIn});
  factory _AuthTokens.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensFromJson(json);

  @override
  final String token;
  @override
  final String refreshToken;
  @override
  final String expiresIn;

  /// Create a copy of AuthTokens
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthTokensCopyWith<_AuthTokens> get copyWith =>
      __$AuthTokensCopyWithImpl<_AuthTokens>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AuthTokensToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthTokens &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token, refreshToken, expiresIn);

  @override
  String toString() {
    return 'AuthTokens(token: $token, refreshToken: $refreshToken, expiresIn: $expiresIn)';
  }
}

/// @nodoc
abstract mixin class _$AuthTokensCopyWith<$Res>
    implements $AuthTokensCopyWith<$Res> {
  factory _$AuthTokensCopyWith(
          _AuthTokens value, $Res Function(_AuthTokens) _then) =
      __$AuthTokensCopyWithImpl;
  @override
  @useResult
  $Res call({String token, String refreshToken, String expiresIn});
}

/// @nodoc
class __$AuthTokensCopyWithImpl<$Res> implements _$AuthTokensCopyWith<$Res> {
  __$AuthTokensCopyWithImpl(this._self, this._then);

  final _AuthTokens _self;
  final $Res Function(_AuthTokens) _then;

  /// Create a copy of AuthTokens
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? token = null,
    Object? refreshToken = null,
    Object? expiresIn = null,
  }) {
    return _then(_AuthTokens(
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _self.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$AuthResult {
  User get user;
  AuthTokens get tokens;

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthResultCopyWith<AuthResult> get copyWith =>
      _$AuthResultCopyWithImpl<AuthResult>(this as AuthResult, _$identity);

  /// Serializes this AuthResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthResult &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.tokens, tokens) || other.tokens == tokens));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user, tokens);

  @override
  String toString() {
    return 'AuthResult(user: $user, tokens: $tokens)';
  }
}

/// @nodoc
abstract mixin class $AuthResultCopyWith<$Res> {
  factory $AuthResultCopyWith(
          AuthResult value, $Res Function(AuthResult) _then) =
      _$AuthResultCopyWithImpl;
  @useResult
  $Res call({User user, AuthTokens tokens});

  $UserCopyWith<$Res> get user;
  $AuthTokensCopyWith<$Res> get tokens;
}

/// @nodoc
class _$AuthResultCopyWithImpl<$Res> implements $AuthResultCopyWith<$Res> {
  _$AuthResultCopyWithImpl(this._self, this._then);

  final AuthResult _self;
  final $Res Function(AuthResult) _then;

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? tokens = null,
  }) {
    return _then(_self.copyWith(
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      tokens: null == tokens
          ? _self.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as AuthTokens,
    ));
  }

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthTokensCopyWith<$Res> get tokens {
    return $AuthTokensCopyWith<$Res>(_self.tokens, (value) {
      return _then(_self.copyWith(tokens: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _AuthResult implements AuthResult {
  const _AuthResult({required this.user, required this.tokens});
  factory _AuthResult.fromJson(Map<String, dynamic> json) =>
      _$AuthResultFromJson(json);

  @override
  final User user;
  @override
  final AuthTokens tokens;

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthResultCopyWith<_AuthResult> get copyWith =>
      __$AuthResultCopyWithImpl<_AuthResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AuthResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthResult &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.tokens, tokens) || other.tokens == tokens));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user, tokens);

  @override
  String toString() {
    return 'AuthResult(user: $user, tokens: $tokens)';
  }
}

/// @nodoc
abstract mixin class _$AuthResultCopyWith<$Res>
    implements $AuthResultCopyWith<$Res> {
  factory _$AuthResultCopyWith(
          _AuthResult value, $Res Function(_AuthResult) _then) =
      __$AuthResultCopyWithImpl;
  @override
  @useResult
  $Res call({User user, AuthTokens tokens});

  @override
  $UserCopyWith<$Res> get user;
  @override
  $AuthTokensCopyWith<$Res> get tokens;
}

/// @nodoc
class __$AuthResultCopyWithImpl<$Res> implements _$AuthResultCopyWith<$Res> {
  __$AuthResultCopyWithImpl(this._self, this._then);

  final _AuthResult _self;
  final $Res Function(_AuthResult) _then;

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? user = null,
    Object? tokens = null,
  }) {
    return _then(_AuthResult(
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      tokens: null == tokens
          ? _self.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as AuthTokens,
    ));
  }

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthTokensCopyWith<$Res> get tokens {
    return $AuthTokensCopyWith<$Res>(_self.tokens, (value) {
      return _then(_self.copyWith(tokens: value));
    });
  }
}

/// @nodoc
mixin _$OtpSendResult {
  bool get success;
  String get message;
  DateTime get expiresAt;
  String? get code;

  /// Create a copy of OtpSendResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OtpSendResultCopyWith<OtpSendResult> get copyWith =>
      _$OtpSendResultCopyWithImpl<OtpSendResult>(
          this as OtpSendResult, _$identity);

  /// Serializes this OtpSendResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OtpSendResult &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, success, message, expiresAt, code);

  @override
  String toString() {
    return 'OtpSendResult(success: $success, message: $message, expiresAt: $expiresAt, code: $code)';
  }
}

/// @nodoc
abstract mixin class $OtpSendResultCopyWith<$Res> {
  factory $OtpSendResultCopyWith(
          OtpSendResult value, $Res Function(OtpSendResult) _then) =
      _$OtpSendResultCopyWithImpl;
  @useResult
  $Res call({bool success, String message, DateTime expiresAt, String? code});
}

/// @nodoc
class _$OtpSendResultCopyWithImpl<$Res>
    implements $OtpSendResultCopyWith<$Res> {
  _$OtpSendResultCopyWithImpl(this._self, this._then);

  final OtpSendResult _self;
  final $Res Function(OtpSendResult) _then;

  /// Create a copy of OtpSendResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? expiresAt = null,
    Object? code = freezed,
  }) {
    return _then(_self.copyWith(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      code: freezed == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _OtpSendResult implements OtpSendResult {
  const _OtpSendResult(
      {required this.success,
      required this.message,
      required this.expiresAt,
      this.code});
  factory _OtpSendResult.fromJson(Map<String, dynamic> json) =>
      _$OtpSendResultFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final DateTime expiresAt;
  @override
  final String? code;

  /// Create a copy of OtpSendResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OtpSendResultCopyWith<_OtpSendResult> get copyWith =>
      __$OtpSendResultCopyWithImpl<_OtpSendResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OtpSendResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OtpSendResult &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, success, message, expiresAt, code);

  @override
  String toString() {
    return 'OtpSendResult(success: $success, message: $message, expiresAt: $expiresAt, code: $code)';
  }
}

/// @nodoc
abstract mixin class _$OtpSendResultCopyWith<$Res>
    implements $OtpSendResultCopyWith<$Res> {
  factory _$OtpSendResultCopyWith(
          _OtpSendResult value, $Res Function(_OtpSendResult) _then) =
      __$OtpSendResultCopyWithImpl;
  @override
  @useResult
  $Res call({bool success, String message, DateTime expiresAt, String? code});
}

/// @nodoc
class __$OtpSendResultCopyWithImpl<$Res>
    implements _$OtpSendResultCopyWith<$Res> {
  __$OtpSendResultCopyWithImpl(this._self, this._then);

  final _OtpSendResult _self;
  final $Res Function(_OtpSendResult) _then;

  /// Create a copy of OtpSendResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? expiresAt = null,
    Object? code = freezed,
  }) {
    return _then(_OtpSendResult(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      code: freezed == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$SendOtpRequest {
  String get phone;
  String get type;

  /// Create a copy of SendOtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SendOtpRequestCopyWith<SendOtpRequest> get copyWith =>
      _$SendOtpRequestCopyWithImpl<SendOtpRequest>(
          this as SendOtpRequest, _$identity);

  /// Serializes this SendOtpRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SendOtpRequest &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phone, type);

  @override
  String toString() {
    return 'SendOtpRequest(phone: $phone, type: $type)';
  }
}

/// @nodoc
abstract mixin class $SendOtpRequestCopyWith<$Res> {
  factory $SendOtpRequestCopyWith(
          SendOtpRequest value, $Res Function(SendOtpRequest) _then) =
      _$SendOtpRequestCopyWithImpl;
  @useResult
  $Res call({String phone, String type});
}

/// @nodoc
class _$SendOtpRequestCopyWithImpl<$Res>
    implements $SendOtpRequestCopyWith<$Res> {
  _$SendOtpRequestCopyWithImpl(this._self, this._then);

  final SendOtpRequest _self;
  final $Res Function(SendOtpRequest) _then;

  /// Create a copy of SendOtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SendOtpRequest implements SendOtpRequest {
  const _SendOtpRequest({required this.phone, this.type = 'verification'});
  factory _SendOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$SendOtpRequestFromJson(json);

  @override
  final String phone;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of SendOtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SendOtpRequestCopyWith<_SendOtpRequest> get copyWith =>
      __$SendOtpRequestCopyWithImpl<_SendOtpRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SendOtpRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SendOtpRequest &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phone, type);

  @override
  String toString() {
    return 'SendOtpRequest(phone: $phone, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$SendOtpRequestCopyWith<$Res>
    implements $SendOtpRequestCopyWith<$Res> {
  factory _$SendOtpRequestCopyWith(
          _SendOtpRequest value, $Res Function(_SendOtpRequest) _then) =
      __$SendOtpRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String phone, String type});
}

/// @nodoc
class __$SendOtpRequestCopyWithImpl<$Res>
    implements _$SendOtpRequestCopyWith<$Res> {
  __$SendOtpRequestCopyWithImpl(this._self, this._then);

  final _SendOtpRequest _self;
  final $Res Function(_SendOtpRequest) _then;

  /// Create a copy of SendOtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? phone = null,
    Object? type = null,
  }) {
    return _then(_SendOtpRequest(
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$VerifyOtpRequest {
  String get phone;
  String get code;
  String get type;

  /// Create a copy of VerifyOtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VerifyOtpRequestCopyWith<VerifyOtpRequest> get copyWith =>
      _$VerifyOtpRequestCopyWithImpl<VerifyOtpRequest>(
          this as VerifyOtpRequest, _$identity);

  /// Serializes this VerifyOtpRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VerifyOtpRequest &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phone, code, type);

  @override
  String toString() {
    return 'VerifyOtpRequest(phone: $phone, code: $code, type: $type)';
  }
}

/// @nodoc
abstract mixin class $VerifyOtpRequestCopyWith<$Res> {
  factory $VerifyOtpRequestCopyWith(
          VerifyOtpRequest value, $Res Function(VerifyOtpRequest) _then) =
      _$VerifyOtpRequestCopyWithImpl;
  @useResult
  $Res call({String phone, String code, String type});
}

/// @nodoc
class _$VerifyOtpRequestCopyWithImpl<$Res>
    implements $VerifyOtpRequestCopyWith<$Res> {
  _$VerifyOtpRequestCopyWithImpl(this._self, this._then);

  final VerifyOtpRequest _self;
  final $Res Function(VerifyOtpRequest) _then;

  /// Create a copy of VerifyOtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? code = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _VerifyOtpRequest implements VerifyOtpRequest {
  const _VerifyOtpRequest(
      {required this.phone, required this.code, this.type = 'verification'});
  factory _VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);

  @override
  final String phone;
  @override
  final String code;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of VerifyOtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VerifyOtpRequestCopyWith<_VerifyOtpRequest> get copyWith =>
      __$VerifyOtpRequestCopyWithImpl<_VerifyOtpRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VerifyOtpRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VerifyOtpRequest &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phone, code, type);

  @override
  String toString() {
    return 'VerifyOtpRequest(phone: $phone, code: $code, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$VerifyOtpRequestCopyWith<$Res>
    implements $VerifyOtpRequestCopyWith<$Res> {
  factory _$VerifyOtpRequestCopyWith(
          _VerifyOtpRequest value, $Res Function(_VerifyOtpRequest) _then) =
      __$VerifyOtpRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String phone, String code, String type});
}

/// @nodoc
class __$VerifyOtpRequestCopyWithImpl<$Res>
    implements _$VerifyOtpRequestCopyWith<$Res> {
  __$VerifyOtpRequestCopyWithImpl(this._self, this._then);

  final _VerifyOtpRequest _self;
  final $Res Function(_VerifyOtpRequest) _then;

  /// Create a copy of VerifyOtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? phone = null,
    Object? code = null,
    Object? type = null,
  }) {
    return _then(_VerifyOtpRequest(
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$RegisterRequest {
  String get phone;
  String get name;
  String get role;
  String? get email;
  String? get password;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegisterRequestCopyWith<RegisterRequest> get copyWith =>
      _$RegisterRequestCopyWithImpl<RegisterRequest>(
          this as RegisterRequest, _$identity);

  /// Serializes this RegisterRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegisterRequest &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, phone, name, role, email, password);

  @override
  String toString() {
    return 'RegisterRequest(phone: $phone, name: $name, role: $role, email: $email, password: $password)';
  }
}

/// @nodoc
abstract mixin class $RegisterRequestCopyWith<$Res> {
  factory $RegisterRequestCopyWith(
          RegisterRequest value, $Res Function(RegisterRequest) _then) =
      _$RegisterRequestCopyWithImpl;
  @useResult
  $Res call(
      {String phone,
      String name,
      String role,
      String? email,
      String? password});
}

/// @nodoc
class _$RegisterRequestCopyWithImpl<$Res>
    implements $RegisterRequestCopyWith<$Res> {
  _$RegisterRequestCopyWithImpl(this._self, this._then);

  final RegisterRequest _self;
  final $Res Function(RegisterRequest) _then;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? name = null,
    Object? role = null,
    Object? email = freezed,
    Object? password = freezed,
  }) {
    return _then(_self.copyWith(
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _RegisterRequest implements RegisterRequest {
  const _RegisterRequest(
      {required this.phone,
      required this.name,
      required this.role,
      this.email,
      this.password});
  factory _RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  @override
  final String phone;
  @override
  final String name;
  @override
  final String role;
  @override
  final String? email;
  @override
  final String? password;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegisterRequestCopyWith<_RegisterRequest> get copyWith =>
      __$RegisterRequestCopyWithImpl<_RegisterRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RegisterRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegisterRequest &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, phone, name, role, email, password);

  @override
  String toString() {
    return 'RegisterRequest(phone: $phone, name: $name, role: $role, email: $email, password: $password)';
  }
}

/// @nodoc
abstract mixin class _$RegisterRequestCopyWith<$Res>
    implements $RegisterRequestCopyWith<$Res> {
  factory _$RegisterRequestCopyWith(
          _RegisterRequest value, $Res Function(_RegisterRequest) _then) =
      __$RegisterRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String phone,
      String name,
      String role,
      String? email,
      String? password});
}

/// @nodoc
class __$RegisterRequestCopyWithImpl<$Res>
    implements _$RegisterRequestCopyWith<$Res> {
  __$RegisterRequestCopyWithImpl(this._self, this._then);

  final _RegisterRequest _self;
  final $Res Function(_RegisterRequest) _then;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? phone = null,
    Object? name = null,
    Object? role = null,
    Object? email = freezed,
    Object? password = freezed,
  }) {
    return _then(_RegisterRequest(
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$LoginOtpRequest {
  String get phone;
  String get otp;

  /// Create a copy of LoginOtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginOtpRequestCopyWith<LoginOtpRequest> get copyWith =>
      _$LoginOtpRequestCopyWithImpl<LoginOtpRequest>(
          this as LoginOtpRequest, _$identity);

  /// Serializes this LoginOtpRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginOtpRequest &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.otp, otp) || other.otp == otp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phone, otp);

  @override
  String toString() {
    return 'LoginOtpRequest(phone: $phone, otp: $otp)';
  }
}

/// @nodoc
abstract mixin class $LoginOtpRequestCopyWith<$Res> {
  factory $LoginOtpRequestCopyWith(
          LoginOtpRequest value, $Res Function(LoginOtpRequest) _then) =
      _$LoginOtpRequestCopyWithImpl;
  @useResult
  $Res call({String phone, String otp});
}

/// @nodoc
class _$LoginOtpRequestCopyWithImpl<$Res>
    implements $LoginOtpRequestCopyWith<$Res> {
  _$LoginOtpRequestCopyWithImpl(this._self, this._then);

  final LoginOtpRequest _self;
  final $Res Function(LoginOtpRequest) _then;

  /// Create a copy of LoginOtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? otp = null,
  }) {
    return _then(_self.copyWith(
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _self.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _LoginOtpRequest implements LoginOtpRequest {
  const _LoginOtpRequest({required this.phone, required this.otp});
  factory _LoginOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginOtpRequestFromJson(json);

  @override
  final String phone;
  @override
  final String otp;

  /// Create a copy of LoginOtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoginOtpRequestCopyWith<_LoginOtpRequest> get copyWith =>
      __$LoginOtpRequestCopyWithImpl<_LoginOtpRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LoginOtpRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginOtpRequest &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.otp, otp) || other.otp == otp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phone, otp);

  @override
  String toString() {
    return 'LoginOtpRequest(phone: $phone, otp: $otp)';
  }
}

/// @nodoc
abstract mixin class _$LoginOtpRequestCopyWith<$Res>
    implements $LoginOtpRequestCopyWith<$Res> {
  factory _$LoginOtpRequestCopyWith(
          _LoginOtpRequest value, $Res Function(_LoginOtpRequest) _then) =
      __$LoginOtpRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String phone, String otp});
}

/// @nodoc
class __$LoginOtpRequestCopyWithImpl<$Res>
    implements _$LoginOtpRequestCopyWith<$Res> {
  __$LoginOtpRequestCopyWithImpl(this._self, this._then);

  final _LoginOtpRequest _self;
  final $Res Function(_LoginOtpRequest) _then;

  /// Create a copy of LoginOtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? phone = null,
    Object? otp = null,
  }) {
    return _then(_LoginOtpRequest(
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _self.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$LoginPasswordRequest {
  String get phone;
  String get password;

  /// Create a copy of LoginPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginPasswordRequestCopyWith<LoginPasswordRequest> get copyWith =>
      _$LoginPasswordRequestCopyWithImpl<LoginPasswordRequest>(
          this as LoginPasswordRequest, _$identity);

  /// Serializes this LoginPasswordRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginPasswordRequest &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phone, password);

  @override
  String toString() {
    return 'LoginPasswordRequest(phone: $phone, password: $password)';
  }
}

/// @nodoc
abstract mixin class $LoginPasswordRequestCopyWith<$Res> {
  factory $LoginPasswordRequestCopyWith(LoginPasswordRequest value,
          $Res Function(LoginPasswordRequest) _then) =
      _$LoginPasswordRequestCopyWithImpl;
  @useResult
  $Res call({String phone, String password});
}

/// @nodoc
class _$LoginPasswordRequestCopyWithImpl<$Res>
    implements $LoginPasswordRequestCopyWith<$Res> {
  _$LoginPasswordRequestCopyWithImpl(this._self, this._then);

  final LoginPasswordRequest _self;
  final $Res Function(LoginPasswordRequest) _then;

  /// Create a copy of LoginPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? password = null,
  }) {
    return _then(_self.copyWith(
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _LoginPasswordRequest implements LoginPasswordRequest {
  const _LoginPasswordRequest({required this.phone, required this.password});
  factory _LoginPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginPasswordRequestFromJson(json);

  @override
  final String phone;
  @override
  final String password;

  /// Create a copy of LoginPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoginPasswordRequestCopyWith<_LoginPasswordRequest> get copyWith =>
      __$LoginPasswordRequestCopyWithImpl<_LoginPasswordRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LoginPasswordRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginPasswordRequest &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phone, password);

  @override
  String toString() {
    return 'LoginPasswordRequest(phone: $phone, password: $password)';
  }
}

/// @nodoc
abstract mixin class _$LoginPasswordRequestCopyWith<$Res>
    implements $LoginPasswordRequestCopyWith<$Res> {
  factory _$LoginPasswordRequestCopyWith(_LoginPasswordRequest value,
          $Res Function(_LoginPasswordRequest) _then) =
      __$LoginPasswordRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String phone, String password});
}

/// @nodoc
class __$LoginPasswordRequestCopyWithImpl<$Res>
    implements _$LoginPasswordRequestCopyWith<$Res> {
  __$LoginPasswordRequestCopyWithImpl(this._self, this._then);

  final _LoginPasswordRequest _self;
  final $Res Function(_LoginPasswordRequest) _then;

  /// Create a copy of LoginPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? phone = null,
    Object? password = null,
  }) {
    return _then(_LoginPasswordRequest(
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ChangePasswordRequest {
  String get currentPassword;
  String get newPassword;

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChangePasswordRequestCopyWith<ChangePasswordRequest> get copyWith =>
      _$ChangePasswordRequestCopyWithImpl<ChangePasswordRequest>(
          this as ChangePasswordRequest, _$identity);

  /// Serializes this ChangePasswordRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChangePasswordRequest &&
            (identical(other.currentPassword, currentPassword) ||
                other.currentPassword == currentPassword) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, currentPassword, newPassword);

  @override
  String toString() {
    return 'ChangePasswordRequest(currentPassword: $currentPassword, newPassword: $newPassword)';
  }
}

/// @nodoc
abstract mixin class $ChangePasswordRequestCopyWith<$Res> {
  factory $ChangePasswordRequestCopyWith(ChangePasswordRequest value,
          $Res Function(ChangePasswordRequest) _then) =
      _$ChangePasswordRequestCopyWithImpl;
  @useResult
  $Res call({String currentPassword, String newPassword});
}

/// @nodoc
class _$ChangePasswordRequestCopyWithImpl<$Res>
    implements $ChangePasswordRequestCopyWith<$Res> {
  _$ChangePasswordRequestCopyWithImpl(this._self, this._then);

  final ChangePasswordRequest _self;
  final $Res Function(ChangePasswordRequest) _then;

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPassword = null,
    Object? newPassword = null,
  }) {
    return _then(_self.copyWith(
      currentPassword: null == currentPassword
          ? _self.currentPassword
          : currentPassword // ignore: cast_nullable_to_non_nullable
              as String,
      newPassword: null == newPassword
          ? _self.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ChangePasswordRequest implements ChangePasswordRequest {
  const _ChangePasswordRequest(
      {required this.currentPassword, required this.newPassword});
  factory _ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);

  @override
  final String currentPassword;
  @override
  final String newPassword;

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChangePasswordRequestCopyWith<_ChangePasswordRequest> get copyWith =>
      __$ChangePasswordRequestCopyWithImpl<_ChangePasswordRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChangePasswordRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChangePasswordRequest &&
            (identical(other.currentPassword, currentPassword) ||
                other.currentPassword == currentPassword) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, currentPassword, newPassword);

  @override
  String toString() {
    return 'ChangePasswordRequest(currentPassword: $currentPassword, newPassword: $newPassword)';
  }
}

/// @nodoc
abstract mixin class _$ChangePasswordRequestCopyWith<$Res>
    implements $ChangePasswordRequestCopyWith<$Res> {
  factory _$ChangePasswordRequestCopyWith(_ChangePasswordRequest value,
          $Res Function(_ChangePasswordRequest) _then) =
      __$ChangePasswordRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String currentPassword, String newPassword});
}

/// @nodoc
class __$ChangePasswordRequestCopyWithImpl<$Res>
    implements _$ChangePasswordRequestCopyWith<$Res> {
  __$ChangePasswordRequestCopyWithImpl(this._self, this._then);

  final _ChangePasswordRequest _self;
  final $Res Function(_ChangePasswordRequest) _then;

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? currentPassword = null,
    Object? newPassword = null,
  }) {
    return _then(_ChangePasswordRequest(
      currentPassword: null == currentPassword
          ? _self.currentPassword
          : currentPassword // ignore: cast_nullable_to_non_nullable
              as String,
      newPassword: null == newPassword
          ? _self.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ResetPasswordRequest {
  String get phone;
  String get otp;
  String get newPassword;

  /// Create a copy of ResetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ResetPasswordRequestCopyWith<ResetPasswordRequest> get copyWith =>
      _$ResetPasswordRequestCopyWithImpl<ResetPasswordRequest>(
          this as ResetPasswordRequest, _$identity);

  /// Serializes this ResetPasswordRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ResetPasswordRequest &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.otp, otp) || other.otp == otp) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phone, otp, newPassword);

  @override
  String toString() {
    return 'ResetPasswordRequest(phone: $phone, otp: $otp, newPassword: $newPassword)';
  }
}

/// @nodoc
abstract mixin class $ResetPasswordRequestCopyWith<$Res> {
  factory $ResetPasswordRequestCopyWith(ResetPasswordRequest value,
          $Res Function(ResetPasswordRequest) _then) =
      _$ResetPasswordRequestCopyWithImpl;
  @useResult
  $Res call({String phone, String otp, String newPassword});
}

/// @nodoc
class _$ResetPasswordRequestCopyWithImpl<$Res>
    implements $ResetPasswordRequestCopyWith<$Res> {
  _$ResetPasswordRequestCopyWithImpl(this._self, this._then);

  final ResetPasswordRequest _self;
  final $Res Function(ResetPasswordRequest) _then;

  /// Create a copy of ResetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? otp = null,
    Object? newPassword = null,
  }) {
    return _then(_self.copyWith(
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _self.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      newPassword: null == newPassword
          ? _self.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ResetPasswordRequest implements ResetPasswordRequest {
  const _ResetPasswordRequest(
      {required this.phone, required this.otp, required this.newPassword});
  factory _ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);

  @override
  final String phone;
  @override
  final String otp;
  @override
  final String newPassword;

  /// Create a copy of ResetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ResetPasswordRequestCopyWith<_ResetPasswordRequest> get copyWith =>
      __$ResetPasswordRequestCopyWithImpl<_ResetPasswordRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ResetPasswordRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ResetPasswordRequest &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.otp, otp) || other.otp == otp) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phone, otp, newPassword);

  @override
  String toString() {
    return 'ResetPasswordRequest(phone: $phone, otp: $otp, newPassword: $newPassword)';
  }
}

/// @nodoc
abstract mixin class _$ResetPasswordRequestCopyWith<$Res>
    implements $ResetPasswordRequestCopyWith<$Res> {
  factory _$ResetPasswordRequestCopyWith(_ResetPasswordRequest value,
          $Res Function(_ResetPasswordRequest) _then) =
      __$ResetPasswordRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String phone, String otp, String newPassword});
}

/// @nodoc
class __$ResetPasswordRequestCopyWithImpl<$Res>
    implements _$ResetPasswordRequestCopyWith<$Res> {
  __$ResetPasswordRequestCopyWithImpl(this._self, this._then);

  final _ResetPasswordRequest _self;
  final $Res Function(_ResetPasswordRequest) _then;

  /// Create a copy of ResetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? phone = null,
    Object? otp = null,
    Object? newPassword = null,
  }) {
    return _then(_ResetPasswordRequest(
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _self.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      newPassword: null == newPassword
          ? _self.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$UpdateProfileRequest {
  String? get name;
  String? get email;
  String? get avatar;

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UpdateProfileRequestCopyWith<UpdateProfileRequest> get copyWith =>
      _$UpdateProfileRequestCopyWithImpl<UpdateProfileRequest>(
          this as UpdateProfileRequest, _$identity);

  /// Serializes this UpdateProfileRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UpdateProfileRequest &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, email, avatar);

  @override
  String toString() {
    return 'UpdateProfileRequest(name: $name, email: $email, avatar: $avatar)';
  }
}

/// @nodoc
abstract mixin class $UpdateProfileRequestCopyWith<$Res> {
  factory $UpdateProfileRequestCopyWith(UpdateProfileRequest value,
          $Res Function(UpdateProfileRequest) _then) =
      _$UpdateProfileRequestCopyWithImpl;
  @useResult
  $Res call({String? name, String? email, String? avatar});
}

/// @nodoc
class _$UpdateProfileRequestCopyWithImpl<$Res>
    implements $UpdateProfileRequestCopyWith<$Res> {
  _$UpdateProfileRequestCopyWithImpl(this._self, this._then);

  final UpdateProfileRequest _self;
  final $Res Function(UpdateProfileRequest) _then;

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? email = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_self.copyWith(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UpdateProfileRequest implements UpdateProfileRequest {
  const _UpdateProfileRequest({this.name, this.email, this.avatar});
  factory _UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  @override
  final String? name;
  @override
  final String? email;
  @override
  final String? avatar;

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpdateProfileRequestCopyWith<_UpdateProfileRequest> get copyWith =>
      __$UpdateProfileRequestCopyWithImpl<_UpdateProfileRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UpdateProfileRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpdateProfileRequest &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, email, avatar);

  @override
  String toString() {
    return 'UpdateProfileRequest(name: $name, email: $email, avatar: $avatar)';
  }
}

/// @nodoc
abstract mixin class _$UpdateProfileRequestCopyWith<$Res>
    implements $UpdateProfileRequestCopyWith<$Res> {
  factory _$UpdateProfileRequestCopyWith(_UpdateProfileRequest value,
          $Res Function(_UpdateProfileRequest) _then) =
      __$UpdateProfileRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String? name, String? email, String? avatar});
}

/// @nodoc
class __$UpdateProfileRequestCopyWithImpl<$Res>
    implements _$UpdateProfileRequestCopyWith<$Res> {
  __$UpdateProfileRequestCopyWithImpl(this._self, this._then);

  final _UpdateProfileRequest _self;
  final $Res Function(_UpdateProfileRequest) _then;

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = freezed,
    Object? email = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_UpdateProfileRequest(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$AuthState {
  AuthStatus get status;
  User? get user;
  AuthTokens? get tokens;
  String? get errorMessage;
  bool get isLoading;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthStateCopyWith<AuthState> get copyWith =>
      _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);

  /// Serializes this AuthState to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.tokens, tokens) || other.tokens == tokens) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, status, user, tokens, errorMessage, isLoading);

  @override
  String toString() {
    return 'AuthState(status: $status, user: $user, tokens: $tokens, errorMessage: $errorMessage, isLoading: $isLoading)';
  }
}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) =
      _$AuthStateCopyWithImpl;
  @useResult
  $Res call(
      {AuthStatus status,
      User? user,
      AuthTokens? tokens,
      String? errorMessage,
      bool isLoading});

  $UserCopyWith<$Res>? get user;
  $AuthTokensCopyWith<$Res>? get tokens;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? user = freezed,
    Object? tokens = freezed,
    Object? errorMessage = freezed,
    Object? isLoading = null,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthStatus,
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      tokens: freezed == tokens
          ? _self.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as AuthTokens?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_self.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_self.user!, (value) {
      return _then(_self.copyWith(user: value));
    });
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthTokensCopyWith<$Res>? get tokens {
    if (_self.tokens == null) {
      return null;
    }

    return $AuthTokensCopyWith<$Res>(_self.tokens!, (value) {
      return _then(_self.copyWith(tokens: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _AuthState implements AuthState {
  const _AuthState(
      {this.status = AuthStatus.initial,
      this.user,
      this.tokens,
      this.errorMessage,
      this.isLoading = false});
  factory _AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);

  @override
  @JsonKey()
  final AuthStatus status;
  @override
  final User? user;
  @override
  final AuthTokens? tokens;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool isLoading;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthStateCopyWith<_AuthState> get copyWith =>
      __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AuthStateToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.tokens, tokens) || other.tokens == tokens) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, status, user, tokens, errorMessage, isLoading);

  @override
  String toString() {
    return 'AuthState(status: $status, user: $user, tokens: $tokens, errorMessage: $errorMessage, isLoading: $isLoading)';
  }
}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(
          _AuthState value, $Res Function(_AuthState) _then) =
      __$AuthStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {AuthStatus status,
      User? user,
      AuthTokens? tokens,
      String? errorMessage,
      bool isLoading});

  @override
  $UserCopyWith<$Res>? get user;
  @override
  $AuthTokensCopyWith<$Res>? get tokens;
}

/// @nodoc
class __$AuthStateCopyWithImpl<$Res> implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? user = freezed,
    Object? tokens = freezed,
    Object? errorMessage = freezed,
    Object? isLoading = null,
  }) {
    return _then(_AuthState(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthStatus,
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      tokens: freezed == tokens
          ? _self.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as AuthTokens?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_self.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_self.user!, (value) {
      return _then(_self.copyWith(user: value));
    });
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthTokensCopyWith<$Res>? get tokens {
    if (_self.tokens == null) {
      return null;
    }

    return $AuthTokensCopyWith<$Res>(_self.tokens!, (value) {
      return _then(_self.copyWith(tokens: value));
    });
  }
}

// dart format on
