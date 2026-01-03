// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QualityRatings _$QualityRatingsFromJson(Map<String, dynamic> json) {
  return _QualityRatings.fromJson(json);
}

/// @nodoc
mixin _$QualityRatings {
  int? get punctuality => throw _privateConstructorUsedError;
  int? get professionalism => throw _privateConstructorUsedError;
  int? get quality => throw _privateConstructorUsedError;
  int? get cleanliness => throw _privateConstructorUsedError;
  int? get communication => throw _privateConstructorUsedError;

  /// Serializes this QualityRatings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QualityRatings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QualityRatingsCopyWith<QualityRatings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QualityRatingsCopyWith<$Res> {
  factory $QualityRatingsCopyWith(
          QualityRatings value, $Res Function(QualityRatings) then) =
      _$QualityRatingsCopyWithImpl<$Res, QualityRatings>;
  @useResult
  $Res call(
      {int? punctuality,
      int? professionalism,
      int? quality,
      int? cleanliness,
      int? communication});
}

/// @nodoc
class _$QualityRatingsCopyWithImpl<$Res, $Val extends QualityRatings>
    implements $QualityRatingsCopyWith<$Res> {
  _$QualityRatingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QualityRatings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? punctuality = freezed,
    Object? professionalism = freezed,
    Object? quality = freezed,
    Object? cleanliness = freezed,
    Object? communication = freezed,
  }) {
    return _then(_value.copyWith(
      punctuality: freezed == punctuality
          ? _value.punctuality
          : punctuality // ignore: cast_nullable_to_non_nullable
              as int?,
      professionalism: freezed == professionalism
          ? _value.professionalism
          : professionalism // ignore: cast_nullable_to_non_nullable
              as int?,
      quality: freezed == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as int?,
      cleanliness: freezed == cleanliness
          ? _value.cleanliness
          : cleanliness // ignore: cast_nullable_to_non_nullable
              as int?,
      communication: freezed == communication
          ? _value.communication
          : communication // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QualityRatingsImplCopyWith<$Res>
    implements $QualityRatingsCopyWith<$Res> {
  factory _$$QualityRatingsImplCopyWith(_$QualityRatingsImpl value,
          $Res Function(_$QualityRatingsImpl) then) =
      __$$QualityRatingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? punctuality,
      int? professionalism,
      int? quality,
      int? cleanliness,
      int? communication});
}

/// @nodoc
class __$$QualityRatingsImplCopyWithImpl<$Res>
    extends _$QualityRatingsCopyWithImpl<$Res, _$QualityRatingsImpl>
    implements _$$QualityRatingsImplCopyWith<$Res> {
  __$$QualityRatingsImplCopyWithImpl(
      _$QualityRatingsImpl _value, $Res Function(_$QualityRatingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of QualityRatings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? punctuality = freezed,
    Object? professionalism = freezed,
    Object? quality = freezed,
    Object? cleanliness = freezed,
    Object? communication = freezed,
  }) {
    return _then(_$QualityRatingsImpl(
      punctuality: freezed == punctuality
          ? _value.punctuality
          : punctuality // ignore: cast_nullable_to_non_nullable
              as int?,
      professionalism: freezed == professionalism
          ? _value.professionalism
          : professionalism // ignore: cast_nullable_to_non_nullable
              as int?,
      quality: freezed == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as int?,
      cleanliness: freezed == cleanliness
          ? _value.cleanliness
          : cleanliness // ignore: cast_nullable_to_non_nullable
              as int?,
      communication: freezed == communication
          ? _value.communication
          : communication // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QualityRatingsImpl implements _QualityRatings {
  const _$QualityRatingsImpl(
      {this.punctuality,
      this.professionalism,
      this.quality,
      this.cleanliness,
      this.communication});

  factory _$QualityRatingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$QualityRatingsImplFromJson(json);

  @override
  final int? punctuality;
  @override
  final int? professionalism;
  @override
  final int? quality;
  @override
  final int? cleanliness;
  @override
  final int? communication;

  @override
  String toString() {
    return 'QualityRatings(punctuality: $punctuality, professionalism: $professionalism, quality: $quality, cleanliness: $cleanliness, communication: $communication)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QualityRatingsImpl &&
            (identical(other.punctuality, punctuality) ||
                other.punctuality == punctuality) &&
            (identical(other.professionalism, professionalism) ||
                other.professionalism == professionalism) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            (identical(other.cleanliness, cleanliness) ||
                other.cleanliness == cleanliness) &&
            (identical(other.communication, communication) ||
                other.communication == communication));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, punctuality, professionalism,
      quality, cleanliness, communication);

  /// Create a copy of QualityRatings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QualityRatingsImplCopyWith<_$QualityRatingsImpl> get copyWith =>
      __$$QualityRatingsImplCopyWithImpl<_$QualityRatingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QualityRatingsImplToJson(
      this,
    );
  }
}

abstract class _QualityRatings implements QualityRatings {
  const factory _QualityRatings(
      {final int? punctuality,
      final int? professionalism,
      final int? quality,
      final int? cleanliness,
      final int? communication}) = _$QualityRatingsImpl;

  factory _QualityRatings.fromJson(Map<String, dynamic> json) =
      _$QualityRatingsImpl.fromJson;

  @override
  int? get punctuality;
  @override
  int? get professionalism;
  @override
  int? get quality;
  @override
  int? get cleanliness;
  @override
  int? get communication;

  /// Create a copy of QualityRatings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QualityRatingsImplCopyWith<_$QualityRatingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReviewCustomer _$ReviewCustomerFromJson(Map<String, dynamic> json) {
  return _ReviewCustomer.fromJson(json);
}

/// @nodoc
mixin _$ReviewCustomer {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  ReviewCustomerUser? get userId => throw _privateConstructorUsedError;

  /// Serializes this ReviewCustomer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReviewCustomer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewCustomerCopyWith<ReviewCustomer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewCustomerCopyWith<$Res> {
  factory $ReviewCustomerCopyWith(
          ReviewCustomer value, $Res Function(ReviewCustomer) then) =
      _$ReviewCustomerCopyWithImpl<$Res, ReviewCustomer>;
  @useResult
  $Res call({@JsonKey(name: '_id') String id, ReviewCustomerUser? userId});

  $ReviewCustomerUserCopyWith<$Res>? get userId;
}

/// @nodoc
class _$ReviewCustomerCopyWithImpl<$Res, $Val extends ReviewCustomer>
    implements $ReviewCustomerCopyWith<$Res> {
  _$ReviewCustomerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewCustomer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as ReviewCustomerUser?,
    ) as $Val);
  }

  /// Create a copy of ReviewCustomer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReviewCustomerUserCopyWith<$Res>? get userId {
    if (_value.userId == null) {
      return null;
    }

    return $ReviewCustomerUserCopyWith<$Res>(_value.userId!, (value) {
      return _then(_value.copyWith(userId: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReviewCustomerImplCopyWith<$Res>
    implements $ReviewCustomerCopyWith<$Res> {
  factory _$$ReviewCustomerImplCopyWith(_$ReviewCustomerImpl value,
          $Res Function(_$ReviewCustomerImpl) then) =
      __$$ReviewCustomerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: '_id') String id, ReviewCustomerUser? userId});

  @override
  $ReviewCustomerUserCopyWith<$Res>? get userId;
}

/// @nodoc
class __$$ReviewCustomerImplCopyWithImpl<$Res>
    extends _$ReviewCustomerCopyWithImpl<$Res, _$ReviewCustomerImpl>
    implements _$$ReviewCustomerImplCopyWith<$Res> {
  __$$ReviewCustomerImplCopyWithImpl(
      _$ReviewCustomerImpl _value, $Res Function(_$ReviewCustomerImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewCustomer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
  }) {
    return _then(_$ReviewCustomerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as ReviewCustomerUser?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewCustomerImpl implements _ReviewCustomer {
  const _$ReviewCustomerImpl(
      {@JsonKey(name: '_id') required this.id, this.userId});

  factory _$ReviewCustomerImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewCustomerImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final ReviewCustomerUser? userId;

  @override
  String toString() {
    return 'ReviewCustomer(id: $id, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewCustomerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId);

  /// Create a copy of ReviewCustomer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewCustomerImplCopyWith<_$ReviewCustomerImpl> get copyWith =>
      __$$ReviewCustomerImplCopyWithImpl<_$ReviewCustomerImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewCustomerImplToJson(
      this,
    );
  }
}

abstract class _ReviewCustomer implements ReviewCustomer {
  const factory _ReviewCustomer(
      {@JsonKey(name: '_id') required final String id,
      final ReviewCustomerUser? userId}) = _$ReviewCustomerImpl;

  factory _ReviewCustomer.fromJson(Map<String, dynamic> json) =
      _$ReviewCustomerImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  ReviewCustomerUser? get userId;

  /// Create a copy of ReviewCustomer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewCustomerImplCopyWith<_$ReviewCustomerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReviewCustomerUser _$ReviewCustomerUserFromJson(Map<String, dynamic> json) {
  return _ReviewCustomerUser.fromJson(json);
}

/// @nodoc
mixin _$ReviewCustomerUser {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;

  /// Serializes this ReviewCustomerUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReviewCustomerUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewCustomerUserCopyWith<ReviewCustomerUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewCustomerUserCopyWith<$Res> {
  factory $ReviewCustomerUserCopyWith(
          ReviewCustomerUser value, $Res Function(ReviewCustomerUser) then) =
      _$ReviewCustomerUserCopyWithImpl<$Res, ReviewCustomerUser>;
  @useResult
  $Res call({@JsonKey(name: '_id') String id, String name, String? avatar});
}

/// @nodoc
class _$ReviewCustomerUserCopyWithImpl<$Res, $Val extends ReviewCustomerUser>
    implements $ReviewCustomerUserCopyWith<$Res> {
  _$ReviewCustomerUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewCustomerUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewCustomerUserImplCopyWith<$Res>
    implements $ReviewCustomerUserCopyWith<$Res> {
  factory _$$ReviewCustomerUserImplCopyWith(_$ReviewCustomerUserImpl value,
          $Res Function(_$ReviewCustomerUserImpl) then) =
      __$$ReviewCustomerUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: '_id') String id, String name, String? avatar});
}

/// @nodoc
class __$$ReviewCustomerUserImplCopyWithImpl<$Res>
    extends _$ReviewCustomerUserCopyWithImpl<$Res, _$ReviewCustomerUserImpl>
    implements _$$ReviewCustomerUserImplCopyWith<$Res> {
  __$$ReviewCustomerUserImplCopyWithImpl(_$ReviewCustomerUserImpl _value,
      $Res Function(_$ReviewCustomerUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewCustomerUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = freezed,
  }) {
    return _then(_$ReviewCustomerUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewCustomerUserImpl implements _ReviewCustomerUser {
  const _$ReviewCustomerUserImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.name,
      this.avatar});

  factory _$ReviewCustomerUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewCustomerUserImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String name;
  @override
  final String? avatar;

  @override
  String toString() {
    return 'ReviewCustomerUser(id: $id, name: $name, avatar: $avatar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewCustomerUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, avatar);

  /// Create a copy of ReviewCustomerUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewCustomerUserImplCopyWith<_$ReviewCustomerUserImpl> get copyWith =>
      __$$ReviewCustomerUserImplCopyWithImpl<_$ReviewCustomerUserImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewCustomerUserImplToJson(
      this,
    );
  }
}

abstract class _ReviewCustomerUser implements ReviewCustomerUser {
  const factory _ReviewCustomerUser(
      {@JsonKey(name: '_id') required final String id,
      required final String name,
      final String? avatar}) = _$ReviewCustomerUserImpl;

  factory _ReviewCustomerUser.fromJson(Map<String, dynamic> json) =
      _$ReviewCustomerUserImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;
  @override
  String? get avatar;

  /// Create a copy of ReviewCustomerUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewCustomerUserImplCopyWith<_$ReviewCustomerUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReviewRequest _$ReviewRequestFromJson(Map<String, dynamic> json) {
  return _ReviewRequest.fromJson(json);
}

/// @nodoc
mixin _$ReviewRequest {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get requestNumber => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  ReviewCategory? get category => throw _privateConstructorUsedError;

  /// Serializes this ReviewRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewRequestCopyWith<ReviewRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewRequestCopyWith<$Res> {
  factory $ReviewRequestCopyWith(
          ReviewRequest value, $Res Function(ReviewRequest) then) =
      _$ReviewRequestCopyWithImpl<$Res, ReviewRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String requestNumber,
      String title,
      ReviewCategory? category});

  $ReviewCategoryCopyWith<$Res>? get category;
}

/// @nodoc
class _$ReviewRequestCopyWithImpl<$Res, $Val extends ReviewRequest>
    implements $ReviewRequestCopyWith<$Res> {
  _$ReviewRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requestNumber = null,
    Object? title = null,
    Object? category = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      requestNumber: null == requestNumber
          ? _value.requestNumber
          : requestNumber // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ReviewCategory?,
    ) as $Val);
  }

  /// Create a copy of ReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReviewCategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $ReviewCategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReviewRequestImplCopyWith<$Res>
    implements $ReviewRequestCopyWith<$Res> {
  factory _$$ReviewRequestImplCopyWith(
          _$ReviewRequestImpl value, $Res Function(_$ReviewRequestImpl) then) =
      __$$ReviewRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String requestNumber,
      String title,
      ReviewCategory? category});

  @override
  $ReviewCategoryCopyWith<$Res>? get category;
}

/// @nodoc
class __$$ReviewRequestImplCopyWithImpl<$Res>
    extends _$ReviewRequestCopyWithImpl<$Res, _$ReviewRequestImpl>
    implements _$$ReviewRequestImplCopyWith<$Res> {
  __$$ReviewRequestImplCopyWithImpl(
      _$ReviewRequestImpl _value, $Res Function(_$ReviewRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requestNumber = null,
    Object? title = null,
    Object? category = freezed,
  }) {
    return _then(_$ReviewRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      requestNumber: null == requestNumber
          ? _value.requestNumber
          : requestNumber // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ReviewCategory?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewRequestImpl implements _ReviewRequest {
  const _$ReviewRequestImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.requestNumber,
      required this.title,
      this.category});

  factory _$ReviewRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewRequestImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String requestNumber;
  @override
  final String title;
  @override
  final ReviewCategory? category;

  @override
  String toString() {
    return 'ReviewRequest(id: $id, requestNumber: $requestNumber, title: $title, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.requestNumber, requestNumber) ||
                other.requestNumber == requestNumber) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, requestNumber, title, category);

  /// Create a copy of ReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewRequestImplCopyWith<_$ReviewRequestImpl> get copyWith =>
      __$$ReviewRequestImplCopyWithImpl<_$ReviewRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewRequestImplToJson(
      this,
    );
  }
}

abstract class _ReviewRequest implements ReviewRequest {
  const factory _ReviewRequest(
      {@JsonKey(name: '_id') required final String id,
      required final String requestNumber,
      required final String title,
      final ReviewCategory? category}) = _$ReviewRequestImpl;

  factory _ReviewRequest.fromJson(Map<String, dynamic> json) =
      _$ReviewRequestImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get requestNumber;
  @override
  String get title;
  @override
  ReviewCategory? get category;

  /// Create a copy of ReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewRequestImplCopyWith<_$ReviewRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReviewCategory _$ReviewCategoryFromJson(Map<String, dynamic> json) {
  return _ReviewCategory.fromJson(json);
}

/// @nodoc
mixin _$ReviewCategory {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get nameAr => throw _privateConstructorUsedError;

  /// Serializes this ReviewCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReviewCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewCategoryCopyWith<ReviewCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewCategoryCopyWith<$Res> {
  factory $ReviewCategoryCopyWith(
          ReviewCategory value, $Res Function(ReviewCategory) then) =
      _$ReviewCategoryCopyWithImpl<$Res, ReviewCategory>;
  @useResult
  $Res call({@JsonKey(name: '_id') String id, String nameAr});
}

/// @nodoc
class _$ReviewCategoryCopyWithImpl<$Res, $Val extends ReviewCategory>
    implements $ReviewCategoryCopyWith<$Res> {
  _$ReviewCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameAr = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nameAr: null == nameAr
          ? _value.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewCategoryImplCopyWith<$Res>
    implements $ReviewCategoryCopyWith<$Res> {
  factory _$$ReviewCategoryImplCopyWith(_$ReviewCategoryImpl value,
          $Res Function(_$ReviewCategoryImpl) then) =
      __$$ReviewCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: '_id') String id, String nameAr});
}

/// @nodoc
class __$$ReviewCategoryImplCopyWithImpl<$Res>
    extends _$ReviewCategoryCopyWithImpl<$Res, _$ReviewCategoryImpl>
    implements _$$ReviewCategoryImplCopyWith<$Res> {
  __$$ReviewCategoryImplCopyWithImpl(
      _$ReviewCategoryImpl _value, $Res Function(_$ReviewCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameAr = null,
  }) {
    return _then(_$ReviewCategoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nameAr: null == nameAr
          ? _value.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewCategoryImpl implements _ReviewCategory {
  const _$ReviewCategoryImpl(
      {@JsonKey(name: '_id') required this.id, required this.nameAr});

  factory _$ReviewCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewCategoryImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String nameAr;

  @override
  String toString() {
    return 'ReviewCategory(id: $id, nameAr: $nameAr)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, nameAr);

  /// Create a copy of ReviewCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewCategoryImplCopyWith<_$ReviewCategoryImpl> get copyWith =>
      __$$ReviewCategoryImplCopyWithImpl<_$ReviewCategoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewCategoryImplToJson(
      this,
    );
  }
}

abstract class _ReviewCategory implements ReviewCategory {
  const factory _ReviewCategory(
      {@JsonKey(name: '_id') required final String id,
      required final String nameAr}) = _$ReviewCategoryImpl;

  factory _ReviewCategory.fromJson(Map<String, dynamic> json) =
      _$ReviewCategoryImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get nameAr;

  /// Create a copy of ReviewCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewCategoryImplCopyWith<_$ReviewCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return _Review.fromJson(json);
}

/// @nodoc
mixin _$Review {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get requestId => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  String get craftsmanId => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  QualityRatings get qualities => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  String? get craftsmanResponse => throw _privateConstructorUsedError;
  DateTime? get respondedAt => throw _privateConstructorUsedError;
  bool get isVisible => throw _privateConstructorUsedError;
  bool get isReported => throw _privateConstructorUsedError;
  String? get reportReason => throw _privateConstructorUsedError;
  ReviewCustomer? get customer => throw _privateConstructorUsedError;
  ReviewRequest? get request => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Review to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewCopyWith<Review> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewCopyWith<$Res> {
  factory $ReviewCopyWith(Review value, $Res Function(Review) then) =
      _$ReviewCopyWithImpl<$Res, Review>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String requestId,
      String customerId,
      String craftsmanId,
      int score,
      String? comment,
      QualityRatings qualities,
      List<String> images,
      String? craftsmanResponse,
      DateTime? respondedAt,
      bool isVisible,
      bool isReported,
      String? reportReason,
      ReviewCustomer? customer,
      ReviewRequest? request,
      DateTime createdAt,
      DateTime updatedAt});

  $QualityRatingsCopyWith<$Res> get qualities;
  $ReviewCustomerCopyWith<$Res>? get customer;
  $ReviewRequestCopyWith<$Res>? get request;
}

/// @nodoc
class _$ReviewCopyWithImpl<$Res, $Val extends Review>
    implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requestId = null,
    Object? customerId = null,
    Object? craftsmanId = null,
    Object? score = null,
    Object? comment = freezed,
    Object? qualities = null,
    Object? images = null,
    Object? craftsmanResponse = freezed,
    Object? respondedAt = freezed,
    Object? isVisible = null,
    Object? isReported = null,
    Object? reportReason = freezed,
    Object? customer = freezed,
    Object? request = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      craftsmanId: null == craftsmanId
          ? _value.craftsmanId
          : craftsmanId // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      qualities: null == qualities
          ? _value.qualities
          : qualities // ignore: cast_nullable_to_non_nullable
              as QualityRatings,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      craftsmanResponse: freezed == craftsmanResponse
          ? _value.craftsmanResponse
          : craftsmanResponse // ignore: cast_nullable_to_non_nullable
              as String?,
      respondedAt: freezed == respondedAt
          ? _value.respondedAt
          : respondedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      isReported: null == isReported
          ? _value.isReported
          : isReported // ignore: cast_nullable_to_non_nullable
              as bool,
      reportReason: freezed == reportReason
          ? _value.reportReason
          : reportReason // ignore: cast_nullable_to_non_nullable
              as String?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as ReviewCustomer?,
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as ReviewRequest?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QualityRatingsCopyWith<$Res> get qualities {
    return $QualityRatingsCopyWith<$Res>(_value.qualities, (value) {
      return _then(_value.copyWith(qualities: value) as $Val);
    });
  }

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReviewCustomerCopyWith<$Res>? get customer {
    if (_value.customer == null) {
      return null;
    }

    return $ReviewCustomerCopyWith<$Res>(_value.customer!, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReviewRequestCopyWith<$Res>? get request {
    if (_value.request == null) {
      return null;
    }

    return $ReviewRequestCopyWith<$Res>(_value.request!, (value) {
      return _then(_value.copyWith(request: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReviewImplCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$$ReviewImplCopyWith(
          _$ReviewImpl value, $Res Function(_$ReviewImpl) then) =
      __$$ReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String requestId,
      String customerId,
      String craftsmanId,
      int score,
      String? comment,
      QualityRatings qualities,
      List<String> images,
      String? craftsmanResponse,
      DateTime? respondedAt,
      bool isVisible,
      bool isReported,
      String? reportReason,
      ReviewCustomer? customer,
      ReviewRequest? request,
      DateTime createdAt,
      DateTime updatedAt});

  @override
  $QualityRatingsCopyWith<$Res> get qualities;
  @override
  $ReviewCustomerCopyWith<$Res>? get customer;
  @override
  $ReviewRequestCopyWith<$Res>? get request;
}

/// @nodoc
class __$$ReviewImplCopyWithImpl<$Res>
    extends _$ReviewCopyWithImpl<$Res, _$ReviewImpl>
    implements _$$ReviewImplCopyWith<$Res> {
  __$$ReviewImplCopyWithImpl(
      _$ReviewImpl _value, $Res Function(_$ReviewImpl) _then)
      : super(_value, _then);

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requestId = null,
    Object? customerId = null,
    Object? craftsmanId = null,
    Object? score = null,
    Object? comment = freezed,
    Object? qualities = null,
    Object? images = null,
    Object? craftsmanResponse = freezed,
    Object? respondedAt = freezed,
    Object? isVisible = null,
    Object? isReported = null,
    Object? reportReason = freezed,
    Object? customer = freezed,
    Object? request = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ReviewImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      craftsmanId: null == craftsmanId
          ? _value.craftsmanId
          : craftsmanId // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      qualities: null == qualities
          ? _value.qualities
          : qualities // ignore: cast_nullable_to_non_nullable
              as QualityRatings,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      craftsmanResponse: freezed == craftsmanResponse
          ? _value.craftsmanResponse
          : craftsmanResponse // ignore: cast_nullable_to_non_nullable
              as String?,
      respondedAt: freezed == respondedAt
          ? _value.respondedAt
          : respondedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      isReported: null == isReported
          ? _value.isReported
          : isReported // ignore: cast_nullable_to_non_nullable
              as bool,
      reportReason: freezed == reportReason
          ? _value.reportReason
          : reportReason // ignore: cast_nullable_to_non_nullable
              as String?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as ReviewCustomer?,
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as ReviewRequest?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewImpl extends _Review {
  const _$ReviewImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.requestId,
      required this.customerId,
      required this.craftsmanId,
      required this.score,
      this.comment,
      this.qualities = const QualityRatings(),
      final List<String> images = const [],
      this.craftsmanResponse,
      this.respondedAt,
      this.isVisible = true,
      this.isReported = false,
      this.reportReason,
      this.customer,
      this.request,
      required this.createdAt,
      required this.updatedAt})
      : _images = images,
        super._();

  factory _$ReviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String requestId;
  @override
  final String customerId;
  @override
  final String craftsmanId;
  @override
  final int score;
  @override
  final String? comment;
  @override
  @JsonKey()
  final QualityRatings qualities;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final String? craftsmanResponse;
  @override
  final DateTime? respondedAt;
  @override
  @JsonKey()
  final bool isVisible;
  @override
  @JsonKey()
  final bool isReported;
  @override
  final String? reportReason;
  @override
  final ReviewCustomer? customer;
  @override
  final ReviewRequest? request;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Review(id: $id, requestId: $requestId, customerId: $customerId, craftsmanId: $craftsmanId, score: $score, comment: $comment, qualities: $qualities, images: $images, craftsmanResponse: $craftsmanResponse, respondedAt: $respondedAt, isVisible: $isVisible, isReported: $isReported, reportReason: $reportReason, customer: $customer, request: $request, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.craftsmanId, craftsmanId) ||
                other.craftsmanId == craftsmanId) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.qualities, qualities) ||
                other.qualities == qualities) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.craftsmanResponse, craftsmanResponse) ||
                other.craftsmanResponse == craftsmanResponse) &&
            (identical(other.respondedAt, respondedAt) ||
                other.respondedAt == respondedAt) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible) &&
            (identical(other.isReported, isReported) ||
                other.isReported == isReported) &&
            (identical(other.reportReason, reportReason) ||
                other.reportReason == reportReason) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.request, request) || other.request == request) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      requestId,
      customerId,
      craftsmanId,
      score,
      comment,
      qualities,
      const DeepCollectionEquality().hash(_images),
      craftsmanResponse,
      respondedAt,
      isVisible,
      isReported,
      reportReason,
      customer,
      request,
      createdAt,
      updatedAt);

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
      __$$ReviewImplCopyWithImpl<_$ReviewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewImplToJson(
      this,
    );
  }
}

abstract class _Review extends Review {
  const factory _Review(
      {@JsonKey(name: '_id') required final String id,
      required final String requestId,
      required final String customerId,
      required final String craftsmanId,
      required final int score,
      final String? comment,
      final QualityRatings qualities,
      final List<String> images,
      final String? craftsmanResponse,
      final DateTime? respondedAt,
      final bool isVisible,
      final bool isReported,
      final String? reportReason,
      final ReviewCustomer? customer,
      final ReviewRequest? request,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$ReviewImpl;
  const _Review._() : super._();

  factory _Review.fromJson(Map<String, dynamic> json) = _$ReviewImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get requestId;
  @override
  String get customerId;
  @override
  String get craftsmanId;
  @override
  int get score;
  @override
  String? get comment;
  @override
  QualityRatings get qualities;
  @override
  List<String> get images;
  @override
  String? get craftsmanResponse;
  @override
  DateTime? get respondedAt;
  @override
  bool get isVisible;
  @override
  bool get isReported;
  @override
  String? get reportReason;
  @override
  ReviewCustomer? get customer;
  @override
  ReviewRequest? get request;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReviewsSummary _$ReviewsSummaryFromJson(Map<String, dynamic> json) {
  return _ReviewsSummary.fromJson(json);
}

/// @nodoc
mixin _$ReviewsSummary {
  double get averageRating => throw _privateConstructorUsedError;
  int get totalReviews => throw _privateConstructorUsedError;
  Map<String, int> get ratingDistribution => throw _privateConstructorUsedError;
  Map<String, double> get qualityAverages => throw _privateConstructorUsedError;

  /// Serializes this ReviewsSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReviewsSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewsSummaryCopyWith<ReviewsSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewsSummaryCopyWith<$Res> {
  factory $ReviewsSummaryCopyWith(
          ReviewsSummary value, $Res Function(ReviewsSummary) then) =
      _$ReviewsSummaryCopyWithImpl<$Res, ReviewsSummary>;
  @useResult
  $Res call(
      {double averageRating,
      int totalReviews,
      Map<String, int> ratingDistribution,
      Map<String, double> qualityAverages});
}

/// @nodoc
class _$ReviewsSummaryCopyWithImpl<$Res, $Val extends ReviewsSummary>
    implements $ReviewsSummaryCopyWith<$Res> {
  _$ReviewsSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewsSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageRating = null,
    Object? totalReviews = null,
    Object? ratingDistribution = null,
    Object? qualityAverages = null,
  }) {
    return _then(_value.copyWith(
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      totalReviews: null == totalReviews
          ? _value.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
      ratingDistribution: null == ratingDistribution
          ? _value.ratingDistribution
          : ratingDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      qualityAverages: null == qualityAverages
          ? _value.qualityAverages
          : qualityAverages // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewsSummaryImplCopyWith<$Res>
    implements $ReviewsSummaryCopyWith<$Res> {
  factory _$$ReviewsSummaryImplCopyWith(_$ReviewsSummaryImpl value,
          $Res Function(_$ReviewsSummaryImpl) then) =
      __$$ReviewsSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double averageRating,
      int totalReviews,
      Map<String, int> ratingDistribution,
      Map<String, double> qualityAverages});
}

/// @nodoc
class __$$ReviewsSummaryImplCopyWithImpl<$Res>
    extends _$ReviewsSummaryCopyWithImpl<$Res, _$ReviewsSummaryImpl>
    implements _$$ReviewsSummaryImplCopyWith<$Res> {
  __$$ReviewsSummaryImplCopyWithImpl(
      _$ReviewsSummaryImpl _value, $Res Function(_$ReviewsSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewsSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageRating = null,
    Object? totalReviews = null,
    Object? ratingDistribution = null,
    Object? qualityAverages = null,
  }) {
    return _then(_$ReviewsSummaryImpl(
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      totalReviews: null == totalReviews
          ? _value.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
      ratingDistribution: null == ratingDistribution
          ? _value._ratingDistribution
          : ratingDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      qualityAverages: null == qualityAverages
          ? _value._qualityAverages
          : qualityAverages // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewsSummaryImpl implements _ReviewsSummary {
  const _$ReviewsSummaryImpl(
      {this.averageRating = 0,
      this.totalReviews = 0,
      final Map<String, int> ratingDistribution = const {},
      final Map<String, double> qualityAverages = const {}})
      : _ratingDistribution = ratingDistribution,
        _qualityAverages = qualityAverages;

  factory _$ReviewsSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewsSummaryImplFromJson(json);

  @override
  @JsonKey()
  final double averageRating;
  @override
  @JsonKey()
  final int totalReviews;
  final Map<String, int> _ratingDistribution;
  @override
  @JsonKey()
  Map<String, int> get ratingDistribution {
    if (_ratingDistribution is EqualUnmodifiableMapView)
      return _ratingDistribution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_ratingDistribution);
  }

  final Map<String, double> _qualityAverages;
  @override
  @JsonKey()
  Map<String, double> get qualityAverages {
    if (_qualityAverages is EqualUnmodifiableMapView) return _qualityAverages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_qualityAverages);
  }

  @override
  String toString() {
    return 'ReviewsSummary(averageRating: $averageRating, totalReviews: $totalReviews, ratingDistribution: $ratingDistribution, qualityAverages: $qualityAverages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewsSummaryImpl &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.totalReviews, totalReviews) ||
                other.totalReviews == totalReviews) &&
            const DeepCollectionEquality()
                .equals(other._ratingDistribution, _ratingDistribution) &&
            const DeepCollectionEquality()
                .equals(other._qualityAverages, _qualityAverages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      averageRating,
      totalReviews,
      const DeepCollectionEquality().hash(_ratingDistribution),
      const DeepCollectionEquality().hash(_qualityAverages));

  /// Create a copy of ReviewsSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewsSummaryImplCopyWith<_$ReviewsSummaryImpl> get copyWith =>
      __$$ReviewsSummaryImplCopyWithImpl<_$ReviewsSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewsSummaryImplToJson(
      this,
    );
  }
}

abstract class _ReviewsSummary implements ReviewsSummary {
  const factory _ReviewsSummary(
      {final double averageRating,
      final int totalReviews,
      final Map<String, int> ratingDistribution,
      final Map<String, double> qualityAverages}) = _$ReviewsSummaryImpl;

  factory _ReviewsSummary.fromJson(Map<String, dynamic> json) =
      _$ReviewsSummaryImpl.fromJson;

  @override
  double get averageRating;
  @override
  int get totalReviews;
  @override
  Map<String, int> get ratingDistribution;
  @override
  Map<String, double> get qualityAverages;

  /// Create a copy of ReviewsSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewsSummaryImplCopyWith<_$ReviewsSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateReviewData _$CreateReviewDataFromJson(Map<String, dynamic> json) {
  return _CreateReviewData.fromJson(json);
}

/// @nodoc
mixin _$CreateReviewData {
  String get requestId => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  QualityRatings? get qualities => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;

  /// Serializes this CreateReviewData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateReviewData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateReviewDataCopyWith<CreateReviewData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateReviewDataCopyWith<$Res> {
  factory $CreateReviewDataCopyWith(
          CreateReviewData value, $Res Function(CreateReviewData) then) =
      _$CreateReviewDataCopyWithImpl<$Res, CreateReviewData>;
  @useResult
  $Res call(
      {String requestId,
      int score,
      String? comment,
      QualityRatings? qualities,
      List<String> images});

  $QualityRatingsCopyWith<$Res>? get qualities;
}

/// @nodoc
class _$CreateReviewDataCopyWithImpl<$Res, $Val extends CreateReviewData>
    implements $CreateReviewDataCopyWith<$Res> {
  _$CreateReviewDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateReviewData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestId = null,
    Object? score = null,
    Object? comment = freezed,
    Object? qualities = freezed,
    Object? images = null,
  }) {
    return _then(_value.copyWith(
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      qualities: freezed == qualities
          ? _value.qualities
          : qualities // ignore: cast_nullable_to_non_nullable
              as QualityRatings?,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  /// Create a copy of CreateReviewData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QualityRatingsCopyWith<$Res>? get qualities {
    if (_value.qualities == null) {
      return null;
    }

    return $QualityRatingsCopyWith<$Res>(_value.qualities!, (value) {
      return _then(_value.copyWith(qualities: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreateReviewDataImplCopyWith<$Res>
    implements $CreateReviewDataCopyWith<$Res> {
  factory _$$CreateReviewDataImplCopyWith(_$CreateReviewDataImpl value,
          $Res Function(_$CreateReviewDataImpl) then) =
      __$$CreateReviewDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String requestId,
      int score,
      String? comment,
      QualityRatings? qualities,
      List<String> images});

  @override
  $QualityRatingsCopyWith<$Res>? get qualities;
}

/// @nodoc
class __$$CreateReviewDataImplCopyWithImpl<$Res>
    extends _$CreateReviewDataCopyWithImpl<$Res, _$CreateReviewDataImpl>
    implements _$$CreateReviewDataImplCopyWith<$Res> {
  __$$CreateReviewDataImplCopyWithImpl(_$CreateReviewDataImpl _value,
      $Res Function(_$CreateReviewDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateReviewData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestId = null,
    Object? score = null,
    Object? comment = freezed,
    Object? qualities = freezed,
    Object? images = null,
  }) {
    return _then(_$CreateReviewDataImpl(
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      qualities: freezed == qualities
          ? _value.qualities
          : qualities // ignore: cast_nullable_to_non_nullable
              as QualityRatings?,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateReviewDataImpl implements _CreateReviewData {
  const _$CreateReviewDataImpl(
      {required this.requestId,
      required this.score,
      this.comment,
      this.qualities,
      final List<String> images = const []})
      : _images = images;

  factory _$CreateReviewDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateReviewDataImplFromJson(json);

  @override
  final String requestId;
  @override
  final int score;
  @override
  final String? comment;
  @override
  final QualityRatings? qualities;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  String toString() {
    return 'CreateReviewData(requestId: $requestId, score: $score, comment: $comment, qualities: $qualities, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateReviewDataImpl &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.qualities, qualities) ||
                other.qualities == qualities) &&
            const DeepCollectionEquality().equals(other._images, _images));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, requestId, score, comment,
      qualities, const DeepCollectionEquality().hash(_images));

  /// Create a copy of CreateReviewData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateReviewDataImplCopyWith<_$CreateReviewDataImpl> get copyWith =>
      __$$CreateReviewDataImplCopyWithImpl<_$CreateReviewDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateReviewDataImplToJson(
      this,
    );
  }
}

abstract class _CreateReviewData implements CreateReviewData {
  const factory _CreateReviewData(
      {required final String requestId,
      required final int score,
      final String? comment,
      final QualityRatings? qualities,
      final List<String> images}) = _$CreateReviewDataImpl;

  factory _CreateReviewData.fromJson(Map<String, dynamic> json) =
      _$CreateReviewDataImpl.fromJson;

  @override
  String get requestId;
  @override
  int get score;
  @override
  String? get comment;
  @override
  QualityRatings? get qualities;
  @override
  List<String> get images;

  /// Create a copy of CreateReviewData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateReviewDataImplCopyWith<_$CreateReviewDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReviewListResponse _$ReviewListResponseFromJson(Map<String, dynamic> json) {
  return _ReviewListResponse.fromJson(json);
}

/// @nodoc
mixin _$ReviewListResponse {
  List<Review> get data => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;

  /// Serializes this ReviewListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReviewListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewListResponseCopyWith<ReviewListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewListResponseCopyWith<$Res> {
  factory $ReviewListResponseCopyWith(
          ReviewListResponse value, $Res Function(ReviewListResponse) then) =
      _$ReviewListResponseCopyWithImpl<$Res, ReviewListResponse>;
  @useResult
  $Res call(
      {List<Review> data, int page, int totalPages, int total, int limit});
}

/// @nodoc
class _$ReviewListResponseCopyWithImpl<$Res, $Val extends ReviewListResponse>
    implements $ReviewListResponseCopyWith<$Res> {
  _$ReviewListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? page = null,
    Object? totalPages = null,
    Object? total = null,
    Object? limit = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Review>,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewListResponseImplCopyWith<$Res>
    implements $ReviewListResponseCopyWith<$Res> {
  factory _$$ReviewListResponseImplCopyWith(_$ReviewListResponseImpl value,
          $Res Function(_$ReviewListResponseImpl) then) =
      __$$ReviewListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Review> data, int page, int totalPages, int total, int limit});
}

/// @nodoc
class __$$ReviewListResponseImplCopyWithImpl<$Res>
    extends _$ReviewListResponseCopyWithImpl<$Res, _$ReviewListResponseImpl>
    implements _$$ReviewListResponseImplCopyWith<$Res> {
  __$$ReviewListResponseImplCopyWithImpl(_$ReviewListResponseImpl _value,
      $Res Function(_$ReviewListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? page = null,
    Object? totalPages = null,
    Object? total = null,
    Object? limit = null,
  }) {
    return _then(_$ReviewListResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Review>,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewListResponseImpl implements _ReviewListResponse {
  const _$ReviewListResponseImpl(
      {required final List<Review> data,
      required this.page,
      required this.totalPages,
      required this.total,
      required this.limit})
      : _data = data;

  factory _$ReviewListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewListResponseImplFromJson(json);

  final List<Review> _data;
  @override
  List<Review> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final int page;
  @override
  final int totalPages;
  @override
  final int total;
  @override
  final int limit;

  @override
  String toString() {
    return 'ReviewListResponse(data: $data, page: $page, totalPages: $totalPages, total: $total, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewListResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_data),
      page,
      totalPages,
      total,
      limit);

  /// Create a copy of ReviewListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewListResponseImplCopyWith<_$ReviewListResponseImpl> get copyWith =>
      __$$ReviewListResponseImplCopyWithImpl<_$ReviewListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewListResponseImplToJson(
      this,
    );
  }
}

abstract class _ReviewListResponse implements ReviewListResponse {
  const factory _ReviewListResponse(
      {required final List<Review> data,
      required final int page,
      required final int totalPages,
      required final int total,
      required final int limit}) = _$ReviewListResponseImpl;

  factory _ReviewListResponse.fromJson(Map<String, dynamic> json) =
      _$ReviewListResponseImpl.fromJson;

  @override
  List<Review> get data;
  @override
  int get page;
  @override
  int get totalPages;
  @override
  int get total;
  @override
  int get limit;

  /// Create a copy of ReviewListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewListResponseImplCopyWith<_$ReviewListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
