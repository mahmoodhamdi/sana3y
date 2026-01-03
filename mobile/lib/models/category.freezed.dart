// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubCategory {
  @JsonKey(name: '_id')
  String get id;
  String get name;
  String get nameAr;
  SuggestedPrice? get suggestedPrice;

  /// Create a copy of SubCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubCategoryCopyWith<SubCategory> get copyWith =>
      _$SubCategoryCopyWithImpl<SubCategory>(this as SubCategory, _$identity);

  /// Serializes this SubCategory to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SubCategory &&
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

  @override
  String toString() {
    return 'SubCategory(id: $id, name: $name, nameAr: $nameAr, suggestedPrice: $suggestedPrice)';
  }
}

/// @nodoc
abstract mixin class $SubCategoryCopyWith<$Res> {
  factory $SubCategoryCopyWith(
          SubCategory value, $Res Function(SubCategory) _then) =
      _$SubCategoryCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String nameAr,
      SuggestedPrice? suggestedPrice});

  $SuggestedPriceCopyWith<$Res>? get suggestedPrice;
}

/// @nodoc
class _$SubCategoryCopyWithImpl<$Res> implements $SubCategoryCopyWith<$Res> {
  _$SubCategoryCopyWithImpl(this._self, this._then);

  final SubCategory _self;
  final $Res Function(SubCategory) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameAr: null == nameAr
          ? _self.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedPrice: freezed == suggestedPrice
          ? _self.suggestedPrice
          : suggestedPrice // ignore: cast_nullable_to_non_nullable
              as SuggestedPrice?,
    ));
  }

  /// Create a copy of SubCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SuggestedPriceCopyWith<$Res>? get suggestedPrice {
    if (_self.suggestedPrice == null) {
      return null;
    }

    return $SuggestedPriceCopyWith<$Res>(_self.suggestedPrice!, (value) {
      return _then(_self.copyWith(suggestedPrice: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _SubCategory implements SubCategory {
  const _SubCategory(
      {@JsonKey(name: '_id') required this.id,
      required this.name,
      required this.nameAr,
      this.suggestedPrice});
  factory _SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String name;
  @override
  final String nameAr;
  @override
  final SuggestedPrice? suggestedPrice;

  /// Create a copy of SubCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubCategoryCopyWith<_SubCategory> get copyWith =>
      __$SubCategoryCopyWithImpl<_SubCategory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SubCategoryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubCategory &&
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

  @override
  String toString() {
    return 'SubCategory(id: $id, name: $name, nameAr: $nameAr, suggestedPrice: $suggestedPrice)';
  }
}

/// @nodoc
abstract mixin class _$SubCategoryCopyWith<$Res>
    implements $SubCategoryCopyWith<$Res> {
  factory _$SubCategoryCopyWith(
          _SubCategory value, $Res Function(_SubCategory) _then) =
      __$SubCategoryCopyWithImpl;
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
class __$SubCategoryCopyWithImpl<$Res> implements _$SubCategoryCopyWith<$Res> {
  __$SubCategoryCopyWithImpl(this._self, this._then);

  final _SubCategory _self;
  final $Res Function(_SubCategory) _then;

  /// Create a copy of SubCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameAr = null,
    Object? suggestedPrice = freezed,
  }) {
    return _then(_SubCategory(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameAr: null == nameAr
          ? _self.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedPrice: freezed == suggestedPrice
          ? _self.suggestedPrice
          : suggestedPrice // ignore: cast_nullable_to_non_nullable
              as SuggestedPrice?,
    ));
  }

  /// Create a copy of SubCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SuggestedPriceCopyWith<$Res>? get suggestedPrice {
    if (_self.suggestedPrice == null) {
      return null;
    }

    return $SuggestedPriceCopyWith<$Res>(_self.suggestedPrice!, (value) {
      return _then(_self.copyWith(suggestedPrice: value));
    });
  }
}

/// @nodoc
mixin _$SuggestedPrice {
  double? get min;
  double? get max;

  /// Create a copy of SuggestedPrice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SuggestedPriceCopyWith<SuggestedPrice> get copyWith =>
      _$SuggestedPriceCopyWithImpl<SuggestedPrice>(
          this as SuggestedPrice, _$identity);

  /// Serializes this SuggestedPrice to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SuggestedPrice &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, min, max);

  @override
  String toString() {
    return 'SuggestedPrice(min: $min, max: $max)';
  }
}

/// @nodoc
abstract mixin class $SuggestedPriceCopyWith<$Res> {
  factory $SuggestedPriceCopyWith(
          SuggestedPrice value, $Res Function(SuggestedPrice) _then) =
      _$SuggestedPriceCopyWithImpl;
  @useResult
  $Res call({double? min, double? max});
}

/// @nodoc
class _$SuggestedPriceCopyWithImpl<$Res>
    implements $SuggestedPriceCopyWith<$Res> {
  _$SuggestedPriceCopyWithImpl(this._self, this._then);

  final SuggestedPrice _self;
  final $Res Function(SuggestedPrice) _then;

  /// Create a copy of SuggestedPrice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = freezed,
    Object? max = freezed,
  }) {
    return _then(_self.copyWith(
      min: freezed == min
          ? _self.min
          : min // ignore: cast_nullable_to_non_nullable
              as double?,
      max: freezed == max
          ? _self.max
          : max // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SuggestedPrice implements SuggestedPrice {
  const _SuggestedPrice({this.min, this.max});
  factory _SuggestedPrice.fromJson(Map<String, dynamic> json) =>
      _$SuggestedPriceFromJson(json);

  @override
  final double? min;
  @override
  final double? max;

  /// Create a copy of SuggestedPrice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SuggestedPriceCopyWith<_SuggestedPrice> get copyWith =>
      __$SuggestedPriceCopyWithImpl<_SuggestedPrice>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SuggestedPriceToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SuggestedPrice &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, min, max);

  @override
  String toString() {
    return 'SuggestedPrice(min: $min, max: $max)';
  }
}

/// @nodoc
abstract mixin class _$SuggestedPriceCopyWith<$Res>
    implements $SuggestedPriceCopyWith<$Res> {
  factory _$SuggestedPriceCopyWith(
          _SuggestedPrice value, $Res Function(_SuggestedPrice) _then) =
      __$SuggestedPriceCopyWithImpl;
  @override
  @useResult
  $Res call({double? min, double? max});
}

/// @nodoc
class __$SuggestedPriceCopyWithImpl<$Res>
    implements _$SuggestedPriceCopyWith<$Res> {
  __$SuggestedPriceCopyWithImpl(this._self, this._then);

  final _SuggestedPrice _self;
  final $Res Function(_SuggestedPrice) _then;

  /// Create a copy of SuggestedPrice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? min = freezed,
    Object? max = freezed,
  }) {
    return _then(_SuggestedPrice(
      min: freezed == min
          ? _self.min
          : min // ignore: cast_nullable_to_non_nullable
              as double?,
      max: freezed == max
          ? _self.max
          : max // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
mixin _$Category {
  @JsonKey(name: '_id')
  String get id;
  String get name;
  String get nameAr;
  String get slug;
  String? get icon;
  String? get image;
  String? get description;
  String? get descriptionAr;
  List<SubCategory> get subcategories;
  int get sortOrder;
  bool get isActive;
  bool get isPopular;
  int get totalCraftsmen;
  int get totalJobs;
  DateTime? get createdAt;
  DateTime? get updatedAt;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<Category> get copyWith =>
      _$CategoryCopyWithImpl<Category>(this as Category, _$identity);

  /// Serializes this Category to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Category &&
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
                .equals(other.subcategories, subcategories) &&
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
      const DeepCollectionEquality().hash(subcategories),
      sortOrder,
      isActive,
      isPopular,
      totalCraftsmen,
      totalJobs,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'Category(id: $id, name: $name, nameAr: $nameAr, slug: $slug, icon: $icon, image: $image, description: $description, descriptionAr: $descriptionAr, subcategories: $subcategories, sortOrder: $sortOrder, isActive: $isActive, isPopular: $isPopular, totalCraftsmen: $totalCraftsmen, totalJobs: $totalJobs, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $CategoryCopyWith<$Res> {
  factory $CategoryCopyWith(Category value, $Res Function(Category) _then) =
      _$CategoryCopyWithImpl;
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
class _$CategoryCopyWithImpl<$Res> implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._self, this._then);

  final Category _self;
  final $Res Function(Category) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameAr: null == nameAr
          ? _self.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _self.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionAr: freezed == descriptionAr
          ? _self.descriptionAr
          : descriptionAr // ignore: cast_nullable_to_non_nullable
              as String?,
      subcategories: null == subcategories
          ? _self.subcategories
          : subcategories // ignore: cast_nullable_to_non_nullable
              as List<SubCategory>,
      sortOrder: null == sortOrder
          ? _self.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isPopular: null == isPopular
          ? _self.isPopular
          : isPopular // ignore: cast_nullable_to_non_nullable
              as bool,
      totalCraftsmen: null == totalCraftsmen
          ? _self.totalCraftsmen
          : totalCraftsmen // ignore: cast_nullable_to_non_nullable
              as int,
      totalJobs: null == totalJobs
          ? _self.totalJobs
          : totalJobs // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Category extends Category {
  const _Category(
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
  factory _Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

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

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CategoryCopyWith<_Category> get copyWith =>
      __$CategoryCopyWithImpl<_Category>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CategoryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Category &&
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

  @override
  String toString() {
    return 'Category(id: $id, name: $name, nameAr: $nameAr, slug: $slug, icon: $icon, image: $image, description: $description, descriptionAr: $descriptionAr, subcategories: $subcategories, sortOrder: $sortOrder, isActive: $isActive, isPopular: $isPopular, totalCraftsmen: $totalCraftsmen, totalJobs: $totalJobs, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$CategoryCopyWith<$Res>
    implements $CategoryCopyWith<$Res> {
  factory _$CategoryCopyWith(_Category value, $Res Function(_Category) _then) =
      __$CategoryCopyWithImpl;
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
class __$CategoryCopyWithImpl<$Res> implements _$CategoryCopyWith<$Res> {
  __$CategoryCopyWithImpl(this._self, this._then);

  final _Category _self;
  final $Res Function(_Category) _then;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_Category(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameAr: null == nameAr
          ? _self.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _self.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionAr: freezed == descriptionAr
          ? _self.descriptionAr
          : descriptionAr // ignore: cast_nullable_to_non_nullable
              as String?,
      subcategories: null == subcategories
          ? _self._subcategories
          : subcategories // ignore: cast_nullable_to_non_nullable
              as List<SubCategory>,
      sortOrder: null == sortOrder
          ? _self.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isPopular: null == isPopular
          ? _self.isPopular
          : isPopular // ignore: cast_nullable_to_non_nullable
              as bool,
      totalCraftsmen: null == totalCraftsmen
          ? _self.totalCraftsmen
          : totalCraftsmen // ignore: cast_nullable_to_non_nullable
              as int,
      totalJobs: null == totalJobs
          ? _self.totalJobs
          : totalJobs // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
