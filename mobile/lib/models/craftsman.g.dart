// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'craftsman.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceInfoImpl _$$ServiceInfoImplFromJson(Map<String, dynamic> json) =>
    _$ServiceInfoImpl(
      categoryId: json['categoryId'] as String,
      subcategories: (json['subcategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      experience: (json['experience'] as num?)?.toInt() ?? 0,
      priceType: $enumDecodeNullable(_$PriceTypeEnumMap, json['priceType']) ??
          PriceType.quote,
      basePrice: (json['basePrice'] as num?)?.toDouble(),
      description: json['description'] as String?,
      category: json['category'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ServiceInfoImplToJson(_$ServiceInfoImpl instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'subcategories': instance.subcategories,
      'experience': instance.experience,
      'priceType': _$PriceTypeEnumMap[instance.priceType]!,
      'basePrice': instance.basePrice,
      'description': instance.description,
      'category': instance.category,
    };

const _$PriceTypeEnumMap = {
  PriceType.fixed: 'fixed',
  PriceType.hourly: 'hourly',
  PriceType.quote: 'quote',
};

_$WorkingHourImpl _$$WorkingHourImplFromJson(Map<String, dynamic> json) =>
    _$WorkingHourImpl(
      day: (json['day'] as num).toInt(),
      isWorking: json['isWorking'] as bool? ?? true,
      start: json['start'] as String? ?? '08:00',
      end: json['end'] as String? ?? '20:00',
    );

Map<String, dynamic> _$$WorkingHourImplToJson(_$WorkingHourImpl instance) =>
    <String, dynamic>{
      'day': instance.day,
      'isWorking': instance.isWorking,
      'start': instance.start,
      'end': instance.end,
    };

_$CraftsmanDocumentsImpl _$$CraftsmanDocumentsImplFromJson(
        Map<String, dynamic> json) =>
    _$CraftsmanDocumentsImpl(
      nationalIdFront: json['nationalIdFront'] as String?,
      nationalIdBack: json['nationalIdBack'] as String?,
      nationalIdNumber: json['nationalIdNumber'] as String?,
      certificates: (json['certificates'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      commercialRegister: json['commercialRegister'] as String?,
    );

Map<String, dynamic> _$$CraftsmanDocumentsImplToJson(
        _$CraftsmanDocumentsImpl instance) =>
    <String, dynamic>{
      'nationalIdFront': instance.nationalIdFront,
      'nationalIdBack': instance.nationalIdBack,
      'nationalIdNumber': instance.nationalIdNumber,
      'certificates': instance.certificates,
      'commercialRegister': instance.commercialRegister,
    };

_$GeoLocationImpl _$$GeoLocationImplFromJson(Map<String, dynamic> json) =>
    _$GeoLocationImpl(
      type: json['type'] as String? ?? 'Point',
      coordinates: (json['coordinates'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$GeoLocationImplToJson(_$GeoLocationImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };

_$CraftsmanImpl _$$CraftsmanImplFromJson(Map<String, dynamic> json) =>
    _$CraftsmanImpl(
      id: json['_id'] as String,
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      bio: json['bio'] as String?,
      profileImage: json['profileImage'] as String?,
      coverImage: json['coverImage'] as String?,
      workPhotos: (json['workPhotos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      whatsapp: json['whatsapp'] as String?,
      alternatePhone: json['alternatePhone'] as String?,
      services: (json['services'] as List<dynamic>?)
              ?.map((e) => ServiceInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      documents: json['documents'] == null
          ? null
          : CraftsmanDocuments.fromJson(
              json['documents'] as Map<String, dynamic>),
      address: json['address'] as String?,
      location: json['location'] == null
          ? null
          : GeoLocation.fromJson(json['location'] as Map<String, dynamic>),
      serviceRadius: (json['serviceRadius'] as num?)?.toDouble() ?? 10,
      serviceZones: (json['serviceZones'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isOnline: json['isOnline'] as bool? ?? false,
      isAvailable: json['isAvailable'] as bool? ?? true,
      workingHours: (json['workingHours'] as List<dynamic>?)
              ?.map((e) => WorkingHour.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      status: $enumDecodeNullable(_$CraftsmanStatusEnumMap, json['status']) ??
          CraftsmanStatus.pending,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      approvedBy: json['approvedBy'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
      suspensionReason: json['suspensionReason'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalRatings: (json['totalRatings'] as num?)?.toInt() ?? 0,
      totalJobs: (json['totalJobs'] as num?)?.toInt() ?? 0,
      completedJobs: (json['completedJobs'] as num?)?.toInt() ?? 0,
      cancelledJobs: (json['cancelledJobs'] as num?)?.toInt() ?? 0,
      responseRate: (json['responseRate'] as num?)?.toDouble() ?? 0.0,
      responseTime: (json['responseTime'] as num?)?.toInt() ?? 0,
      totalEarnings: (json['totalEarnings'] as num?)?.toDouble() ?? 0.0,
      currentBalance: (json['currentBalance'] as num?)?.toDouble() ?? 0.0,
      commission: (json['commission'] as num?)?.toInt() ?? 15,
      badges: (json['badges'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isFeatured: json['isFeatured'] as bool? ?? false,
      featuredUntil: json['featuredUntil'] == null
          ? null
          : DateTime.parse(json['featuredUntil'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      distance: (json['distance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$CraftsmanImplToJson(_$CraftsmanImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'displayName': instance.displayName,
      'bio': instance.bio,
      'profileImage': instance.profileImage,
      'coverImage': instance.coverImage,
      'workPhotos': instance.workPhotos,
      'whatsapp': instance.whatsapp,
      'alternatePhone': instance.alternatePhone,
      'services': instance.services,
      'documents': instance.documents,
      'address': instance.address,
      'location': instance.location,
      'serviceRadius': instance.serviceRadius,
      'serviceZones': instance.serviceZones,
      'isOnline': instance.isOnline,
      'isAvailable': instance.isAvailable,
      'workingHours': instance.workingHours,
      'status': _$CraftsmanStatusEnumMap[instance.status]!,
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'approvedBy': instance.approvedBy,
      'rejectionReason': instance.rejectionReason,
      'suspensionReason': instance.suspensionReason,
      'rating': instance.rating,
      'totalRatings': instance.totalRatings,
      'totalJobs': instance.totalJobs,
      'completedJobs': instance.completedJobs,
      'cancelledJobs': instance.cancelledJobs,
      'responseRate': instance.responseRate,
      'responseTime': instance.responseTime,
      'totalEarnings': instance.totalEarnings,
      'currentBalance': instance.currentBalance,
      'commission': instance.commission,
      'badges': instance.badges,
      'isFeatured': instance.isFeatured,
      'featuredUntil': instance.featuredUntil?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'user': instance.user,
      'distance': instance.distance,
    };

const _$CraftsmanStatusEnumMap = {
  CraftsmanStatus.pending: 'pending',
  CraftsmanStatus.approved: 'approved',
  CraftsmanStatus.rejected: 'rejected',
  CraftsmanStatus.suspended: 'suspended',
};

_$CraftsmanListResponseImpl _$$CraftsmanListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CraftsmanListResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => Craftsman.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
    );

Map<String, dynamic> _$$CraftsmanListResponseImplToJson(
        _$CraftsmanListResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
      'totalPages': instance.totalPages,
    };
