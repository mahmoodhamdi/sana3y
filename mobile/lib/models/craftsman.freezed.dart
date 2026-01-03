// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'craftsman.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServiceInfo {
  String get categoryId;
  List<String> get subcategories;
  int get experience;
  PriceType get priceType;
  double? get basePrice;
  String? get description; // Populated category details
  Map<String, dynamic>? get category;

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ServiceInfoCopyWith<ServiceInfo> get copyWith =>
      _$ServiceInfoCopyWithImpl<ServiceInfo>(this as ServiceInfo, _$identity);

  /// Serializes this ServiceInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ServiceInfo &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            const DeepCollectionEquality()
                .equals(other.subcategories, subcategories) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.priceType, priceType) ||
                other.priceType == priceType) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.category, category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      categoryId,
      const DeepCollectionEquality().hash(subcategories),
      experience,
      priceType,
      basePrice,
      description,
      const DeepCollectionEquality().hash(category));

  @override
  String toString() {
    return 'ServiceInfo(categoryId: $categoryId, subcategories: $subcategories, experience: $experience, priceType: $priceType, basePrice: $basePrice, description: $description, category: $category)';
  }
}

/// @nodoc
abstract mixin class $ServiceInfoCopyWith<$Res> {
  factory $ServiceInfoCopyWith(
          ServiceInfo value, $Res Function(ServiceInfo) _then) =
      _$ServiceInfoCopyWithImpl;
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
class _$ServiceInfoCopyWithImpl<$Res> implements $ServiceInfoCopyWith<$Res> {
  _$ServiceInfoCopyWithImpl(this._self, this._then);

  final ServiceInfo _self;
  final $Res Function(ServiceInfo) _then;

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
    return _then(_self.copyWith(
      categoryId: null == categoryId
          ? _self.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      subcategories: null == subcategories
          ? _self.subcategories
          : subcategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      experience: null == experience
          ? _self.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int,
      priceType: null == priceType
          ? _self.priceType
          : priceType // ignore: cast_nullable_to_non_nullable
              as PriceType,
      basePrice: freezed == basePrice
          ? _self.basePrice
          : basePrice // ignore: cast_nullable_to_non_nullable
              as double?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ServiceInfo implements ServiceInfo {
  const _ServiceInfo(
      {required this.categoryId,
      final List<String> subcategories = const [],
      this.experience = 0,
      this.priceType = PriceType.quote,
      this.basePrice,
      this.description,
      final Map<String, dynamic>? category})
      : _subcategories = subcategories,
        _category = category;
  factory _ServiceInfo.fromJson(Map<String, dynamic> json) =>
      _$ServiceInfoFromJson(json);

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

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ServiceInfoCopyWith<_ServiceInfo> get copyWith =>
      __$ServiceInfoCopyWithImpl<_ServiceInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ServiceInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ServiceInfo &&
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

  @override
  String toString() {
    return 'ServiceInfo(categoryId: $categoryId, subcategories: $subcategories, experience: $experience, priceType: $priceType, basePrice: $basePrice, description: $description, category: $category)';
  }
}

/// @nodoc
abstract mixin class _$ServiceInfoCopyWith<$Res>
    implements $ServiceInfoCopyWith<$Res> {
  factory _$ServiceInfoCopyWith(
          _ServiceInfo value, $Res Function(_ServiceInfo) _then) =
      __$ServiceInfoCopyWithImpl;
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
class __$ServiceInfoCopyWithImpl<$Res> implements _$ServiceInfoCopyWith<$Res> {
  __$ServiceInfoCopyWithImpl(this._self, this._then);

  final _ServiceInfo _self;
  final $Res Function(_ServiceInfo) _then;

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? categoryId = null,
    Object? subcategories = null,
    Object? experience = null,
    Object? priceType = null,
    Object? basePrice = freezed,
    Object? description = freezed,
    Object? category = freezed,
  }) {
    return _then(_ServiceInfo(
      categoryId: null == categoryId
          ? _self.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      subcategories: null == subcategories
          ? _self._subcategories
          : subcategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      experience: null == experience
          ? _self.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int,
      priceType: null == priceType
          ? _self.priceType
          : priceType // ignore: cast_nullable_to_non_nullable
              as PriceType,
      basePrice: freezed == basePrice
          ? _self.basePrice
          : basePrice // ignore: cast_nullable_to_non_nullable
              as double?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _self._category
          : category // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
mixin _$WorkingHour {
  int get day;
  bool get isWorking;
  String get start;
  String get end;

  /// Create a copy of WorkingHour
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkingHourCopyWith<WorkingHour> get copyWith =>
      _$WorkingHourCopyWithImpl<WorkingHour>(this as WorkingHour, _$identity);

  /// Serializes this WorkingHour to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkingHour &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.isWorking, isWorking) ||
                other.isWorking == isWorking) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, day, isWorking, start, end);

  @override
  String toString() {
    return 'WorkingHour(day: $day, isWorking: $isWorking, start: $start, end: $end)';
  }
}

/// @nodoc
abstract mixin class $WorkingHourCopyWith<$Res> {
  factory $WorkingHourCopyWith(
          WorkingHour value, $Res Function(WorkingHour) _then) =
      _$WorkingHourCopyWithImpl;
  @useResult
  $Res call({int day, bool isWorking, String start, String end});
}

/// @nodoc
class _$WorkingHourCopyWithImpl<$Res> implements $WorkingHourCopyWith<$Res> {
  _$WorkingHourCopyWithImpl(this._self, this._then);

  final WorkingHour _self;
  final $Res Function(WorkingHour) _then;

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
    return _then(_self.copyWith(
      day: null == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      isWorking: null == isWorking
          ? _self.isWorking
          : isWorking // ignore: cast_nullable_to_non_nullable
              as bool,
      start: null == start
          ? _self.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _self.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WorkingHour implements WorkingHour {
  const _WorkingHour(
      {required this.day,
      this.isWorking = true,
      this.start = '08:00',
      this.end = '20:00'});
  factory _WorkingHour.fromJson(Map<String, dynamic> json) =>
      _$WorkingHourFromJson(json);

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

  /// Create a copy of WorkingHour
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkingHourCopyWith<_WorkingHour> get copyWith =>
      __$WorkingHourCopyWithImpl<_WorkingHour>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkingHourToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkingHour &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.isWorking, isWorking) ||
                other.isWorking == isWorking) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, day, isWorking, start, end);

  @override
  String toString() {
    return 'WorkingHour(day: $day, isWorking: $isWorking, start: $start, end: $end)';
  }
}

/// @nodoc
abstract mixin class _$WorkingHourCopyWith<$Res>
    implements $WorkingHourCopyWith<$Res> {
  factory _$WorkingHourCopyWith(
          _WorkingHour value, $Res Function(_WorkingHour) _then) =
      __$WorkingHourCopyWithImpl;
  @override
  @useResult
  $Res call({int day, bool isWorking, String start, String end});
}

/// @nodoc
class __$WorkingHourCopyWithImpl<$Res> implements _$WorkingHourCopyWith<$Res> {
  __$WorkingHourCopyWithImpl(this._self, this._then);

  final _WorkingHour _self;
  final $Res Function(_WorkingHour) _then;

  /// Create a copy of WorkingHour
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? day = null,
    Object? isWorking = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_WorkingHour(
      day: null == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      isWorking: null == isWorking
          ? _self.isWorking
          : isWorking // ignore: cast_nullable_to_non_nullable
              as bool,
      start: null == start
          ? _self.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _self.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$CraftsmanDocuments {
  String? get nationalIdFront;
  String? get nationalIdBack;
  String? get nationalIdNumber;
  List<String> get certificates;
  String? get commercialRegister;

  /// Create a copy of CraftsmanDocuments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CraftsmanDocumentsCopyWith<CraftsmanDocuments> get copyWith =>
      _$CraftsmanDocumentsCopyWithImpl<CraftsmanDocuments>(
          this as CraftsmanDocuments, _$identity);

  /// Serializes this CraftsmanDocuments to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CraftsmanDocuments &&
            (identical(other.nationalIdFront, nationalIdFront) ||
                other.nationalIdFront == nationalIdFront) &&
            (identical(other.nationalIdBack, nationalIdBack) ||
                other.nationalIdBack == nationalIdBack) &&
            (identical(other.nationalIdNumber, nationalIdNumber) ||
                other.nationalIdNumber == nationalIdNumber) &&
            const DeepCollectionEquality()
                .equals(other.certificates, certificates) &&
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
      const DeepCollectionEquality().hash(certificates),
      commercialRegister);

  @override
  String toString() {
    return 'CraftsmanDocuments(nationalIdFront: $nationalIdFront, nationalIdBack: $nationalIdBack, nationalIdNumber: $nationalIdNumber, certificates: $certificates, commercialRegister: $commercialRegister)';
  }
}

/// @nodoc
abstract mixin class $CraftsmanDocumentsCopyWith<$Res> {
  factory $CraftsmanDocumentsCopyWith(
          CraftsmanDocuments value, $Res Function(CraftsmanDocuments) _then) =
      _$CraftsmanDocumentsCopyWithImpl;
  @useResult
  $Res call(
      {String? nationalIdFront,
      String? nationalIdBack,
      String? nationalIdNumber,
      List<String> certificates,
      String? commercialRegister});
}

/// @nodoc
class _$CraftsmanDocumentsCopyWithImpl<$Res>
    implements $CraftsmanDocumentsCopyWith<$Res> {
  _$CraftsmanDocumentsCopyWithImpl(this._self, this._then);

  final CraftsmanDocuments _self;
  final $Res Function(CraftsmanDocuments) _then;

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
    return _then(_self.copyWith(
      nationalIdFront: freezed == nationalIdFront
          ? _self.nationalIdFront
          : nationalIdFront // ignore: cast_nullable_to_non_nullable
              as String?,
      nationalIdBack: freezed == nationalIdBack
          ? _self.nationalIdBack
          : nationalIdBack // ignore: cast_nullable_to_non_nullable
              as String?,
      nationalIdNumber: freezed == nationalIdNumber
          ? _self.nationalIdNumber
          : nationalIdNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      certificates: null == certificates
          ? _self.certificates
          : certificates // ignore: cast_nullable_to_non_nullable
              as List<String>,
      commercialRegister: freezed == commercialRegister
          ? _self.commercialRegister
          : commercialRegister // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CraftsmanDocuments implements CraftsmanDocuments {
  const _CraftsmanDocuments(
      {this.nationalIdFront,
      this.nationalIdBack,
      this.nationalIdNumber,
      final List<String> certificates = const [],
      this.commercialRegister})
      : _certificates = certificates;
  factory _CraftsmanDocuments.fromJson(Map<String, dynamic> json) =>
      _$CraftsmanDocumentsFromJson(json);

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

  /// Create a copy of CraftsmanDocuments
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CraftsmanDocumentsCopyWith<_CraftsmanDocuments> get copyWith =>
      __$CraftsmanDocumentsCopyWithImpl<_CraftsmanDocuments>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CraftsmanDocumentsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CraftsmanDocuments &&
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

  @override
  String toString() {
    return 'CraftsmanDocuments(nationalIdFront: $nationalIdFront, nationalIdBack: $nationalIdBack, nationalIdNumber: $nationalIdNumber, certificates: $certificates, commercialRegister: $commercialRegister)';
  }
}

/// @nodoc
abstract mixin class _$CraftsmanDocumentsCopyWith<$Res>
    implements $CraftsmanDocumentsCopyWith<$Res> {
  factory _$CraftsmanDocumentsCopyWith(
          _CraftsmanDocuments value, $Res Function(_CraftsmanDocuments) _then) =
      __$CraftsmanDocumentsCopyWithImpl;
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
class __$CraftsmanDocumentsCopyWithImpl<$Res>
    implements _$CraftsmanDocumentsCopyWith<$Res> {
  __$CraftsmanDocumentsCopyWithImpl(this._self, this._then);

  final _CraftsmanDocuments _self;
  final $Res Function(_CraftsmanDocuments) _then;

  /// Create a copy of CraftsmanDocuments
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? nationalIdFront = freezed,
    Object? nationalIdBack = freezed,
    Object? nationalIdNumber = freezed,
    Object? certificates = null,
    Object? commercialRegister = freezed,
  }) {
    return _then(_CraftsmanDocuments(
      nationalIdFront: freezed == nationalIdFront
          ? _self.nationalIdFront
          : nationalIdFront // ignore: cast_nullable_to_non_nullable
              as String?,
      nationalIdBack: freezed == nationalIdBack
          ? _self.nationalIdBack
          : nationalIdBack // ignore: cast_nullable_to_non_nullable
              as String?,
      nationalIdNumber: freezed == nationalIdNumber
          ? _self.nationalIdNumber
          : nationalIdNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      certificates: null == certificates
          ? _self._certificates
          : certificates // ignore: cast_nullable_to_non_nullable
              as List<String>,
      commercialRegister: freezed == commercialRegister
          ? _self.commercialRegister
          : commercialRegister // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$GeoLocation {
  String get type;
  List<double> get coordinates;

  /// Create a copy of GeoLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GeoLocationCopyWith<GeoLocation> get copyWith =>
      _$GeoLocationCopyWithImpl<GeoLocation>(this as GeoLocation, _$identity);

  /// Serializes this GeoLocation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GeoLocation &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other.coordinates, coordinates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(coordinates));

  @override
  String toString() {
    return 'GeoLocation(type: $type, coordinates: $coordinates)';
  }
}

/// @nodoc
abstract mixin class $GeoLocationCopyWith<$Res> {
  factory $GeoLocationCopyWith(
          GeoLocation value, $Res Function(GeoLocation) _then) =
      _$GeoLocationCopyWithImpl;
  @useResult
  $Res call({String type, List<double> coordinates});
}

/// @nodoc
class _$GeoLocationCopyWithImpl<$Res> implements $GeoLocationCopyWith<$Res> {
  _$GeoLocationCopyWithImpl(this._self, this._then);

  final GeoLocation _self;
  final $Res Function(GeoLocation) _then;

  /// Create a copy of GeoLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? coordinates = null,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      coordinates: null == coordinates
          ? _self.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _GeoLocation implements GeoLocation {
  const _GeoLocation(
      {this.type = 'Point', final List<double> coordinates = const []})
      : _coordinates = coordinates;
  factory _GeoLocation.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationFromJson(json);

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

  /// Create a copy of GeoLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GeoLocationCopyWith<_GeoLocation> get copyWith =>
      __$GeoLocationCopyWithImpl<_GeoLocation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GeoLocationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GeoLocation &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._coordinates, _coordinates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(_coordinates));

  @override
  String toString() {
    return 'GeoLocation(type: $type, coordinates: $coordinates)';
  }
}

/// @nodoc
abstract mixin class _$GeoLocationCopyWith<$Res>
    implements $GeoLocationCopyWith<$Res> {
  factory _$GeoLocationCopyWith(
          _GeoLocation value, $Res Function(_GeoLocation) _then) =
      __$GeoLocationCopyWithImpl;
  @override
  @useResult
  $Res call({String type, List<double> coordinates});
}

/// @nodoc
class __$GeoLocationCopyWithImpl<$Res> implements _$GeoLocationCopyWith<$Res> {
  __$GeoLocationCopyWithImpl(this._self, this._then);

  final _GeoLocation _self;
  final $Res Function(_GeoLocation) _then;

  /// Create a copy of GeoLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? coordinates = null,
  }) {
    return _then(_GeoLocation(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      coordinates: null == coordinates
          ? _self._coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
mixin _$Craftsman {
  @JsonKey(name: '_id')
  String get id;
  String get userId;
  String get displayName;
  String? get bio;
  String? get profileImage;
  String? get coverImage;
  List<String> get workPhotos;
  String? get whatsapp;
  String? get alternatePhone;
  List<ServiceInfo> get services;
  CraftsmanDocuments? get documents;
  String? get address;
  GeoLocation? get location;
  double get serviceRadius;
  List<String> get serviceZones;
  bool get isOnline;
  bool get isAvailable;
  List<WorkingHour> get workingHours;
  CraftsmanStatus get status;
  DateTime? get approvedAt;
  String? get approvedBy;
  String? get rejectionReason;
  String? get suspensionReason;
  double get rating;
  int get totalRatings;
  int get totalJobs;
  int get completedJobs;
  int get cancelledJobs;
  double get responseRate;
  int get responseTime;
  double get totalEarnings;
  double get currentBalance;
  int get commission;
  List<String> get badges;
  bool get isFeatured;
  DateTime? get featuredUntil;
  DateTime? get createdAt;
  DateTime? get updatedAt; // Populated user details
  User?
      get user; // Distance from current location (populated in nearby queries)
  double? get distance;

  /// Create a copy of Craftsman
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CraftsmanCopyWith<Craftsman> get copyWith =>
      _$CraftsmanCopyWithImpl<Craftsman>(this as Craftsman, _$identity);

  /// Serializes this Craftsman to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Craftsman &&
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
                .equals(other.workPhotos, workPhotos) &&
            (identical(other.whatsapp, whatsapp) ||
                other.whatsapp == whatsapp) &&
            (identical(other.alternatePhone, alternatePhone) ||
                other.alternatePhone == alternatePhone) &&
            const DeepCollectionEquality().equals(other.services, services) &&
            (identical(other.documents, documents) ||
                other.documents == documents) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.serviceRadius, serviceRadius) ||
                other.serviceRadius == serviceRadius) &&
            const DeepCollectionEquality()
                .equals(other.serviceZones, serviceZones) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            const DeepCollectionEquality()
                .equals(other.workingHours, workingHours) &&
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
            const DeepCollectionEquality().equals(other.badges, badges) &&
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
        const DeepCollectionEquality().hash(workPhotos),
        whatsapp,
        alternatePhone,
        const DeepCollectionEquality().hash(services),
        documents,
        address,
        location,
        serviceRadius,
        const DeepCollectionEquality().hash(serviceZones),
        isOnline,
        isAvailable,
        const DeepCollectionEquality().hash(workingHours),
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
        const DeepCollectionEquality().hash(badges),
        isFeatured,
        featuredUntil,
        createdAt,
        updatedAt,
        user,
        distance
      ]);

  @override
  String toString() {
    return 'Craftsman(id: $id, userId: $userId, displayName: $displayName, bio: $bio, profileImage: $profileImage, coverImage: $coverImage, workPhotos: $workPhotos, whatsapp: $whatsapp, alternatePhone: $alternatePhone, services: $services, documents: $documents, address: $address, location: $location, serviceRadius: $serviceRadius, serviceZones: $serviceZones, isOnline: $isOnline, isAvailable: $isAvailable, workingHours: $workingHours, status: $status, approvedAt: $approvedAt, approvedBy: $approvedBy, rejectionReason: $rejectionReason, suspensionReason: $suspensionReason, rating: $rating, totalRatings: $totalRatings, totalJobs: $totalJobs, completedJobs: $completedJobs, cancelledJobs: $cancelledJobs, responseRate: $responseRate, responseTime: $responseTime, totalEarnings: $totalEarnings, currentBalance: $currentBalance, commission: $commission, badges: $badges, isFeatured: $isFeatured, featuredUntil: $featuredUntil, createdAt: $createdAt, updatedAt: $updatedAt, user: $user, distance: $distance)';
  }
}

/// @nodoc
abstract mixin class $CraftsmanCopyWith<$Res> {
  factory $CraftsmanCopyWith(Craftsman value, $Res Function(Craftsman) _then) =
      _$CraftsmanCopyWithImpl;
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
class _$CraftsmanCopyWithImpl<$Res> implements $CraftsmanCopyWith<$Res> {
  _$CraftsmanCopyWithImpl(this._self, this._then);

  final Craftsman _self;
  final $Res Function(Craftsman) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      bio: freezed == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _self.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImage: freezed == coverImage
          ? _self.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String?,
      workPhotos: null == workPhotos
          ? _self.workPhotos
          : workPhotos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      whatsapp: freezed == whatsapp
          ? _self.whatsapp
          : whatsapp // ignore: cast_nullable_to_non_nullable
              as String?,
      alternatePhone: freezed == alternatePhone
          ? _self.alternatePhone
          : alternatePhone // ignore: cast_nullable_to_non_nullable
              as String?,
      services: null == services
          ? _self.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<ServiceInfo>,
      documents: freezed == documents
          ? _self.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as CraftsmanDocuments?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoLocation?,
      serviceRadius: null == serviceRadius
          ? _self.serviceRadius
          : serviceRadius // ignore: cast_nullable_to_non_nullable
              as double,
      serviceZones: null == serviceZones
          ? _self.serviceZones
          : serviceZones // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isOnline: null == isOnline
          ? _self.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      isAvailable: null == isAvailable
          ? _self.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      workingHours: null == workingHours
          ? _self.workingHours
          : workingHours // ignore: cast_nullable_to_non_nullable
              as List<WorkingHour>,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as CraftsmanStatus,
      approvedAt: freezed == approvedAt
          ? _self.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedBy: freezed == approvedBy
          ? _self.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectionReason: freezed == rejectionReason
          ? _self.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      suspensionReason: freezed == suspensionReason
          ? _self.suspensionReason
          : suspensionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      totalRatings: null == totalRatings
          ? _self.totalRatings
          : totalRatings // ignore: cast_nullable_to_non_nullable
              as int,
      totalJobs: null == totalJobs
          ? _self.totalJobs
          : totalJobs // ignore: cast_nullable_to_non_nullable
              as int,
      completedJobs: null == completedJobs
          ? _self.completedJobs
          : completedJobs // ignore: cast_nullable_to_non_nullable
              as int,
      cancelledJobs: null == cancelledJobs
          ? _self.cancelledJobs
          : cancelledJobs // ignore: cast_nullable_to_non_nullable
              as int,
      responseRate: null == responseRate
          ? _self.responseRate
          : responseRate // ignore: cast_nullable_to_non_nullable
              as double,
      responseTime: null == responseTime
          ? _self.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as int,
      totalEarnings: null == totalEarnings
          ? _self.totalEarnings
          : totalEarnings // ignore: cast_nullable_to_non_nullable
              as double,
      currentBalance: null == currentBalance
          ? _self.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as double,
      commission: null == commission
          ? _self.commission
          : commission // ignore: cast_nullable_to_non_nullable
              as int,
      badges: null == badges
          ? _self.badges
          : badges // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isFeatured: null == isFeatured
          ? _self.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool,
      featuredUntil: freezed == featuredUntil
          ? _self.featuredUntil
          : featuredUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      distance: freezed == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }

  /// Create a copy of Craftsman
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CraftsmanDocumentsCopyWith<$Res>? get documents {
    if (_self.documents == null) {
      return null;
    }

    return $CraftsmanDocumentsCopyWith<$Res>(_self.documents!, (value) {
      return _then(_self.copyWith(documents: value));
    });
  }

  /// Create a copy of Craftsman
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GeoLocationCopyWith<$Res>? get location {
    if (_self.location == null) {
      return null;
    }

    return $GeoLocationCopyWith<$Res>(_self.location!, (value) {
      return _then(_self.copyWith(location: value));
    });
  }

  /// Create a copy of Craftsman
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
}

/// @nodoc
@JsonSerializable()
class _Craftsman extends Craftsman {
  const _Craftsman(
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
  factory _Craftsman.fromJson(Map<String, dynamic> json) =>
      _$CraftsmanFromJson(json);

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

  /// Create a copy of Craftsman
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CraftsmanCopyWith<_Craftsman> get copyWith =>
      __$CraftsmanCopyWithImpl<_Craftsman>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CraftsmanToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Craftsman &&
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

  @override
  String toString() {
    return 'Craftsman(id: $id, userId: $userId, displayName: $displayName, bio: $bio, profileImage: $profileImage, coverImage: $coverImage, workPhotos: $workPhotos, whatsapp: $whatsapp, alternatePhone: $alternatePhone, services: $services, documents: $documents, address: $address, location: $location, serviceRadius: $serviceRadius, serviceZones: $serviceZones, isOnline: $isOnline, isAvailable: $isAvailable, workingHours: $workingHours, status: $status, approvedAt: $approvedAt, approvedBy: $approvedBy, rejectionReason: $rejectionReason, suspensionReason: $suspensionReason, rating: $rating, totalRatings: $totalRatings, totalJobs: $totalJobs, completedJobs: $completedJobs, cancelledJobs: $cancelledJobs, responseRate: $responseRate, responseTime: $responseTime, totalEarnings: $totalEarnings, currentBalance: $currentBalance, commission: $commission, badges: $badges, isFeatured: $isFeatured, featuredUntil: $featuredUntil, createdAt: $createdAt, updatedAt: $updatedAt, user: $user, distance: $distance)';
  }
}

/// @nodoc
abstract mixin class _$CraftsmanCopyWith<$Res>
    implements $CraftsmanCopyWith<$Res> {
  factory _$CraftsmanCopyWith(
          _Craftsman value, $Res Function(_Craftsman) _then) =
      __$CraftsmanCopyWithImpl;
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
class __$CraftsmanCopyWithImpl<$Res> implements _$CraftsmanCopyWith<$Res> {
  __$CraftsmanCopyWithImpl(this._self, this._then);

  final _Craftsman _self;
  final $Res Function(_Craftsman) _then;

  /// Create a copy of Craftsman
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_Craftsman(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      bio: freezed == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _self.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImage: freezed == coverImage
          ? _self.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String?,
      workPhotos: null == workPhotos
          ? _self._workPhotos
          : workPhotos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      whatsapp: freezed == whatsapp
          ? _self.whatsapp
          : whatsapp // ignore: cast_nullable_to_non_nullable
              as String?,
      alternatePhone: freezed == alternatePhone
          ? _self.alternatePhone
          : alternatePhone // ignore: cast_nullable_to_non_nullable
              as String?,
      services: null == services
          ? _self._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<ServiceInfo>,
      documents: freezed == documents
          ? _self.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as CraftsmanDocuments?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoLocation?,
      serviceRadius: null == serviceRadius
          ? _self.serviceRadius
          : serviceRadius // ignore: cast_nullable_to_non_nullable
              as double,
      serviceZones: null == serviceZones
          ? _self._serviceZones
          : serviceZones // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isOnline: null == isOnline
          ? _self.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      isAvailable: null == isAvailable
          ? _self.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      workingHours: null == workingHours
          ? _self._workingHours
          : workingHours // ignore: cast_nullable_to_non_nullable
              as List<WorkingHour>,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as CraftsmanStatus,
      approvedAt: freezed == approvedAt
          ? _self.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedBy: freezed == approvedBy
          ? _self.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectionReason: freezed == rejectionReason
          ? _self.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      suspensionReason: freezed == suspensionReason
          ? _self.suspensionReason
          : suspensionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      totalRatings: null == totalRatings
          ? _self.totalRatings
          : totalRatings // ignore: cast_nullable_to_non_nullable
              as int,
      totalJobs: null == totalJobs
          ? _self.totalJobs
          : totalJobs // ignore: cast_nullable_to_non_nullable
              as int,
      completedJobs: null == completedJobs
          ? _self.completedJobs
          : completedJobs // ignore: cast_nullable_to_non_nullable
              as int,
      cancelledJobs: null == cancelledJobs
          ? _self.cancelledJobs
          : cancelledJobs // ignore: cast_nullable_to_non_nullable
              as int,
      responseRate: null == responseRate
          ? _self.responseRate
          : responseRate // ignore: cast_nullable_to_non_nullable
              as double,
      responseTime: null == responseTime
          ? _self.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as int,
      totalEarnings: null == totalEarnings
          ? _self.totalEarnings
          : totalEarnings // ignore: cast_nullable_to_non_nullable
              as double,
      currentBalance: null == currentBalance
          ? _self.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as double,
      commission: null == commission
          ? _self.commission
          : commission // ignore: cast_nullable_to_non_nullable
              as int,
      badges: null == badges
          ? _self._badges
          : badges // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isFeatured: null == isFeatured
          ? _self.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool,
      featuredUntil: freezed == featuredUntil
          ? _self.featuredUntil
          : featuredUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      distance: freezed == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }

  /// Create a copy of Craftsman
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CraftsmanDocumentsCopyWith<$Res>? get documents {
    if (_self.documents == null) {
      return null;
    }

    return $CraftsmanDocumentsCopyWith<$Res>(_self.documents!, (value) {
      return _then(_self.copyWith(documents: value));
    });
  }

  /// Create a copy of Craftsman
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GeoLocationCopyWith<$Res>? get location {
    if (_self.location == null) {
      return null;
    }

    return $GeoLocationCopyWith<$Res>(_self.location!, (value) {
      return _then(_self.copyWith(location: value));
    });
  }

  /// Create a copy of Craftsman
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
}

/// @nodoc
mixin _$CraftsmanListResponse {
  List<Craftsman> get data;
  int get page;
  int get limit;
  int get total;
  int get totalPages;

  /// Create a copy of CraftsmanListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CraftsmanListResponseCopyWith<CraftsmanListResponse> get copyWith =>
      _$CraftsmanListResponseCopyWithImpl<CraftsmanListResponse>(
          this as CraftsmanListResponse, _$identity);

  /// Serializes this CraftsmanListResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CraftsmanListResponse &&
            const DeepCollectionEquality().equals(other.data, data) &&
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
      const DeepCollectionEquality().hash(data),
      page,
      limit,
      total,
      totalPages);

  @override
  String toString() {
    return 'CraftsmanListResponse(data: $data, page: $page, limit: $limit, total: $total, totalPages: $totalPages)';
  }
}

/// @nodoc
abstract mixin class $CraftsmanListResponseCopyWith<$Res> {
  factory $CraftsmanListResponseCopyWith(CraftsmanListResponse value,
          $Res Function(CraftsmanListResponse) _then) =
      _$CraftsmanListResponseCopyWithImpl;
  @useResult
  $Res call(
      {List<Craftsman> data, int page, int limit, int total, int totalPages});
}

/// @nodoc
class _$CraftsmanListResponseCopyWithImpl<$Res>
    implements $CraftsmanListResponseCopyWith<$Res> {
  _$CraftsmanListResponseCopyWithImpl(this._self, this._then);

  final CraftsmanListResponse _self;
  final $Res Function(CraftsmanListResponse) _then;

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
    return _then(_self.copyWith(
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Craftsman>,
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
class _CraftsmanListResponse implements CraftsmanListResponse {
  const _CraftsmanListResponse(
      {required final List<Craftsman> data,
      required this.page,
      required this.limit,
      required this.total,
      required this.totalPages})
      : _data = data;
  factory _CraftsmanListResponse.fromJson(Map<String, dynamic> json) =>
      _$CraftsmanListResponseFromJson(json);

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

  /// Create a copy of CraftsmanListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CraftsmanListResponseCopyWith<_CraftsmanListResponse> get copyWith =>
      __$CraftsmanListResponseCopyWithImpl<_CraftsmanListResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CraftsmanListResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CraftsmanListResponse &&
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

  @override
  String toString() {
    return 'CraftsmanListResponse(data: $data, page: $page, limit: $limit, total: $total, totalPages: $totalPages)';
  }
}

/// @nodoc
abstract mixin class _$CraftsmanListResponseCopyWith<$Res>
    implements $CraftsmanListResponseCopyWith<$Res> {
  factory _$CraftsmanListResponseCopyWith(_CraftsmanListResponse value,
          $Res Function(_CraftsmanListResponse) _then) =
      __$CraftsmanListResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<Craftsman> data, int page, int limit, int total, int totalPages});
}

/// @nodoc
class __$CraftsmanListResponseCopyWithImpl<$Res>
    implements _$CraftsmanListResponseCopyWith<$Res> {
  __$CraftsmanListResponseCopyWithImpl(this._self, this._then);

  final _CraftsmanListResponse _self;
  final $Res Function(_CraftsmanListResponse) _then;

  /// Create a copy of CraftsmanListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = null,
    Object? page = null,
    Object? limit = null,
    Object? total = null,
    Object? totalPages = null,
  }) {
    return _then(_CraftsmanListResponse(
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Craftsman>,
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
