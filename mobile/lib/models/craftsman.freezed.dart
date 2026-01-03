// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'craftsman.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServiceInfo _$ServiceInfoFromJson(Map<String, dynamic> json) {
  return _ServiceInfo.fromJson(json);
}

/// @nodoc
mixin _$ServiceInfo {
  String get categoryId => throw _privateConstructorUsedError;
  List<String> get subcategories => throw _privateConstructorUsedError;
  int get experience => throw _privateConstructorUsedError;
  PriceType get priceType => throw _privateConstructorUsedError;
  double? get basePrice => throw _privateConstructorUsedError;
  String? get description =>
      throw _privateConstructorUsedError; // Populated category details
  Map<String, dynamic>? get category => throw _privateConstructorUsedError;

  /// Serializes this ServiceInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceInfoCopyWith<ServiceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceInfoCopyWith<$Res> {
  factory $ServiceInfoCopyWith(
          ServiceInfo value, $Res Function(ServiceInfo) then) =
      _$ServiceInfoCopyWithImpl<$Res, ServiceInfo>;
  @useResult
  $Res call(
      {String categoryId,
      List<String> subcategories,
      int experience,
      PriceType priceType,
      double? basePrice,
      String? description,
      Map<String, dynamic>? category});
}

/// @nodoc
class _$ServiceInfoCopyWithImpl<$Res, $Val extends ServiceInfo>
    implements $ServiceInfoCopyWith<$Res> {
  _$ServiceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? subcategories = null,
    Object? experience = null,
    Object? priceType = null,
    Object? basePrice = freezed,
    Object? description = freezed,
    Object? category = freezed,
  }) {
    return _then(_value.copyWith(
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      subcategories: null == subcategories
          ? _value.subcategories
          : subcategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      experience: null == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int,
      priceType: null == priceType
          ? _value.priceType
          : priceType // ignore: cast_nullable_to_non_nullable
              as PriceType,
      basePrice: freezed == basePrice
          ? _value.basePrice
          : basePrice // ignore: cast_nullable_to_non_nullable
              as double?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceInfoImplCopyWith<$Res>
    implements $ServiceInfoCopyWith<$Res> {
  factory _$$ServiceInfoImplCopyWith(
          _$ServiceInfoImpl value, $Res Function(_$ServiceInfoImpl) then) =
      __$$ServiceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String categoryId,
      List<String> subcategories,
      int experience,
      PriceType priceType,
      double? basePrice,
      String? description,
      Map<String, dynamic>? category});
}

/// @nodoc
class __$$ServiceInfoImplCopyWithImpl<$Res>
    extends _$ServiceInfoCopyWithImpl<$Res, _$ServiceInfoImpl>
    implements _$$ServiceInfoImplCopyWith<$Res> {
  __$$ServiceInfoImplCopyWithImpl(
      _$ServiceInfoImpl _value, $Res Function(_$ServiceInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? subcategories = null,
    Object? experience = null,
    Object? priceType = null,
    Object? basePrice = freezed,
    Object? description = freezed,
    Object? category = freezed,
  }) {
    return _then(_$ServiceInfoImpl(
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      subcategories: null == subcategories
          ? _value._subcategories
          : subcategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      experience: null == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int,
      priceType: null == priceType
          ? _value.priceType
          : priceType // ignore: cast_nullable_to_non_nullable
              as PriceType,
      basePrice: freezed == basePrice
          ? _value.basePrice
          : basePrice // ignore: cast_nullable_to_non_nullable
              as double?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value._category
          : category // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceInfoImpl implements _ServiceInfo {
  const _$ServiceInfoImpl(
      {required this.categoryId,
      final List<String> subcategories = const [],
      this.experience = 0,
      this.priceType = PriceType.quote,
      this.basePrice,
      this.description,
      final Map<String, dynamic>? category})
      : _subcategories = subcategories,
        _category = category;

  factory _$ServiceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceInfoImplFromJson(json);

  @override
  final String categoryId;
  final List<String> _subcategories;
  @override
  @JsonKey()
  List<String> get subcategories {
    if (_subcategories is EqualUnmodifiableListView) return _subcategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subcategories);
  }

  @override
  @JsonKey()
  final int experience;
  @override
  @JsonKey()
  final PriceType priceType;
  @override
  final double? basePrice;
  @override
  final String? description;
// Populated category details
  final Map<String, dynamic>? _category;
// Populated category details
  @override
  Map<String, dynamic>? get category {
    final value = _category;
    if (value == null) return null;
    if (_category is EqualUnmodifiableMapView) return _category;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ServiceInfo(categoryId: $categoryId, subcategories: $subcategories, experience: $experience, priceType: $priceType, basePrice: $basePrice, description: $description, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceInfoImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            const DeepCollectionEquality()
                .equals(other._subcategories, _subcategories) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.priceType, priceType) ||
                other.priceType == priceType) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._category, _category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      categoryId,
      const DeepCollectionEquality().hash(_subcategories),
      experience,
      priceType,
      basePrice,
      description,
      const DeepCollectionEquality().hash(_category));

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceInfoImplCopyWith<_$ServiceInfoImpl> get copyWith =>
      __$$ServiceInfoImplCopyWithImpl<_$ServiceInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceInfoImplToJson(
      this,
    );
  }
}

abstract class _ServiceInfo implements ServiceInfo {
  const factory _ServiceInfo(
      {required final String categoryId,
      final List<String> subcategories,
      final int experience,
      final PriceType priceType,
      final double? basePrice,
      final String? description,
      final Map<String, dynamic>? category}) = _$ServiceInfoImpl;

  factory _ServiceInfo.fromJson(Map<String, dynamic> json) =
      _$ServiceInfoImpl.fromJson;

  @override
  String get categoryId;
  @override
  List<String> get subcategories;
  @override
  int get experience;
  @override
  PriceType get priceType;
  @override
  double? get basePrice;
  @override
  String? get description; // Populated category details
  @override
  Map<String, dynamic>? get category;

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceInfoImplCopyWith<_$ServiceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkingHour _$WorkingHourFromJson(Map<String, dynamic> json) {
  return _WorkingHour.fromJson(json);
}

/// @nodoc
mixin _$WorkingHour {
  int get day => throw _privateConstructorUsedError;
  bool get isWorking => throw _privateConstructorUsedError;
  String get start => throw _privateConstructorUsedError;
  String get end => throw _privateConstructorUsedError;

  /// Serializes this WorkingHour to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkingHour
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkingHourCopyWith<WorkingHour> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkingHourCopyWith<$Res> {
  factory $WorkingHourCopyWith(
          WorkingHour value, $Res Function(WorkingHour) then) =
      _$WorkingHourCopyWithImpl<$Res, WorkingHour>;
  @useResult
  $Res call({int day, bool isWorking, String start, String end});
}

/// @nodoc
class _$WorkingHourCopyWithImpl<$Res, $Val extends WorkingHour>
    implements $WorkingHourCopyWith<$Res> {
  _$WorkingHourCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkingHour
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? isWorking = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_value.copyWith(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      isWorking: null == isWorking
          ? _value.isWorking
          : isWorking // ignore: cast_nullable_to_non_nullable
              as bool,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkingHourImplCopyWith<$Res>
    implements $WorkingHourCopyWith<$Res> {
  factory _$$WorkingHourImplCopyWith(
          _$WorkingHourImpl value, $Res Function(_$WorkingHourImpl) then) =
      __$$WorkingHourImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int day, bool isWorking, String start, String end});
}

/// @nodoc
class __$$WorkingHourImplCopyWithImpl<$Res>
    extends _$WorkingHourCopyWithImpl<$Res, _$WorkingHourImpl>
    implements _$$WorkingHourImplCopyWith<$Res> {
  __$$WorkingHourImplCopyWithImpl(
      _$WorkingHourImpl _value, $Res Function(_$WorkingHourImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkingHour
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? isWorking = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_$WorkingHourImpl(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      isWorking: null == isWorking
          ? _value.isWorking
          : isWorking // ignore: cast_nullable_to_non_nullable
              as bool,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkingHourImpl implements _WorkingHour {
  const _$WorkingHourImpl(
      {required this.day,
      this.isWorking = true,
      this.start = '08:00',
      this.end = '20:00'});

  factory _$WorkingHourImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkingHourImplFromJson(json);

  @override
  final int day;
  @override
  @JsonKey()
  final bool isWorking;
  @override
  @JsonKey()
  final String start;
  @override
  @JsonKey()
  final String end;

  @override
  String toString() {
    return 'WorkingHour(day: $day, isWorking: $isWorking, start: $start, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkingHourImpl &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.isWorking, isWorking) ||
                other.isWorking == isWorking) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, day, isWorking, start, end);

  /// Create a copy of WorkingHour
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkingHourImplCopyWith<_$WorkingHourImpl> get copyWith =>
      __$$WorkingHourImplCopyWithImpl<_$WorkingHourImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkingHourImplToJson(
      this,
    );
  }
}

abstract class _WorkingHour implements WorkingHour {
  const factory _WorkingHour(
      {required final int day,
      final bool isWorking,
      final String start,
      final String end}) = _$WorkingHourImpl;

  factory _WorkingHour.fromJson(Map<String, dynamic> json) =
      _$WorkingHourImpl.fromJson;

  @override
  int get day;
  @override
  bool get isWorking;
  @override
  String get start;
  @override
  String get end;

  /// Create a copy of WorkingHour
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkingHourImplCopyWith<_$WorkingHourImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CraftsmanDocuments _$CraftsmanDocumentsFromJson(Map<String, dynamic> json) {
  return _CraftsmanDocuments.fromJson(json);
}

/// @nodoc
mixin _$CraftsmanDocuments {
  String? get nationalIdFront => throw _privateConstructorUsedError;
  String? get nationalIdBack => throw _privateConstructorUsedError;
  String? get nationalIdNumber => throw _privateConstructorUsedError;
  List<String> get certificates => throw _privateConstructorUsedError;
  String? get commercialRegister => throw _privateConstructorUsedError;

  /// Serializes this CraftsmanDocuments to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CraftsmanDocuments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CraftsmanDocumentsCopyWith<CraftsmanDocuments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CraftsmanDocumentsCopyWith<$Res> {
  factory $CraftsmanDocumentsCopyWith(
          CraftsmanDocuments value, $Res Function(CraftsmanDocuments) then) =
      _$CraftsmanDocumentsCopyWithImpl<$Res, CraftsmanDocuments>;
  @useResult
  $Res call(
      {String? nationalIdFront,
      String? nationalIdBack,
      String? nationalIdNumber,
      List<String> certificates,
      String? commercialRegister});
}

/// @nodoc
class _$CraftsmanDocumentsCopyWithImpl<$Res, $Val extends CraftsmanDocuments>
    implements $CraftsmanDocumentsCopyWith<$Res> {
  _$CraftsmanDocumentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CraftsmanDocuments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nationalIdFront = freezed,
    Object? nationalIdBack = freezed,
    Object? nationalIdNumber = freezed,
    Object? certificates = null,
    Object? commercialRegister = freezed,
  }) {
    return _then(_value.copyWith(
      nationalIdFront: freezed == nationalIdFront
          ? _value.nationalIdFront
          : nationalIdFront // ignore: cast_nullable_to_non_nullable
              as String?,
      nationalIdBack: freezed == nationalIdBack
          ? _value.nationalIdBack
          : nationalIdBack // ignore: cast_nullable_to_non_nullable
              as String?,
      nationalIdNumber: freezed == nationalIdNumber
          ? _value.nationalIdNumber
          : nationalIdNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      certificates: null == certificates
          ? _value.certificates
          : certificates // ignore: cast_nullable_to_non_nullable
              as List<String>,
      commercialRegister: freezed == commercialRegister
          ? _value.commercialRegister
          : commercialRegister // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CraftsmanDocumentsImplCopyWith<$Res>
    implements $CraftsmanDocumentsCopyWith<$Res> {
  factory _$$CraftsmanDocumentsImplCopyWith(_$CraftsmanDocumentsImpl value,
          $Res Function(_$CraftsmanDocumentsImpl) then) =
      __$$CraftsmanDocumentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? nationalIdFront,
      String? nationalIdBack,
      String? nationalIdNumber,
      List<String> certificates,
      String? commercialRegister});
}

/// @nodoc
class __$$CraftsmanDocumentsImplCopyWithImpl<$Res>
    extends _$CraftsmanDocumentsCopyWithImpl<$Res, _$CraftsmanDocumentsImpl>
    implements _$$CraftsmanDocumentsImplCopyWith<$Res> {
  __$$CraftsmanDocumentsImplCopyWithImpl(_$CraftsmanDocumentsImpl _value,
      $Res Function(_$CraftsmanDocumentsImpl) _then)
      : super(_value, _then);

  /// Create a copy of CraftsmanDocuments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nationalIdFront = freezed,
    Object? nationalIdBack = freezed,
    Object? nationalIdNumber = freezed,
    Object? certificates = null,
    Object? commercialRegister = freezed,
  }) {
    return _then(_$CraftsmanDocumentsImpl(
      nationalIdFront: freezed == nationalIdFront
          ? _value.nationalIdFront
          : nationalIdFront // ignore: cast_nullable_to_non_nullable
              as String?,
      nationalIdBack: freezed == nationalIdBack
          ? _value.nationalIdBack
          : nationalIdBack // ignore: cast_nullable_to_non_nullable
              as String?,
      nationalIdNumber: freezed == nationalIdNumber
          ? _value.nationalIdNumber
          : nationalIdNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      certificates: null == certificates
          ? _value._certificates
          : certificates // ignore: cast_nullable_to_non_nullable
              as List<String>,
      commercialRegister: freezed == commercialRegister
          ? _value.commercialRegister
          : commercialRegister // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CraftsmanDocumentsImpl implements _CraftsmanDocuments {
  const _$CraftsmanDocumentsImpl(
      {this.nationalIdFront,
      this.nationalIdBack,
      this.nationalIdNumber,
      final List<String> certificates = const [],
      this.commercialRegister})
      : _certificates = certificates;

  factory _$CraftsmanDocumentsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CraftsmanDocumentsImplFromJson(json);

  @override
  final String? nationalIdFront;
  @override
  final String? nationalIdBack;
  @override
  final String? nationalIdNumber;
  final List<String> _certificates;
  @override
  @JsonKey()
  List<String> get certificates {
    if (_certificates is EqualUnmodifiableListView) return _certificates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_certificates);
  }

  @override
  final String? commercialRegister;

  @override
  String toString() {
    return 'CraftsmanDocuments(nationalIdFront: $nationalIdFront, nationalIdBack: $nationalIdBack, nationalIdNumber: $nationalIdNumber, certificates: $certificates, commercialRegister: $commercialRegister)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CraftsmanDocumentsImpl &&
            (identical(other.nationalIdFront, nationalIdFront) ||
                other.nationalIdFront == nationalIdFront) &&
            (identical(other.nationalIdBack, nationalIdBack) ||
                other.nationalIdBack == nationalIdBack) &&
            (identical(other.nationalIdNumber, nationalIdNumber) ||
                other.nationalIdNumber == nationalIdNumber) &&
            const DeepCollectionEquality()
                .equals(other._certificates, _certificates) &&
            (identical(other.commercialRegister, commercialRegister) ||
                other.commercialRegister == commercialRegister));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      nationalIdFront,
      nationalIdBack,
      nationalIdNumber,
      const DeepCollectionEquality().hash(_certificates),
      commercialRegister);

  /// Create a copy of CraftsmanDocuments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CraftsmanDocumentsImplCopyWith<_$CraftsmanDocumentsImpl> get copyWith =>
      __$$CraftsmanDocumentsImplCopyWithImpl<_$CraftsmanDocumentsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CraftsmanDocumentsImplToJson(
      this,
    );
  }
}

abstract class _CraftsmanDocuments implements CraftsmanDocuments {
  const factory _CraftsmanDocuments(
      {final String? nationalIdFront,
      final String? nationalIdBack,
      final String? nationalIdNumber,
      final List<String> certificates,
      final String? commercialRegister}) = _$CraftsmanDocumentsImpl;

  factory _CraftsmanDocuments.fromJson(Map<String, dynamic> json) =
      _$CraftsmanDocumentsImpl.fromJson;

  @override
  String? get nationalIdFront;
  @override
  String? get nationalIdBack;
  @override
  String? get nationalIdNumber;
  @override
  List<String> get certificates;
  @override
  String? get commercialRegister;

  /// Create a copy of CraftsmanDocuments
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CraftsmanDocumentsImplCopyWith<_$CraftsmanDocumentsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GeoLocation _$GeoLocationFromJson(Map<String, dynamic> json) {
  return _GeoLocation.fromJson(json);
}

/// @nodoc
mixin _$GeoLocation {
  String get type => throw _privateConstructorUsedError;
  List<double> get coordinates => throw _privateConstructorUsedError;

  /// Serializes this GeoLocation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GeoLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeoLocationCopyWith<GeoLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeoLocationCopyWith<$Res> {
  factory $GeoLocationCopyWith(
          GeoLocation value, $Res Function(GeoLocation) then) =
      _$GeoLocationCopyWithImpl<$Res, GeoLocation>;
  @useResult
  $Res call({String type, List<double> coordinates});
}

/// @nodoc
class _$GeoLocationCopyWithImpl<$Res, $Val extends GeoLocation>
    implements $GeoLocationCopyWith<$Res> {
  _$GeoLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeoLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? coordinates = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      coordinates: null == coordinates
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeoLocationImplCopyWith<$Res>
    implements $GeoLocationCopyWith<$Res> {
  factory _$$GeoLocationImplCopyWith(
          _$GeoLocationImpl value, $Res Function(_$GeoLocationImpl) then) =
      __$$GeoLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, List<double> coordinates});
}

/// @nodoc
class __$$GeoLocationImplCopyWithImpl<$Res>
    extends _$GeoLocationCopyWithImpl<$Res, _$GeoLocationImpl>
    implements _$$GeoLocationImplCopyWith<$Res> {
  __$$GeoLocationImplCopyWithImpl(
      _$GeoLocationImpl _value, $Res Function(_$GeoLocationImpl) _then)
      : super(_value, _then);

  /// Create a copy of GeoLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? coordinates = null,
  }) {
    return _then(_$GeoLocationImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      coordinates: null == coordinates
          ? _value._coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeoLocationImpl implements _GeoLocation {
  const _$GeoLocationImpl(
      {this.type = 'Point', final List<double> coordinates = const []})
      : _coordinates = coordinates;

  factory _$GeoLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeoLocationImplFromJson(json);

  @override
  @JsonKey()
  final String type;
  final List<double> _coordinates;
  @override
  @JsonKey()
  List<double> get coordinates {
    if (_coordinates is EqualUnmodifiableListView) return _coordinates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coordinates);
  }

  @override
  String toString() {
    return 'GeoLocation(type: $type, coordinates: $coordinates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeoLocationImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._coordinates, _coordinates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(_coordinates));

  /// Create a copy of GeoLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeoLocationImplCopyWith<_$GeoLocationImpl> get copyWith =>
      __$$GeoLocationImplCopyWithImpl<_$GeoLocationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeoLocationImplToJson(
      this,
    );
  }
}

abstract class _GeoLocation implements GeoLocation {
  const factory _GeoLocation(
      {final String type, final List<double> coordinates}) = _$GeoLocationImpl;

  factory _GeoLocation.fromJson(Map<String, dynamic> json) =
      _$GeoLocationImpl.fromJson;

  @override
  String get type;
  @override
  List<double> get coordinates;

  /// Create a copy of GeoLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeoLocationImplCopyWith<_$GeoLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Craftsman _$CraftsmanFromJson(Map<String, dynamic> json) {
  return _Craftsman.fromJson(json);
}

/// @nodoc
mixin _$Craftsman {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  String? get coverImage => throw _privateConstructorUsedError;
  List<String> get workPhotos => throw _privateConstructorUsedError;
  String? get whatsapp => throw _privateConstructorUsedError;
  String? get alternatePhone => throw _privateConstructorUsedError;
  List<ServiceInfo> get services => throw _privateConstructorUsedError;
  CraftsmanDocuments? get documents => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  GeoLocation? get location => throw _privateConstructorUsedError;
  double get serviceRadius => throw _privateConstructorUsedError;
  List<String> get serviceZones => throw _privateConstructorUsedError;
  bool get isOnline => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  List<WorkingHour> get workingHours => throw _privateConstructorUsedError;
  CraftsmanStatus get status => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  String? get rejectionReason => throw _privateConstructorUsedError;
  String? get suspensionReason => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  int get totalRatings => throw _privateConstructorUsedError;
  int get totalJobs => throw _privateConstructorUsedError;
  int get completedJobs => throw _privateConstructorUsedError;
  int get cancelledJobs => throw _privateConstructorUsedError;
  double get responseRate => throw _privateConstructorUsedError;
  int get responseTime => throw _privateConstructorUsedError;
  double get totalEarnings => throw _privateConstructorUsedError;
  double get currentBalance => throw _privateConstructorUsedError;
  int get commission => throw _privateConstructorUsedError;
  List<String> get badges => throw _privateConstructorUsedError;
  bool get isFeatured => throw _privateConstructorUsedError;
  DateTime? get featuredUntil => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // Populated user details
  User? get user =>
      throw _privateConstructorUsedError; // Distance from current location (populated in nearby queries)
  double? get distance => throw _privateConstructorUsedError;

  /// Serializes this Craftsman to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Craftsman
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CraftsmanCopyWith<Craftsman> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CraftsmanCopyWith<$Res> {
  factory $CraftsmanCopyWith(Craftsman value, $Res Function(Craftsman) then) =
      _$CraftsmanCopyWithImpl<$Res, Craftsman>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String userId,
      String displayName,
      String? bio,
      String? profileImage,
      String? coverImage,
      List<String> workPhotos,
      String? whatsapp,
      String? alternatePhone,
      List<ServiceInfo> services,
      CraftsmanDocuments? documents,
      String? address,
      GeoLocation? location,
      double serviceRadius,
      List<String> serviceZones,
      bool isOnline,
      bool isAvailable,
      List<WorkingHour> workingHours,
      CraftsmanStatus status,
      DateTime? approvedAt,
      String? approvedBy,
      String? rejectionReason,
      String? suspensionReason,
      double rating,
      int totalRatings,
      int totalJobs,
      int completedJobs,
      int cancelledJobs,
      double responseRate,
      int responseTime,
      double totalEarnings,
      double currentBalance,
      int commission,
      List<String> badges,
      bool isFeatured,
      DateTime? featuredUntil,
      DateTime? createdAt,
      DateTime? updatedAt,
      User? user,
      double? distance});

  $CraftsmanDocumentsCopyWith<$Res>? get documents;
  $GeoLocationCopyWith<$Res>? get location;
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$CraftsmanCopyWithImpl<$Res, $Val extends Craftsman>
    implements $CraftsmanCopyWith<$Res> {
  _$CraftsmanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Craftsman
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? displayName = null,
    Object? bio = freezed,
    Object? profileImage = freezed,
    Object? coverImage = freezed,
    Object? workPhotos = null,
    Object? whatsapp = freezed,
    Object? alternatePhone = freezed,
    Object? services = null,
    Object? documents = freezed,
    Object? address = freezed,
    Object? location = freezed,
    Object? serviceRadius = null,
    Object? serviceZones = null,
    Object? isOnline = null,
    Object? isAvailable = null,
    Object? workingHours = null,
    Object? status = null,
    Object? approvedAt = freezed,
    Object? approvedBy = freezed,
    Object? rejectionReason = freezed,
    Object? suspensionReason = freezed,
    Object? rating = null,
    Object? totalRatings = null,
    Object? totalJobs = null,
    Object? completedJobs = null,
    Object? cancelledJobs = null,
    Object? responseRate = null,
    Object? responseTime = null,
    Object? totalEarnings = null,
    Object? currentBalance = null,
    Object? commission = null,
    Object? badges = null,
    Object? isFeatured = null,
    Object? featuredUntil = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? user = freezed,
    Object? distance = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImage: freezed == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String?,
      workPhotos: null == workPhotos
          ? _value.workPhotos
          : workPhotos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      whatsapp: freezed == whatsapp
          ? _value.whatsapp
          : whatsapp // ignore: cast_nullable_to_non_nullable
              as String?,
      alternatePhone: freezed == alternatePhone
          ? _value.alternatePhone
          : alternatePhone // ignore: cast_nullable_to_non_nullable
              as String?,
      services: null == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<ServiceInfo>,
      documents: freezed == documents
          ? _value.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as CraftsmanDocuments?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoLocation?,
      serviceRadius: null == serviceRadius
          ? _value.serviceRadius
          : serviceRadius // ignore: cast_nullable_to_non_nullable
              as double,
      serviceZones: null == serviceZones
          ? _value.serviceZones
          : serviceZones // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      workingHours: null == workingHours
          ? _value.workingHours
          : workingHours // ignore: cast_nullable_to_non_nullable
              as List<WorkingHour>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CraftsmanStatus,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      suspensionReason: freezed == suspensionReason
          ? _value.suspensionReason
          : suspensionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      totalRatings: null == totalRatings
          ? _value.totalRatings
          : totalRatings // ignore: cast_nullable_to_non_nullable
              as int,
      totalJobs: null == totalJobs
          ? _value.totalJobs
          : totalJobs // ignore: cast_nullable_to_non_nullable
              as int,
      completedJobs: null == completedJobs
          ? _value.completedJobs
          : completedJobs // ignore: cast_nullable_to_non_nullable
              as int,
      cancelledJobs: null == cancelledJobs
          ? _value.cancelledJobs
          : cancelledJobs // ignore: cast_nullable_to_non_nullable
              as int,
      responseRate: null == responseRate
          ? _value.responseRate
          : responseRate // ignore: cast_nullable_to_non_nullable
              as double,
      responseTime: null == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as int,
      totalEarnings: null == totalEarnings
          ? _value.totalEarnings
          : totalEarnings // ignore: cast_nullable_to_non_nullable
              as double,
      currentBalance: null == currentBalance
          ? _value.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as double,
      commission: null == commission
          ? _value.commission
          : commission // ignore: cast_nullable_to_non_nullable
              as int,
      badges: null == badges
          ? _value.badges
          : badges // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isFeatured: null == isFeatured
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool,
      featuredUntil: freezed == featuredUntil
          ? _value.featuredUntil
          : featuredUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  /// Create a copy of Craftsman
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CraftsmanDocumentsCopyWith<$Res>? get documents {
    if (_value.documents == null) {
      return null;
    }

    return $CraftsmanDocumentsCopyWith<$Res>(_value.documents!, (value) {
      return _then(_value.copyWith(documents: value) as $Val);
    });
  }

  /// Create a copy of Craftsman
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GeoLocationCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $GeoLocationCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  /// Create a copy of Craftsman
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CraftsmanImplCopyWith<$Res>
    implements $CraftsmanCopyWith<$Res> {
  factory _$$CraftsmanImplCopyWith(
          _$CraftsmanImpl value, $Res Function(_$CraftsmanImpl) then) =
      __$$CraftsmanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String userId,
      String displayName,
      String? bio,
      String? profileImage,
      String? coverImage,
      List<String> workPhotos,
      String? whatsapp,
      String? alternatePhone,
      List<ServiceInfo> services,
      CraftsmanDocuments? documents,
      String? address,
      GeoLocation? location,
      double serviceRadius,
      List<String> serviceZones,
      bool isOnline,
      bool isAvailable,
      List<WorkingHour> workingHours,
      CraftsmanStatus status,
      DateTime? approvedAt,
      String? approvedBy,
      String? rejectionReason,
      String? suspensionReason,
      double rating,
      int totalRatings,
      int totalJobs,
      int completedJobs,
      int cancelledJobs,
      double responseRate,
      int responseTime,
      double totalEarnings,
      double currentBalance,
      int commission,
      List<String> badges,
      bool isFeatured,
      DateTime? featuredUntil,
      DateTime? createdAt,
      DateTime? updatedAt,
      User? user,
      double? distance});

  @override
  $CraftsmanDocumentsCopyWith<$Res>? get documents;
  @override
  $GeoLocationCopyWith<$Res>? get location;
  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$CraftsmanImplCopyWithImpl<$Res>
    extends _$CraftsmanCopyWithImpl<$Res, _$CraftsmanImpl>
    implements _$$CraftsmanImplCopyWith<$Res> {
  __$$CraftsmanImplCopyWithImpl(
      _$CraftsmanImpl _value, $Res Function(_$CraftsmanImpl) _then)
      : super(_value, _then);

  /// Create a copy of Craftsman
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? displayName = null,
    Object? bio = freezed,
    Object? profileImage = freezed,
    Object? coverImage = freezed,
    Object? workPhotos = null,
    Object? whatsapp = freezed,
    Object? alternatePhone = freezed,
    Object? services = null,
    Object? documents = freezed,
    Object? address = freezed,
    Object? location = freezed,
    Object? serviceRadius = null,
    Object? serviceZones = null,
    Object? isOnline = null,
    Object? isAvailable = null,
    Object? workingHours = null,
    Object? status = null,
    Object? approvedAt = freezed,
    Object? approvedBy = freezed,
    Object? rejectionReason = freezed,
    Object? suspensionReason = freezed,
    Object? rating = null,
    Object? totalRatings = null,
    Object? totalJobs = null,
    Object? completedJobs = null,
    Object? cancelledJobs = null,
    Object? responseRate = null,
    Object? responseTime = null,
    Object? totalEarnings = null,
    Object? currentBalance = null,
    Object? commission = null,
    Object? badges = null,
    Object? isFeatured = null,
    Object? featuredUntil = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? user = freezed,
    Object? distance = freezed,
  }) {
    return _then(_$CraftsmanImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImage: freezed == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String?,
      workPhotos: null == workPhotos
          ? _value._workPhotos
          : workPhotos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      whatsapp: freezed == whatsapp
          ? _value.whatsapp
          : whatsapp // ignore: cast_nullable_to_non_nullable
              as String?,
      alternatePhone: freezed == alternatePhone
          ? _value.alternatePhone
          : alternatePhone // ignore: cast_nullable_to_non_nullable
              as String?,
      services: null == services
          ? _value._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<ServiceInfo>,
      documents: freezed == documents
          ? _value.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as CraftsmanDocuments?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoLocation?,
      serviceRadius: null == serviceRadius
          ? _value.serviceRadius
          : serviceRadius // ignore: cast_nullable_to_non_nullable
              as double,
      serviceZones: null == serviceZones
          ? _value._serviceZones
          : serviceZones // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      workingHours: null == workingHours
          ? _value._workingHours
          : workingHours // ignore: cast_nullable_to_non_nullable
              as List<WorkingHour>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CraftsmanStatus,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      suspensionReason: freezed == suspensionReason
          ? _value.suspensionReason
          : suspensionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      totalRatings: null == totalRatings
          ? _value.totalRatings
          : totalRatings // ignore: cast_nullable_to_non_nullable
              as int,
      totalJobs: null == totalJobs
          ? _value.totalJobs
          : totalJobs // ignore: cast_nullable_to_non_nullable
              as int,
      completedJobs: null == completedJobs
          ? _value.completedJobs
          : completedJobs // ignore: cast_nullable_to_non_nullable
              as int,
      cancelledJobs: null == cancelledJobs
          ? _value.cancelledJobs
          : cancelledJobs // ignore: cast_nullable_to_non_nullable
              as int,
      responseRate: null == responseRate
          ? _value.responseRate
          : responseRate // ignore: cast_nullable_to_non_nullable
              as double,
      responseTime: null == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as int,
      totalEarnings: null == totalEarnings
          ? _value.totalEarnings
          : totalEarnings // ignore: cast_nullable_to_non_nullable
              as double,
      currentBalance: null == currentBalance
          ? _value.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as double,
      commission: null == commission
          ? _value.commission
          : commission // ignore: cast_nullable_to_non_nullable
              as int,
      badges: null == badges
          ? _value._badges
          : badges // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isFeatured: null == isFeatured
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool,
      featuredUntil: freezed == featuredUntil
          ? _value.featuredUntil
          : featuredUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CraftsmanImpl extends _Craftsman {
  const _$CraftsmanImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.userId,
      required this.displayName,
      this.bio,
      this.profileImage,
      this.coverImage,
      final List<String> workPhotos = const [],
      this.whatsapp,
      this.alternatePhone,
      final List<ServiceInfo> services = const [],
      this.documents,
      this.address,
      this.location,
      this.serviceRadius = 10,
      final List<String> serviceZones = const [],
      this.isOnline = false,
      this.isAvailable = true,
      final List<WorkingHour> workingHours = const [],
      this.status = CraftsmanStatus.pending,
      this.approvedAt,
      this.approvedBy,
      this.rejectionReason,
      this.suspensionReason,
      this.rating = 0.0,
      this.totalRatings = 0,
      this.totalJobs = 0,
      this.completedJobs = 0,
      this.cancelledJobs = 0,
      this.responseRate = 0.0,
      this.responseTime = 0,
      this.totalEarnings = 0.0,
      this.currentBalance = 0.0,
      this.commission = 15,
      final List<String> badges = const [],
      this.isFeatured = false,
      this.featuredUntil,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.distance})
      : _workPhotos = workPhotos,
        _services = services,
        _serviceZones = serviceZones,
        _workingHours = workingHours,
        _badges = badges,
        super._();

  factory _$CraftsmanImpl.fromJson(Map<String, dynamic> json) =>
      _$$CraftsmanImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String userId;
  @override
  final String displayName;
  @override
  final String? bio;
  @override
  final String? profileImage;
  @override
  final String? coverImage;
  final List<String> _workPhotos;
  @override
  @JsonKey()
  List<String> get workPhotos {
    if (_workPhotos is EqualUnmodifiableListView) return _workPhotos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workPhotos);
  }

  @override
  final String? whatsapp;
  @override
  final String? alternatePhone;
  final List<ServiceInfo> _services;
  @override
  @JsonKey()
  List<ServiceInfo> get services {
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_services);
  }

  @override
  final CraftsmanDocuments? documents;
  @override
  final String? address;
  @override
  final GeoLocation? location;
  @override
  @JsonKey()
  final double serviceRadius;
  final List<String> _serviceZones;
  @override
  @JsonKey()
  List<String> get serviceZones {
    if (_serviceZones is EqualUnmodifiableListView) return _serviceZones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_serviceZones);
  }

  @override
  @JsonKey()
  final bool isOnline;
  @override
  @JsonKey()
  final bool isAvailable;
  final List<WorkingHour> _workingHours;
  @override
  @JsonKey()
  List<WorkingHour> get workingHours {
    if (_workingHours is EqualUnmodifiableListView) return _workingHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workingHours);
  }

  @override
  @JsonKey()
  final CraftsmanStatus status;
  @override
  final DateTime? approvedAt;
  @override
  final String? approvedBy;
  @override
  final String? rejectionReason;
  @override
  final String? suspensionReason;
  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey()
  final int totalRatings;
  @override
  @JsonKey()
  final int totalJobs;
  @override
  @JsonKey()
  final int completedJobs;
  @override
  @JsonKey()
  final int cancelledJobs;
  @override
  @JsonKey()
  final double responseRate;
  @override
  @JsonKey()
  final int responseTime;
  @override
  @JsonKey()
  final double totalEarnings;
  @override
  @JsonKey()
  final double currentBalance;
  @override
  @JsonKey()
  final int commission;
  final List<String> _badges;
  @override
  @JsonKey()
  List<String> get badges {
    if (_badges is EqualUnmodifiableListView) return _badges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_badges);
  }

  @override
  @JsonKey()
  final bool isFeatured;
  @override
  final DateTime? featuredUntil;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
// Populated user details
  @override
  final User? user;
// Distance from current location (populated in nearby queries)
  @override
  final double? distance;

  @override
  String toString() {
    return 'Craftsman(id: $id, userId: $userId, displayName: $displayName, bio: $bio, profileImage: $profileImage, coverImage: $coverImage, workPhotos: $workPhotos, whatsapp: $whatsapp, alternatePhone: $alternatePhone, services: $services, documents: $documents, address: $address, location: $location, serviceRadius: $serviceRadius, serviceZones: $serviceZones, isOnline: $isOnline, isAvailable: $isAvailable, workingHours: $workingHours, status: $status, approvedAt: $approvedAt, approvedBy: $approvedBy, rejectionReason: $rejectionReason, suspensionReason: $suspensionReason, rating: $rating, totalRatings: $totalRatings, totalJobs: $totalJobs, completedJobs: $completedJobs, cancelledJobs: $cancelledJobs, responseRate: $responseRate, responseTime: $responseTime, totalEarnings: $totalEarnings, currentBalance: $currentBalance, commission: $commission, badges: $badges, isFeatured: $isFeatured, featuredUntil: $featuredUntil, createdAt: $createdAt, updatedAt: $updatedAt, user: $user, distance: $distance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CraftsmanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            const DeepCollectionEquality()
                .equals(other._workPhotos, _workPhotos) &&
            (identical(other.whatsapp, whatsapp) ||
                other.whatsapp == whatsapp) &&
            (identical(other.alternatePhone, alternatePhone) ||
                other.alternatePhone == alternatePhone) &&
            const DeepCollectionEquality().equals(other._services, _services) &&
            (identical(other.documents, documents) ||
                other.documents == documents) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.serviceRadius, serviceRadius) ||
                other.serviceRadius == serviceRadius) &&
            const DeepCollectionEquality()
                .equals(other._serviceZones, _serviceZones) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            const DeepCollectionEquality()
                .equals(other._workingHours, _workingHours) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            (identical(other.suspensionReason, suspensionReason) ||
                other.suspensionReason == suspensionReason) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.totalRatings, totalRatings) ||
                other.totalRatings == totalRatings) &&
            (identical(other.totalJobs, totalJobs) ||
                other.totalJobs == totalJobs) &&
            (identical(other.completedJobs, completedJobs) ||
                other.completedJobs == completedJobs) &&
            (identical(other.cancelledJobs, cancelledJobs) ||
                other.cancelledJobs == cancelledJobs) &&
            (identical(other.responseRate, responseRate) ||
                other.responseRate == responseRate) &&
            (identical(other.responseTime, responseTime) ||
                other.responseTime == responseTime) &&
            (identical(other.totalEarnings, totalEarnings) ||
                other.totalEarnings == totalEarnings) &&
            (identical(other.currentBalance, currentBalance) ||
                other.currentBalance == currentBalance) &&
            (identical(other.commission, commission) ||
                other.commission == commission) &&
            const DeepCollectionEquality().equals(other._badges, _badges) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.featuredUntil, featuredUntil) ||
                other.featuredUntil == featuredUntil) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.distance, distance) ||
                other.distance == distance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        displayName,
        bio,
        profileImage,
        coverImage,
        const DeepCollectionEquality().hash(_workPhotos),
        whatsapp,
        alternatePhone,
        const DeepCollectionEquality().hash(_services),
        documents,
        address,
        location,
        serviceRadius,
        const DeepCollectionEquality().hash(_serviceZones),
        isOnline,
        isAvailable,
        const DeepCollectionEquality().hash(_workingHours),
        status,
        approvedAt,
        approvedBy,
        rejectionReason,
        suspensionReason,
        rating,
        totalRatings,
        totalJobs,
        completedJobs,
        cancelledJobs,
        responseRate,
        responseTime,
        totalEarnings,
        currentBalance,
        commission,
        const DeepCollectionEquality().hash(_badges),
        isFeatured,
        featuredUntil,
        createdAt,
        updatedAt,
        user,
        distance
      ]);

  /// Create a copy of Craftsman
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CraftsmanImplCopyWith<_$CraftsmanImpl> get copyWith =>
      __$$CraftsmanImplCopyWithImpl<_$CraftsmanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CraftsmanImplToJson(
      this,
    );
  }
}

abstract class _Craftsman extends Craftsman {
  const factory _Craftsman(
      {@JsonKey(name: '_id') required final String id,
      required final String userId,
      required final String displayName,
      final String? bio,
      final String? profileImage,
      final String? coverImage,
      final List<String> workPhotos,
      final String? whatsapp,
      final String? alternatePhone,
      final List<ServiceInfo> services,
      final CraftsmanDocuments? documents,
      final String? address,
      final GeoLocation? location,
      final double serviceRadius,
      final List<String> serviceZones,
      final bool isOnline,
      final bool isAvailable,
      final List<WorkingHour> workingHours,
      final CraftsmanStatus status,
      final DateTime? approvedAt,
      final String? approvedBy,
      final String? rejectionReason,
      final String? suspensionReason,
      final double rating,
      final int totalRatings,
      final int totalJobs,
      final int completedJobs,
      final int cancelledJobs,
      final double responseRate,
      final int responseTime,
      final double totalEarnings,
      final double currentBalance,
      final int commission,
      final List<String> badges,
      final bool isFeatured,
      final DateTime? featuredUntil,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final User? user,
      final double? distance}) = _$CraftsmanImpl;
  const _Craftsman._() : super._();

  factory _Craftsman.fromJson(Map<String, dynamic> json) =
      _$CraftsmanImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get userId;
  @override
  String get displayName;
  @override
  String? get bio;
  @override
  String? get profileImage;
  @override
  String? get coverImage;
  @override
  List<String> get workPhotos;
  @override
  String? get whatsapp;
  @override
  String? get alternatePhone;
  @override
  List<ServiceInfo> get services;
  @override
  CraftsmanDocuments? get documents;
  @override
  String? get address;
  @override
  GeoLocation? get location;
  @override
  double get serviceRadius;
  @override
  List<String> get serviceZones;
  @override
  bool get isOnline;
  @override
  bool get isAvailable;
  @override
  List<WorkingHour> get workingHours;
  @override
  CraftsmanStatus get status;
  @override
  DateTime? get approvedAt;
  @override
  String? get approvedBy;
  @override
  String? get rejectionReason;
  @override
  String? get suspensionReason;
  @override
  double get rating;
  @override
  int get totalRatings;
  @override
  int get totalJobs;
  @override
  int get completedJobs;
  @override
  int get cancelledJobs;
  @override
  double get responseRate;
  @override
  int get responseTime;
  @override
  double get totalEarnings;
  @override
  double get currentBalance;
  @override
  int get commission;
  @override
  List<String> get badges;
  @override
  bool get isFeatured;
  @override
  DateTime? get featuredUntil;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt; // Populated user details
  @override
  User?
      get user; // Distance from current location (populated in nearby queries)
  @override
  double? get distance;

  /// Create a copy of Craftsman
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CraftsmanImplCopyWith<_$CraftsmanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CraftsmanListResponse _$CraftsmanListResponseFromJson(
    Map<String, dynamic> json) {
  return _CraftsmanListResponse.fromJson(json);
}

/// @nodoc
mixin _$CraftsmanListResponse {
  List<Craftsman> get data => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;

  /// Serializes this CraftsmanListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CraftsmanListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CraftsmanListResponseCopyWith<CraftsmanListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CraftsmanListResponseCopyWith<$Res> {
  factory $CraftsmanListResponseCopyWith(CraftsmanListResponse value,
          $Res Function(CraftsmanListResponse) then) =
      _$CraftsmanListResponseCopyWithImpl<$Res, CraftsmanListResponse>;
  @useResult
  $Res call(
      {List<Craftsman> data, int page, int limit, int total, int totalPages});
}

/// @nodoc
class _$CraftsmanListResponseCopyWithImpl<$Res,
        $Val extends CraftsmanListResponse>
    implements $CraftsmanListResponseCopyWith<$Res> {
  _$CraftsmanListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CraftsmanListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? page = null,
    Object? limit = null,
    Object? total = null,
    Object? totalPages = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Craftsman>,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CraftsmanListResponseImplCopyWith<$Res>
    implements $CraftsmanListResponseCopyWith<$Res> {
  factory _$$CraftsmanListResponseImplCopyWith(
          _$CraftsmanListResponseImpl value,
          $Res Function(_$CraftsmanListResponseImpl) then) =
      __$$CraftsmanListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Craftsman> data, int page, int limit, int total, int totalPages});
}

/// @nodoc
class __$$CraftsmanListResponseImplCopyWithImpl<$Res>
    extends _$CraftsmanListResponseCopyWithImpl<$Res,
        _$CraftsmanListResponseImpl>
    implements _$$CraftsmanListResponseImplCopyWith<$Res> {
  __$$CraftsmanListResponseImplCopyWithImpl(_$CraftsmanListResponseImpl _value,
      $Res Function(_$CraftsmanListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CraftsmanListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? page = null,
    Object? limit = null,
    Object? total = null,
    Object? totalPages = null,
  }) {
    return _then(_$CraftsmanListResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Craftsman>,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CraftsmanListResponseImpl implements _CraftsmanListResponse {
  const _$CraftsmanListResponseImpl(
      {required final List<Craftsman> data,
      required this.page,
      required this.limit,
      required this.total,
      required this.totalPages})
      : _data = data;

  factory _$CraftsmanListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CraftsmanListResponseImplFromJson(json);

  final List<Craftsman> _data;
  @override
  List<Craftsman> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final int page;
  @override
  final int limit;
  @override
  final int total;
  @override
  final int totalPages;

  @override
  String toString() {
    return 'CraftsmanListResponse(data: $data, page: $page, limit: $limit, total: $total, totalPages: $totalPages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CraftsmanListResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_data),
      page,
      limit,
      total,
      totalPages);

  /// Create a copy of CraftsmanListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CraftsmanListResponseImplCopyWith<_$CraftsmanListResponseImpl>
      get copyWith => __$$CraftsmanListResponseImplCopyWithImpl<
          _$CraftsmanListResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CraftsmanListResponseImplToJson(
      this,
    );
  }
}

abstract class _CraftsmanListResponse implements CraftsmanListResponse {
  const factory _CraftsmanListResponse(
      {required final List<Craftsman> data,
      required final int page,
      required final int limit,
      required final int total,
      required final int totalPages}) = _$CraftsmanListResponseImpl;

  factory _CraftsmanListResponse.fromJson(Map<String, dynamic> json) =
      _$CraftsmanListResponseImpl.fromJson;

  @override
  List<Craftsman> get data;
  @override
  int get page;
  @override
  int get limit;
  @override
  int get total;
  @override
  int get totalPages;

  /// Create a copy of CraftsmanListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CraftsmanListResponseImplCopyWith<_$CraftsmanListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
