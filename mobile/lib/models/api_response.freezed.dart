// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApiResponse<T> {
  bool get success;
  String? get message;
  T? get data;
  List<ApiError>? get errors;
  PaginationMeta? get meta;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApiResponseCopyWith<T, ApiResponse<T>> get copyWith =>
      _$ApiResponseCopyWithImpl<T, ApiResponse<T>>(
          this as ApiResponse<T>, _$identity);

  /// Serializes this ApiResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApiResponse<T> &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other.errors, errors) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      message,
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(errors),
      meta);

  @override
  String toString() {
    return 'ApiResponse<$T>(success: $success, message: $message, data: $data, errors: $errors, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class $ApiResponseCopyWith<T, $Res> {
  factory $ApiResponseCopyWith(
          ApiResponse<T> value, $Res Function(ApiResponse<T>) _then) =
      _$ApiResponseCopyWithImpl;
  @useResult
  $Res call(
      {bool success,
      String? message,
      T? data,
      List<ApiError>? errors,
      PaginationMeta? meta});

  $PaginationMetaCopyWith<$Res>? get meta;
}

/// @nodoc
class _$ApiResponseCopyWithImpl<T, $Res>
    implements $ApiResponseCopyWith<T, $Res> {
  _$ApiResponseCopyWithImpl(this._self, this._then);

  final ApiResponse<T> _self;
  final $Res Function(ApiResponse<T>) _then;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = freezed,
    Object? errors = freezed,
    Object? meta = freezed,
  }) {
    return _then(_self.copyWith(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
      errors: freezed == errors
          ? _self.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<ApiError>?,
      meta: freezed == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as PaginationMeta?,
    ));
  }

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationMetaCopyWith<$Res>? get meta {
    if (_self.meta == null) {
      return null;
    }

    return $PaginationMetaCopyWith<$Res>(_self.meta!, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _ApiResponse<T> implements ApiResponse<T> {
  const _ApiResponse(
      {required this.success,
      this.message,
      this.data,
      final List<ApiError>? errors,
      this.meta})
      : _errors = errors;
  factory _ApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ApiResponseFromJson(json, fromJsonT);

  @override
  final bool success;
  @override
  final String? message;
  @override
  final T? data;
  final List<ApiError>? _errors;
  @override
  List<ApiError>? get errors {
    final value = _errors;
    if (value == null) return null;
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final PaginationMeta? meta;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ApiResponseCopyWith<T, _ApiResponse<T>> get copyWith =>
      __$ApiResponseCopyWithImpl<T, _ApiResponse<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$ApiResponseToJson<T>(this, toJsonT);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ApiResponse<T> &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      message,
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(_errors),
      meta);

  @override
  String toString() {
    return 'ApiResponse<$T>(success: $success, message: $message, data: $data, errors: $errors, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class _$ApiResponseCopyWith<T, $Res>
    implements $ApiResponseCopyWith<T, $Res> {
  factory _$ApiResponseCopyWith(
          _ApiResponse<T> value, $Res Function(_ApiResponse<T>) _then) =
      __$ApiResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool success,
      String? message,
      T? data,
      List<ApiError>? errors,
      PaginationMeta? meta});

  @override
  $PaginationMetaCopyWith<$Res>? get meta;
}

/// @nodoc
class __$ApiResponseCopyWithImpl<T, $Res>
    implements _$ApiResponseCopyWith<T, $Res> {
  __$ApiResponseCopyWithImpl(this._self, this._then);

  final _ApiResponse<T> _self;
  final $Res Function(_ApiResponse<T>) _then;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = freezed,
    Object? errors = freezed,
    Object? meta = freezed,
  }) {
    return _then(_ApiResponse<T>(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
      errors: freezed == errors
          ? _self._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<ApiError>?,
      meta: freezed == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as PaginationMeta?,
    ));
  }

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationMetaCopyWith<$Res>? get meta {
    if (_self.meta == null) {
      return null;
    }

    return $PaginationMetaCopyWith<$Res>(_self.meta!, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

/// @nodoc
mixin _$ApiError {
  String? get field;
  String get message;
  String? get code;

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApiErrorCopyWith<ApiError> get copyWith =>
      _$ApiErrorCopyWithImpl<ApiError>(this as ApiError, _$identity);

  /// Serializes this ApiError to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApiError &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, field, message, code);

  @override
  String toString() {
    return 'ApiError(field: $field, message: $message, code: $code)';
  }
}

/// @nodoc
abstract mixin class $ApiErrorCopyWith<$Res> {
  factory $ApiErrorCopyWith(ApiError value, $Res Function(ApiError) _then) =
      _$ApiErrorCopyWithImpl;
  @useResult
  $Res call({String? field, String message, String? code});
}

/// @nodoc
class _$ApiErrorCopyWithImpl<$Res> implements $ApiErrorCopyWith<$Res> {
  _$ApiErrorCopyWithImpl(this._self, this._then);

  final ApiError _self;
  final $Res Function(ApiError) _then;

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = freezed,
    Object? message = null,
    Object? code = freezed,
  }) {
    return _then(_self.copyWith(
      field: freezed == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as String?,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ApiError implements ApiError {
  const _ApiError({this.field, required this.message, this.code});
  factory _ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  @override
  final String? field;
  @override
  final String message;
  @override
  final String? code;

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ApiErrorCopyWith<_ApiError> get copyWith =>
      __$ApiErrorCopyWithImpl<_ApiError>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ApiErrorToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ApiError &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, field, message, code);

  @override
  String toString() {
    return 'ApiError(field: $field, message: $message, code: $code)';
  }
}

/// @nodoc
abstract mixin class _$ApiErrorCopyWith<$Res>
    implements $ApiErrorCopyWith<$Res> {
  factory _$ApiErrorCopyWith(_ApiError value, $Res Function(_ApiError) _then) =
      __$ApiErrorCopyWithImpl;
  @override
  @useResult
  $Res call({String? field, String message, String? code});
}

/// @nodoc
class __$ApiErrorCopyWithImpl<$Res> implements _$ApiErrorCopyWith<$Res> {
  __$ApiErrorCopyWithImpl(this._self, this._then);

  final _ApiError _self;
  final $Res Function(_ApiError) _then;

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field = freezed,
    Object? message = null,
    Object? code = freezed,
  }) {
    return _then(_ApiError(
      field: freezed == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as String?,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$PaginationMeta {
  int get page;
  int get limit;
  int get total;
  int get totalPages;

  /// Create a copy of PaginationMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaginationMetaCopyWith<PaginationMeta> get copyWith =>
      _$PaginationMetaCopyWithImpl<PaginationMeta>(
          this as PaginationMeta, _$identity);

  /// Serializes this PaginationMeta to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PaginationMeta &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, page, limit, total, totalPages);

  @override
  String toString() {
    return 'PaginationMeta(page: $page, limit: $limit, total: $total, totalPages: $totalPages)';
  }
}

/// @nodoc
abstract mixin class $PaginationMetaCopyWith<$Res> {
  factory $PaginationMetaCopyWith(
          PaginationMeta value, $Res Function(PaginationMeta) _then) =
      _$PaginationMetaCopyWithImpl;
  @useResult
  $Res call({int page, int limit, int total, int totalPages});
}

/// @nodoc
class _$PaginationMetaCopyWithImpl<$Res>
    implements $PaginationMetaCopyWith<$Res> {
  _$PaginationMetaCopyWithImpl(this._self, this._then);

  final PaginationMeta _self;
  final $Res Function(PaginationMeta) _then;

  /// Create a copy of PaginationMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? limit = null,
    Object? total = null,
    Object? totalPages = null,
  }) {
    return _then(_self.copyWith(
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _self.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PaginationMeta implements PaginationMeta {
  const _PaginationMeta(
      {required this.page,
      required this.limit,
      required this.total,
      required this.totalPages});
  factory _PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);

  @override
  final int page;
  @override
  final int limit;
  @override
  final int total;
  @override
  final int totalPages;

  /// Create a copy of PaginationMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PaginationMetaCopyWith<_PaginationMeta> get copyWith =>
      __$PaginationMetaCopyWithImpl<_PaginationMeta>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PaginationMetaToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PaginationMeta &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, page, limit, total, totalPages);

  @override
  String toString() {
    return 'PaginationMeta(page: $page, limit: $limit, total: $total, totalPages: $totalPages)';
  }
}

/// @nodoc
abstract mixin class _$PaginationMetaCopyWith<$Res>
    implements $PaginationMetaCopyWith<$Res> {
  factory _$PaginationMetaCopyWith(
          _PaginationMeta value, $Res Function(_PaginationMeta) _then) =
      __$PaginationMetaCopyWithImpl;
  @override
  @useResult
  $Res call({int page, int limit, int total, int totalPages});
}

/// @nodoc
class __$PaginationMetaCopyWithImpl<$Res>
    implements _$PaginationMetaCopyWith<$Res> {
  __$PaginationMetaCopyWithImpl(this._self, this._then);

  final _PaginationMeta _self;
  final $Res Function(_PaginationMeta) _then;

  /// Create a copy of PaginationMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? page = null,
    Object? limit = null,
    Object? total = null,
    Object? totalPages = null,
  }) {
    return _then(_PaginationMeta(
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _self.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
