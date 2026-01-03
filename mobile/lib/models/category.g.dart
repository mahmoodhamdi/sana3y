// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubCategoryImpl _$$SubCategoryImplFromJson(Map<String, dynamic> json) =>
    _$SubCategoryImpl(
      id: json['_id'] as String,
      name: json['name'] as String,
      nameAr: json['nameAr'] as String,
      suggestedPrice: json['suggestedPrice'] == null
          ? null
          : SuggestedPrice.fromJson(
              json['suggestedPrice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SubCategoryImplToJson(_$SubCategoryImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'nameAr': instance.nameAr,
      'suggestedPrice': instance.suggestedPrice,
    };

_$SuggestedPriceImpl _$$SuggestedPriceImplFromJson(Map<String, dynamic> json) =>
    _$SuggestedPriceImpl(
      min: (json['min'] as num?)?.toDouble(),
      max: (json['max'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$SuggestedPriceImplToJson(
        _$SuggestedPriceImpl instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
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

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) =>
    <String, dynamic>{
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
