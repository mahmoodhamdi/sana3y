// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) {
  return _SubCategory.fromJson(json);
}

/// @nodoc
mixin _$SubCategory {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get nameAr => throw _privateConstructorUsedError;
  SuggestedPrice? get suggestedPrice => throw _privateConstructorUsedError;

  /// Serializes this SubCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubCategoryCopyWith<SubCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubCategoryCopyWith<$Res> {
  factory $SubCategoryCopyWith(
          SubCategory value, $Res Function(SubCategory) then) =
      _$SubCategoryCopyWithImpl<$Res, SubCategory>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String nameAr,
      SuggestedPrice? suggestedPrice});

  $SuggestedPriceCopyWith<$Res>? get suggestedPrice;
}

/// @nodoc
class _$SubCategoryCopyWithImpl<$Res, $Val extends SubCategory>
    implements $SubCategoryCopyWith<$Res> {
  _$SubCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameAr = null,
    Object? suggestedPrice = freezed,
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
      nameAr: null == nameAr
          ? _value.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedPrice: freezed == suggestedPrice
          ? _value.suggestedPrice
          : suggestedPrice // ignore: cast_nullable_to_non_nullable
              as SuggestedPrice?,
    ) as $Val);
  }

  /// Create a copy of SubCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SuggestedPriceCopyWith<$Res>? get suggestedPrice {
    if (_value.suggestedPrice == null) {
      return null;
    }

    return $SuggestedPriceCopyWith<$Res>(_value.suggestedPrice!, (value) {
      return _then(_value.copyWith(suggestedPrice: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SubCategoryImplCopyWith<$Res>
    implements $SubCategoryCopyWith<$Res> {
  factory _$$SubCategoryImplCopyWith(
          _$SubCategoryImpl value, $Res Function(_$SubCategoryImpl) then) =
      __$$SubCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String nameAr,
      SuggestedPrice? suggestedPrice});

  @override
  $SuggestedPriceCopyWith<$Res>? get suggestedPrice;
}

/// @nodoc
class __$$SubCategoryImplCopyWithImpl<$Res>
    extends _$SubCategoryCopyWithImpl<$Res, _$SubCategoryImpl>
    implements _$$SubCategoryImplCopyWith<$Res> {
  __$$SubCategoryImplCopyWithImpl(
      _$SubCategoryImpl _value, $Res Function(_$SubCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameAr = null,
    Object? suggestedPrice = freezed,
  }) {
    return _then(_$SubCategoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameAr: null == nameAr
          ? _value.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedPrice: freezed == suggestedPrice
          ? _value.suggestedPrice
          : suggestedPrice // ignore: cast_nullable_to_non_nullable
              as SuggestedPrice?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubCategoryImpl implements _SubCategory {
  const _$SubCategoryImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.name,
      required this.nameAr,
      this.suggestedPrice});

  factory _$SubCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubCategoryImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String name;
  @override
  final String nameAr;
  @override
  final SuggestedPrice? suggestedPrice;

  @override
  String toString() {
    return 'SubCategory(id: $id, name: $name, nameAr: $nameAr, suggestedPrice: $suggestedPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.suggestedPrice, suggestedPrice) ||
                other.suggestedPrice == suggestedPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, nameAr, suggestedPrice);

  /// Create a copy of SubCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubCategoryImplCopyWith<_$SubCategoryImpl> get copyWith =>
      __$$SubCategoryImplCopyWithImpl<_$SubCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubCategoryImplToJson(
      this,
    );
  }
}

abstract class _SubCategory implements SubCategory {
  const factory _SubCategory(
      {@JsonKey(name: '_id') required final String id,
      required final String name,
      required final String nameAr,
      final SuggestedPrice? suggestedPrice}) = _$SubCategoryImpl;

  factory _SubCategory.fromJson(Map<String, dynamic> json) =
      _$SubCategoryImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;
  @override
  String get nameAr;
  @override
  SuggestedPrice? get suggestedPrice;

  /// Create a copy of SubCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubCategoryImplCopyWith<_$SubCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SuggestedPrice _$SuggestedPriceFromJson(Map<String, dynamic> json) {
  return _SuggestedPrice.fromJson(json);
}

/// @nodoc
mixin _$SuggestedPrice {
  double? get min => throw _privateConstructorUsedError;
  double? get max => throw _privateConstructorUsedError;

  /// Serializes this SuggestedPrice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SuggestedPrice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SuggestedPriceCopyWith<SuggestedPrice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuggestedPriceCopyWith<$Res> {
  factory $SuggestedPriceCopyWith(
          SuggestedPrice value, $Res Function(SuggestedPrice) then) =
      _$SuggestedPriceCopyWithImpl<$Res, SuggestedPrice>;
  @useResult
  $Res call({double? min, double? max});
}

/// @nodoc
class _$SuggestedPriceCopyWithImpl<$Res, $Val extends SuggestedPrice>
    implements $SuggestedPriceCopyWith<$Res> {
  _$SuggestedPriceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SuggestedPrice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = freezed,
    Object? max = freezed,
  }) {
    return _then(_value.copyWith(
      min: freezed == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as double?,
      max: freezed == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SuggestedPriceImplCopyWith<$Res>
    implements $SuggestedPriceCopyWith<$Res> {
  factory _$$SuggestedPriceImplCopyWith(_$SuggestedPriceImpl value,
          $Res Function(_$SuggestedPriceImpl) then) =
      __$$SuggestedPriceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? min, double? max});
}

/// @nodoc
class __$$SuggestedPriceImplCopyWithImpl<$Res>
    extends _$SuggestedPriceCopyWithImpl<$Res, _$SuggestedPriceImpl>
    implements _$$SuggestedPriceImplCopyWith<$Res> {
  __$$SuggestedPriceImplCopyWithImpl(
      _$SuggestedPriceImpl _value, $Res Function(_$SuggestedPriceImpl) _then)
      : super(_value, _then);

  /// Create a copy of SuggestedPrice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = freezed,
    Object? max = freezed,
  }) {
    return _then(_$SuggestedPriceImpl(
      min: freezed == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as double?,
      max: freezed == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SuggestedPriceImpl implements _SuggestedPrice {
  const _$SuggestedPriceImpl({this.min, this.max});

  factory _$SuggestedPriceImpl.fromJson(Map<String, dynamic> json) =>
      _$$SuggestedPriceImplFromJson(json);

  @override
  final double? min;
  @override
  final double? max;

  @override
  String toString() {
    return 'SuggestedPrice(min: $min, max: $max)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuggestedPriceImpl &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, min, max);

  /// Create a copy of SuggestedPrice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuggestedPriceImplCopyWith<_$SuggestedPriceImpl> get copyWith =>
      __$$SuggestedPriceImplCopyWithImpl<_$SuggestedPriceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SuggestedPriceImplToJson(
      this,
    );
  }
}

abstract class _SuggestedPrice implements SuggestedPrice {
  const factory _SuggestedPrice({final double? min, final double? max}) =
      _$SuggestedPriceImpl;

  factory _SuggestedPrice.fromJson(Map<String, dynamic> json) =
      _$SuggestedPriceImpl.fromJson;

  @override
  double? get min;
  @override
  double? get max;

  /// Create a copy of SuggestedPrice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuggestedPriceImplCopyWith<_$SuggestedPriceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return _Category.fromJson(json);
}

/// @nodoc
mixin _$Category {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get nameAr => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get descriptionAr => throw _privateConstructorUsedError;
  List<SubCategory> get subcategories => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isPopular => throw _privateConstructorUsedError;
  int get totalCraftsmen => throw _privateConstructorUsedError;
  int get totalJobs => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Category to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryCopyWith<Category> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryCopyWith<$Res> {
  factory $CategoryCopyWith(Category value, $Res Function(Category) then) =
      _$CategoryCopyWithImpl<$Res, Category>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String nameAr,
      String slug,
      String? icon,
      String? image,
      String? description,
      String? descriptionAr,
      List<SubCategory> subcategories,
      int sortOrder,
      bool isActive,
      bool isPopular,
      int totalCraftsmen,
      int totalJobs,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$CategoryCopyWithImpl<$Res, $Val extends Category>
    implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameAr = null,
    Object? slug = null,
    Object? icon = freezed,
    Object? image = freezed,
    Object? description = freezed,
    Object? descriptionAr = freezed,
    Object? subcategories = null,
    Object? sortOrder = null,
    Object? isActive = null,
    Object? isPopular = null,
    Object? totalCraftsmen = null,
    Object? totalJobs = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      nameAr: null == nameAr
          ? _value.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionAr: freezed == descriptionAr
          ? _value.descriptionAr
          : descriptionAr // ignore: cast_nullable_to_non_nullable
              as String?,
      subcategories: null == subcategories
          ? _value.subcategories
          : subcategories // ignore: cast_nullable_to_non_nullable
              as List<SubCategory>,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isPopular: null == isPopular
          ? _value.isPopular
          : isPopular // ignore: cast_nullable_to_non_nullable
              as bool,
      totalCraftsmen: null == totalCraftsmen
          ? _value.totalCraftsmen
          : totalCraftsmen // ignore: cast_nullable_to_non_nullable
              as int,
      totalJobs: null == totalJobs
          ? _value.totalJobs
          : totalJobs // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoryImplCopyWith<$Res>
    implements $CategoryCopyWith<$Res> {
  factory _$$CategoryImplCopyWith(
          _$CategoryImpl value, $Res Function(_$CategoryImpl) then) =
      __$$CategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String nameAr,
      String slug,
      String? icon,
      String? image,
      String? description,
      String? descriptionAr,
      List<SubCategory> subcategories,
      int sortOrder,
      bool isActive,
      bool isPopular,
      int totalCraftsmen,
      int totalJobs,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$CategoryImplCopyWithImpl<$Res>
    extends _$CategoryCopyWithImpl<$Res, _$CategoryImpl>
    implements _$$CategoryImplCopyWith<$Res> {
  __$$CategoryImplCopyWithImpl(
      _$CategoryImpl _value, $Res Function(_$CategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameAr = null,
    Object? slug = null,
    Object? icon = freezed,
    Object? image = freezed,
    Object? description = freezed,
    Object? descriptionAr = freezed,
    Object? subcategories = null,
    Object? sortOrder = null,
    Object? isActive = null,
    Object? isPopular = null,
    Object? totalCraftsmen = null,
    Object? totalJobs = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$CategoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameAr: null == nameAr
          ? _value.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionAr: freezed == descriptionAr
          ? _value.descriptionAr
          : descriptionAr // ignore: cast_nullable_to_non_nullable
              as String?,
      subcategories: null == subcategories
          ? _value._subcategories
          : subcategories // ignore: cast_nullable_to_non_nullable
              as List<SubCategory>,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isPopular: null == isPopular
          ? _value.isPopular
          : isPopular // ignore: cast_nullable_to_non_nullable
              as bool,
      totalCraftsmen: null == totalCraftsmen
          ? _value.totalCraftsmen
          : totalCraftsmen // ignore: cast_nullable_to_non_nullable
              as int,
      totalJobs: null == totalJobs
          ? _value.totalJobs
          : totalJobs // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryImpl extends _Category {
  const _$CategoryImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.name,
      required this.nameAr,
      required this.slug,
      this.icon,
      this.image,
      this.description,
      this.descriptionAr,
      final List<SubCategory> subcategories = const [],
      this.sortOrder = 0,
      this.isActive = true,
      this.isPopular = false,
      this.totalCraftsmen = 0,
      this.totalJobs = 0,
      this.createdAt,
      this.updatedAt})
      : _subcategories = subcategories,
        super._();

  factory _$CategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String name;
  @override
  final String nameAr;
  @override
  final String slug;
  @override
  final String? icon;
  @override
  final String? image;
  @override
  final String? description;
  @override
  final String? descriptionAr;
  final List<SubCategory> _subcategories;
  @override
  @JsonKey()
  List<SubCategory> get subcategories {
    if (_subcategories is EqualUnmodifiableListView) return _subcategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subcategories);
  }

  @override
  @JsonKey()
  final int sortOrder;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isPopular;
  @override
  @JsonKey()
  final int totalCraftsmen;
  @override
  @JsonKey()
  final int totalJobs;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Category(id: $id, name: $name, nameAr: $nameAr, slug: $slug, icon: $icon, image: $image, description: $description, descriptionAr: $descriptionAr, subcategories: $subcategories, sortOrder: $sortOrder, isActive: $isActive, isPopular: $isPopular, totalCraftsmen: $totalCraftsmen, totalJobs: $totalJobs, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.descriptionAr, descriptionAr) ||
                other.descriptionAr == descriptionAr) &&
            const DeepCollectionEquality()
                .equals(other._subcategories, _subcategories) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isPopular, isPopular) ||
                other.isPopular == isPopular) &&
            (identical(other.totalCraftsmen, totalCraftsmen) ||
                other.totalCraftsmen == totalCraftsmen) &&
            (identical(other.totalJobs, totalJobs) ||
                other.totalJobs == totalJobs) &&
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
      name,
      nameAr,
      slug,
      icon,
      image,
      description,
      descriptionAr,
      const DeepCollectionEquality().hash(_subcategories),
      sortOrder,
      isActive,
      isPopular,
      totalCraftsmen,
      totalJobs,
      createdAt,
      updatedAt);

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      __$$CategoryImplCopyWithImpl<_$CategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryImplToJson(
      this,
    );
  }
}

abstract class _Category extends Category {
  const factory _Category(
      {@JsonKey(name: '_id') required final String id,
      required final String name,
      required final String nameAr,
      required final String slug,
      final String? icon,
      final String? image,
      final String? description,
      final String? descriptionAr,
      final List<SubCategory> subcategories,
      final int sortOrder,
      final bool isActive,
      final bool isPopular,
      final int totalCraftsmen,
      final int totalJobs,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$CategoryImpl;
  const _Category._() : super._();

  factory _Category.fromJson(Map<String, dynamic> json) =
      _$CategoryImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;
  @override
  String get nameAr;
  @override
  String get slug;
  @override
  String? get icon;
  @override
  String? get image;
  @override
  String? get description;
  @override
  String? get descriptionAr;
  @override
  List<SubCategory> get subcategories;
  @override
  int get sortOrder;
  @override
  bool get isActive;
  @override
  bool get isPopular;
  @override
  int get totalCraftsmen;
  @override
  int get totalJobs;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
