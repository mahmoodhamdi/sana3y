// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QualityRatingsImpl _$$QualityRatingsImplFromJson(Map<String, dynamic> json) =>
    _$QualityRatingsImpl(
      punctuality: (json['punctuality'] as num?)?.toInt(),
      professionalism: (json['professionalism'] as num?)?.toInt(),
      quality: (json['quality'] as num?)?.toInt(),
      cleanliness: (json['cleanliness'] as num?)?.toInt(),
      communication: (json['communication'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$QualityRatingsImplToJson(
        _$QualityRatingsImpl instance) =>
    <String, dynamic>{
      'punctuality': instance.punctuality,
      'professionalism': instance.professionalism,
      'quality': instance.quality,
      'cleanliness': instance.cleanliness,
      'communication': instance.communication,
    };

_$ReviewCustomerImpl _$$ReviewCustomerImplFromJson(Map<String, dynamic> json) =>
    _$ReviewCustomerImpl(
      id: json['_id'] as String,
      userId: json['userId'] == null
          ? null
          : ReviewCustomerUser.fromJson(json['userId'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ReviewCustomerImplToJson(
        _$ReviewCustomerImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
    };

_$ReviewCustomerUserImpl _$$ReviewCustomerUserImplFromJson(
        Map<String, dynamic> json) =>
    _$ReviewCustomerUserImpl(
      id: json['_id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$$ReviewCustomerUserImplToJson(
        _$ReviewCustomerUserImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
    };

_$ReviewRequestImpl _$$ReviewRequestImplFromJson(Map<String, dynamic> json) =>
    _$ReviewRequestImpl(
      id: json['_id'] as String,
      requestNumber: json['requestNumber'] as String,
      title: json['title'] as String,
      category: json['category'] == null
          ? null
          : ReviewCategory.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ReviewRequestImplToJson(_$ReviewRequestImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'requestNumber': instance.requestNumber,
      'title': instance.title,
      'category': instance.category,
    };

_$ReviewCategoryImpl _$$ReviewCategoryImplFromJson(Map<String, dynamic> json) =>
    _$ReviewCategoryImpl(
      id: json['_id'] as String,
      nameAr: json['nameAr'] as String,
    );

Map<String, dynamic> _$$ReviewCategoryImplToJson(
        _$ReviewCategoryImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'nameAr': instance.nameAr,
    };

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
      id: json['_id'] as String,
      requestId: json['requestId'] as String,
      customerId: json['customerId'] as String,
      craftsmanId: json['craftsmanId'] as String,
      score: (json['score'] as num).toInt(),
      comment: json['comment'] as String?,
      qualities: json['qualities'] == null
          ? const QualityRatings()
          : QualityRatings.fromJson(json['qualities'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      craftsmanResponse: json['craftsmanResponse'] as String?,
      respondedAt: json['respondedAt'] == null
          ? null
          : DateTime.parse(json['respondedAt'] as String),
      isVisible: json['isVisible'] as bool? ?? true,
      isReported: json['isReported'] as bool? ?? false,
      reportReason: json['reportReason'] as String?,
      customer: json['customer'] == null
          ? null
          : ReviewCustomer.fromJson(json['customer'] as Map<String, dynamic>),
      request: json['request'] == null
          ? null
          : ReviewRequest.fromJson(json['request'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'requestId': instance.requestId,
      'customerId': instance.customerId,
      'craftsmanId': instance.craftsmanId,
      'score': instance.score,
      'comment': instance.comment,
      'qualities': instance.qualities,
      'images': instance.images,
      'craftsmanResponse': instance.craftsmanResponse,
      'respondedAt': instance.respondedAt?.toIso8601String(),
      'isVisible': instance.isVisible,
      'isReported': instance.isReported,
      'reportReason': instance.reportReason,
      'customer': instance.customer,
      'request': instance.request,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$ReviewsSummaryImpl _$$ReviewsSummaryImplFromJson(Map<String, dynamic> json) =>
    _$ReviewsSummaryImpl(
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0,
      totalReviews: (json['totalReviews'] as num?)?.toInt() ?? 0,
      ratingDistribution:
          (json['ratingDistribution'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toInt()),
              ) ??
              const {},
      qualityAverages: (json['qualityAverages'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
    );

Map<String, dynamic> _$$ReviewsSummaryImplToJson(
        _$ReviewsSummaryImpl instance) =>
    <String, dynamic>{
      'averageRating': instance.averageRating,
      'totalReviews': instance.totalReviews,
      'ratingDistribution': instance.ratingDistribution,
      'qualityAverages': instance.qualityAverages,
    };

_$CreateReviewDataImpl _$$CreateReviewDataImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateReviewDataImpl(
      requestId: json['requestId'] as String,
      score: (json['score'] as num).toInt(),
      comment: json['comment'] as String?,
      qualities: json['qualities'] == null
          ? null
          : QualityRatings.fromJson(json['qualities'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CreateReviewDataImplToJson(
        _$CreateReviewDataImpl instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'score': instance.score,
      'comment': instance.comment,
      'qualities': instance.qualities,
      'images': instance.images,
    };

_$ReviewListResponseImpl _$$ReviewListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ReviewListResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$$ReviewListResponseImplToJson(
        _$ReviewListResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'page': instance.page,
      'totalPages': instance.totalPages,
      'total': instance.total,
      'limit': instance.limit,
    };
