import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class SubCategory with _$SubCategory {
  const factory SubCategory({
    @JsonKey(name: '_id') required String id,
    required String name,
    required String nameAr,
    SuggestedPrice? suggestedPrice,
  }) = _SubCategory;

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);
}

@freezed
class SuggestedPrice with _$SuggestedPrice {
  const factory SuggestedPrice({
    double? min,
    double? max,
  }) = _SuggestedPrice;

  factory SuggestedPrice.fromJson(Map<String, dynamic> json) =>
      _$SuggestedPriceFromJson(json);
}

@freezed
class Category with _$Category {
  const Category._();

  const factory Category({
    @JsonKey(name: '_id') required String id,
    required String name,
    required String nameAr,
    required String slug,
    String? icon,
    String? image,
    String? description,
    String? descriptionAr,
    @Default([]) List<SubCategory> subcategories,
    @Default(0) int sortOrder,
    @Default(true) bool isActive,
    @Default(false) bool isPopular,
    @Default(0) int totalCraftsmen,
    @Default(0) int totalJobs,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  /// Get display name (Arabic by default)
  String get displayName => nameAr;

  /// Get display description
  String? get displayDescription => descriptionAr ?? description;

  /// Check if category has craftsmen
  bool get hasCraftsmen => totalCraftsmen > 0;
}
