// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RequestLocation _$RequestLocationFromJson(Map<String, dynamic> json) =>
    _RequestLocation(
      address: json['address'] as String,
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      governorate: json['governorate'] as String,
      city: json['city'] as String,
      area: json['area'] as String?,
    );

Map<String, dynamic> _$RequestLocationToJson(_RequestLocation instance) =>
    <String, dynamic>{
      'address': instance.address,
      'coordinates': instance.coordinates,
      'governorate': instance.governorate,
      'city': instance.city,
      'area': instance.area,
    };

_RequestBudget _$RequestBudgetFromJson(Map<String, dynamic> json) =>
    _RequestBudget(
      min: (json['min'] as num).toDouble(),
      max: (json['max'] as num).toDouble(),
    );

Map<String, dynamic> _$RequestBudgetToJson(_RequestBudget instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };

_PreferredTime _$PreferredTimeFromJson(Map<String, dynamic> json) =>
    _PreferredTime(
      start: json['start'] as String,
      end: json['end'] as String,
    );

Map<String, dynamic> _$PreferredTimeToJson(_PreferredTime instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
    };

_Quote _$QuoteFromJson(Map<String, dynamic> json) => _Quote(
      id: json['_id'] as String,
      craftsman:
          CraftsmanSummary.fromJson(json['craftsman'] as Map<String, dynamic>),
      amount: (json['amount'] as num).toDouble(),
      estimatedDuration: json['estimatedDuration'] as String?,
      notes: json['notes'] as String?,
      validUntil: json['validUntil'] == null
          ? null
          : DateTime.parse(json['validUntil'] as String),
      status: json['status'] as String? ?? 'pending',
      submittedAt: DateTime.parse(json['submittedAt'] as String),
    );

Map<String, dynamic> _$QuoteToJson(_Quote instance) => <String, dynamic>{
      '_id': instance.id,
      'craftsman': instance.craftsman,
      'amount': instance.amount,
      'estimatedDuration': instance.estimatedDuration,
      'notes': instance.notes,
      'validUntil': instance.validUntil?.toIso8601String(),
      'status': instance.status,
      'submittedAt': instance.submittedAt.toIso8601String(),
    };

_CraftsmanSummary _$CraftsmanSummaryFromJson(Map<String, dynamic> json) =>
    _CraftsmanSummary(
      id: json['_id'] as String,
      displayName: json['displayName'] as String,
      rating: (json['rating'] as num?)?.toDouble(),
      profileImage: json['profileImage'] as String?,
      completedJobs: (json['completedJobs'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CraftsmanSummaryToJson(_CraftsmanSummary instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'displayName': instance.displayName,
      'rating': instance.rating,
      'profileImage': instance.profileImage,
      'completedJobs': instance.completedJobs,
    };

_CustomerSummary _$CustomerSummaryFromJson(Map<String, dynamic> json) =>
    _CustomerSummary(
      id: json['_id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$CustomerSummaryToJson(_CustomerSummary instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'avatar': instance.avatar,
    };

_CategorySummary _$CategorySummaryFromJson(Map<String, dynamic> json) =>
    _CategorySummary(
      id: json['_id'] as String,
      name: json['name'] as String,
      nameAr: json['nameAr'] as String,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$CategorySummaryToJson(_CategorySummary instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'nameAr': instance.nameAr,
      'icon': instance.icon,
    };

_AcceptedQuote _$AcceptedQuoteFromJson(Map<String, dynamic> json) =>
    _AcceptedQuote(
      amount: (json['amount'] as num).toDouble(),
      estimatedDuration: json['estimatedDuration'] as String?,
    );

Map<String, dynamic> _$AcceptedQuoteToJson(_AcceptedQuote instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'estimatedDuration': instance.estimatedDuration,
    };

_StatusHistoryEntry _$StatusHistoryEntryFromJson(Map<String, dynamic> json) =>
    _StatusHistoryEntry(
      status: json['status'] as String,
      changedAt: DateTime.parse(json['changedAt'] as String),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$StatusHistoryEntryToJson(_StatusHistoryEntry instance) =>
    <String, dynamic>{
      'status': instance.status,
      'changedAt': instance.changedAt.toIso8601String(),
      'notes': instance.notes,
    };

_ServiceRequest _$ServiceRequestFromJson(Map<String, dynamic> json) =>
    _ServiceRequest(
      id: json['_id'] as String,
      requestNumber: json['requestNumber'] as String,
      customer:
          CustomerSummary.fromJson(json['customer'] as Map<String, dynamic>),
      category:
          CategorySummary.fromJson(json['category'] as Map<String, dynamic>),
      subcategory: json['subcategory'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      location:
          RequestLocation.fromJson(json['location'] as Map<String, dynamic>),
      preferredDate: json['preferredDate'] == null
          ? null
          : DateTime.parse(json['preferredDate'] as String),
      preferredTime: json['preferredTime'] == null
          ? null
          : PreferredTime.fromJson(
              json['preferredTime'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      budget: json['budget'] == null
          ? null
          : RequestBudget.fromJson(json['budget'] as Map<String, dynamic>),
      urgency: $enumDecodeNullable(_$RequestUrgencyEnumMap, json['urgency']) ??
          RequestUrgency.normal,
      status: $enumDecodeNullable(_$RequestStatusEnumMap, json['status']) ??
          RequestStatus.pending,
      quotes: (json['quotes'] as List<dynamic>?)
              ?.map((e) => Quote.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      assignedCraftsman: json['assignedCraftsman'] == null
          ? null
          : CraftsmanSummary.fromJson(
              json['assignedCraftsman'] as Map<String, dynamic>),
      acceptedQuote: json['acceptedQuote'] == null
          ? null
          : AcceptedQuote.fromJson(
              json['acceptedQuote'] as Map<String, dynamic>),
      statusHistory: (json['statusHistory'] as List<dynamic>?)
              ?.map(
                  (e) => StatusHistoryEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      arrivedAt: json['arrivedAt'] == null
          ? null
          : DateTime.parse(json['arrivedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      cancelledAt: json['cancelledAt'] == null
          ? null
          : DateTime.parse(json['cancelledAt'] as String),
      cancelledBy: json['cancelledBy'] as String?,
      cancellationReason: json['cancellationReason'] as String?,
      actualAmount: (json['actualAmount'] as num?)?.toDouble(),
      completionNotes: json['completionNotes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ServiceRequestToJson(_ServiceRequest instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'requestNumber': instance.requestNumber,
      'customer': instance.customer,
      'category': instance.category,
      'subcategory': instance.subcategory,
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'preferredDate': instance.preferredDate?.toIso8601String(),
      'preferredTime': instance.preferredTime,
      'images': instance.images,
      'budget': instance.budget,
      'urgency': _$RequestUrgencyEnumMap[instance.urgency]!,
      'status': _$RequestStatusEnumMap[instance.status]!,
      'quotes': instance.quotes,
      'assignedCraftsman': instance.assignedCraftsman,
      'acceptedQuote': instance.acceptedQuote,
      'statusHistory': instance.statusHistory,
      'startedAt': instance.startedAt?.toIso8601String(),
      'arrivedAt': instance.arrivedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'cancelledAt': instance.cancelledAt?.toIso8601String(),
      'cancelledBy': instance.cancelledBy,
      'cancellationReason': instance.cancellationReason,
      'actualAmount': instance.actualAmount,
      'completionNotes': instance.completionNotes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$RequestUrgencyEnumMap = {
  RequestUrgency.normal: 'normal',
  RequestUrgency.urgent: 'urgent',
  RequestUrgency.emergency: 'emergency',
};

const _$RequestStatusEnumMap = {
  RequestStatus.pending: 'pending',
  RequestStatus.quoted: 'quoted',
  RequestStatus.accepted: 'accepted',
  RequestStatus.inProgress: 'in_progress',
  RequestStatus.arrived: 'arrived',
  RequestStatus.completed: 'completed',
  RequestStatus.cancelled: 'cancelled',
  RequestStatus.disputed: 'disputed',
  RequestStatus.refunded: 'refunded',
};

_CreateRequestData _$CreateRequestDataFromJson(Map<String, dynamic> json) =>
    _CreateRequestData(
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      subcategory: json['subcategory'] as String?,
      location:
          RequestLocation.fromJson(json['location'] as Map<String, dynamic>),
      preferredDate: json['preferredDate'] == null
          ? null
          : DateTime.parse(json['preferredDate'] as String),
      preferredTime: json['preferredTime'] == null
          ? null
          : PreferredTime.fromJson(
              json['preferredTime'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      budget: json['budget'] == null
          ? null
          : RequestBudget.fromJson(json['budget'] as Map<String, dynamic>),
      urgency: $enumDecodeNullable(_$RequestUrgencyEnumMap, json['urgency']) ??
          RequestUrgency.normal,
    );

Map<String, dynamic> _$CreateRequestDataToJson(_CreateRequestData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'subcategory': instance.subcategory,
      'location': instance.location,
      'preferredDate': instance.preferredDate?.toIso8601String(),
      'preferredTime': instance.preferredTime,
      'images': instance.images,
      'budget': instance.budget,
      'urgency': _$RequestUrgencyEnumMap[instance.urgency]!,
    };

_SubmitQuoteData _$SubmitQuoteDataFromJson(Map<String, dynamic> json) =>
    _SubmitQuoteData(
      amount: (json['amount'] as num).toDouble(),
      estimatedDuration: json['estimatedDuration'] as String?,
      notes: json['notes'] as String?,
      validUntil: json['validUntil'] == null
          ? null
          : DateTime.parse(json['validUntil'] as String),
    );

Map<String, dynamic> _$SubmitQuoteDataToJson(_SubmitQuoteData instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'estimatedDuration': instance.estimatedDuration,
      'notes': instance.notes,
      'validUntil': instance.validUntil?.toIso8601String(),
    };

_RequestListResponse _$RequestListResponseFromJson(Map<String, dynamic> json) =>
    _RequestListResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => ServiceRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$RequestListResponseToJson(
        _RequestListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'page': instance.page,
      'totalPages': instance.totalPages,
      'total': instance.total,
      'limit': instance.limit,
    };
