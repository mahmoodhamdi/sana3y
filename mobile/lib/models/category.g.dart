// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) => _SubCategory(
      id: json['_id'] as String,
      name: json['name'] as String,
      nameAr: json['nameAr'] as String,
      suggestedPrice: json['suggestedPrice'] == null
          ? null
          : SuggestedPrice.fromJson(
              json['suggestedPrice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubCategoryToJson(_SubCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'nameAr': instance.nameAr,
      'suggestedPrice': instance.suggestedPrice,
    };

_SuggestedPrice _$SuggestedPriceFromJson(Map<String, dynamic> json) =>
    _SuggestedPrice(
      min: (json['min'] as num?)?.toDouble(),
      max: (json['max'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SuggestedPriceToJson(_SuggestedPrice instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };

_Category _$CategoryFromJson(Map<String, dynamic> json) => _Category(
      id: json['_id'] as String,
      name: json['name'] as String,
      nameAr: json['nameAr'] as String,
      slug: json['slug'] as String,
      icon: json['icon'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      descriptionAr: json['descriptionAr'] as String?,
      subcategories: (json['subcategories'] as List<dynamic>?)
              ?.map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
      isPopular: json['isPopular'] as bool? ?? false,
      totalCraftsmen: (json['totalCraftsmen'] as num?)?.toInt() ?? 0,
      totalJobs: (json['totalJobs'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CategoryToJson(_Category instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'nameAr': instance.nameAr,
      'slug': instance.slug,
      'icon': instance.icon,
      'image': instance.image,
      'description': instance.description,
      'descriptionAr': instance.descriptionAr,
      'subcategories': instance.subcategories,
      'sortOrder': instance.sortOrder,
      'isActive': instance.isActive,
      'isPopular': instance.isPopular,
      'totalCraftsmen': instance.totalCraftsmen,
      'totalJobs': instance.totalJobs,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
