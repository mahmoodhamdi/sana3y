import 'package:freezed_annotation/freezed_annotation.dart';

part 'request.freezed.dart';
part 'request.g.dart';

enum RequestStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('quoted')
  quoted,
  @JsonValue('accepted')
  accepted,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('arrived')
  arrived,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('disputed')
  disputed,
  @JsonValue('refunded')
  refunded,
}

enum RequestUrgency {
  @JsonValue('normal')
  normal,
  @JsonValue('urgent')
  urgent,
  @JsonValue('emergency')
  emergency,
}

@freezed
class RequestLocation with _$RequestLocation {
  const factory RequestLocation({
    required String address,
    required List<double> coordinates,
    required String governorate,
    required String city,
    String? area,
  }) = _RequestLocation;

  factory RequestLocation.fromJson(Map<String, dynamic> json) =>
      _$RequestLocationFromJson(json);
}

@freezed
class RequestBudget with _$RequestBudget {
  const factory RequestBudget({
    required double min,
    required double max,
  }) = _RequestBudget;

  factory RequestBudget.fromJson(Map<String, dynamic> json) =>
      _$RequestBudgetFromJson(json);
}

@freezed
class PreferredTime with _$PreferredTime {
  const factory PreferredTime({
    required String start,
    required String end,
  }) = _PreferredTime;

  factory PreferredTime.fromJson(Map<String, dynamic> json) =>
      _$PreferredTimeFromJson(json);
}

@freezed
class Quote with _$Quote {
  const factory Quote({
    @JsonKey(name: '_id') required String id,
    required CraftsmanSummary craftsman,
    required double amount,
    String? estimatedDuration,
    String? notes,
    DateTime? validUntil,
    @Default('pending') String status,
    required DateTime submittedAt,
  }) = _Quote;

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
}

@freezed
class CraftsmanSummary with _$CraftsmanSummary {
  const factory CraftsmanSummary({
    @JsonKey(name: '_id') required String id,
    required String displayName,
    double? rating,
    String? profileImage,
    int? completedJobs,
  }) = _CraftsmanSummary;

  factory CraftsmanSummary.fromJson(Map<String, dynamic> json) =>
      _$CraftsmanSummaryFromJson(json);
}

@freezed
class CustomerSummary with _$CustomerSummary {
  const factory CustomerSummary({
    @JsonKey(name: '_id') required String id,
    required String name,
    String? phone,
    String? avatar,
  }) = _CustomerSummary;

  factory CustomerSummary.fromJson(Map<String, dynamic> json) =>
      _$CustomerSummaryFromJson(json);
}

@freezed
class CategorySummary with _$CategorySummary {
  const factory CategorySummary({
    @JsonKey(name: '_id') required String id,
    required String name,
    required String nameAr,
    String? icon,
  }) = _CategorySummary;

  factory CategorySummary.fromJson(Map<String, dynamic> json) =>
      _$CategorySummaryFromJson(json);
}

@freezed
class AcceptedQuote with _$AcceptedQuote {
  const factory AcceptedQuote({
    required double amount,
    String? estimatedDuration,
  }) = _AcceptedQuote;

  factory AcceptedQuote.fromJson(Map<String, dynamic> json) =>
      _$AcceptedQuoteFromJson(json);
}

@freezed
class StatusHistoryEntry with _$StatusHistoryEntry {
  const factory StatusHistoryEntry({
    required String status,
    required DateTime changedAt,
    String? notes,
  }) = _StatusHistoryEntry;

  factory StatusHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$StatusHistoryEntryFromJson(json);
}

@freezed
class ServiceRequest with _$ServiceRequest {
  const ServiceRequest._();

  const factory ServiceRequest({
    @JsonKey(name: '_id') required String id,
    required String requestNumber,
    required CustomerSummary customer,
    required CategorySummary category,
    String? subcategory,
    required String title,
    required String description,
    required RequestLocation location,
    DateTime? preferredDate,
    PreferredTime? preferredTime,
    @Default([]) List<String> images,
    RequestBudget? budget,
    @Default(RequestUrgency.normal) RequestUrgency urgency,
    @Default(RequestStatus.pending) RequestStatus status,
    @Default([]) List<Quote> quotes,
    CraftsmanSummary? assignedCraftsman,
    AcceptedQuote? acceptedQuote,
    @Default([]) List<StatusHistoryEntry> statusHistory,
    DateTime? startedAt,
    DateTime? arrivedAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
    String? cancelledBy,
    String? cancellationReason,
    double? actualAmount,
    String? completionNotes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ServiceRequest;

  factory ServiceRequest.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestFromJson(json);

  // Helper getters
  String get statusLabel {
    switch (status) {
      case RequestStatus.pending:
        return 'في الانتظار';
      case RequestStatus.quoted:
        return 'تم التسعير';
      case RequestStatus.accepted:
        return 'مقبول';
      case RequestStatus.inProgress:
        return 'جاري العمل';
      case RequestStatus.arrived:
        return 'وصل الصنايعي';
      case RequestStatus.completed:
        return 'مكتمل';
      case RequestStatus.cancelled:
        return 'ملغي';
      case RequestStatus.disputed:
        return 'نزاع';
      case RequestStatus.refunded:
        return 'مسترد';
    }
  }

  String get urgencyLabel {
    switch (urgency) {
      case RequestUrgency.normal:
        return 'عادي';
      case RequestUrgency.urgent:
        return 'مستعجل';
      case RequestUrgency.emergency:
        return 'طوارئ';
    }
  }

  bool get canCancel => [
        RequestStatus.pending,
        RequestStatus.quoted,
        RequestStatus.accepted,
      ].contains(status);

  bool get canEdit => status == RequestStatus.pending;

  bool get isActive => [
        RequestStatus.pending,
        RequestStatus.quoted,
        RequestStatus.accepted,
        RequestStatus.inProgress,
        RequestStatus.arrived,
      ].contains(status);

  bool get isCompleted => status == RequestStatus.completed;

  int get quotesCount => quotes.length;

  Quote? get pendingQuotes =>
      quotes.where((q) => q.status == 'pending').firstOrNull;
}

@freezed
class CreateRequestData with _$CreateRequestData {
  const factory CreateRequestData({
    required String title,
    required String description,
    required String category,
    String? subcategory,
    required RequestLocation location,
    DateTime? preferredDate,
    PreferredTime? preferredTime,
    @Default([]) List<String> images,
    RequestBudget? budget,
    @Default(RequestUrgency.normal) RequestUrgency urgency,
  }) = _CreateRequestData;

  factory CreateRequestData.fromJson(Map<String, dynamic> json) =>
      _$CreateRequestDataFromJson(json);
}

@freezed
class SubmitQuoteData with _$SubmitQuoteData {
  const factory SubmitQuoteData({
    required double amount,
    String? estimatedDuration,
    String? notes,
    DateTime? validUntil,
  }) = _SubmitQuoteData;

  factory SubmitQuoteData.fromJson(Map<String, dynamic> json) =>
      _$SubmitQuoteDataFromJson(json);
}

@freezed
class RequestListResponse with _$RequestListResponse {
  const factory RequestListResponse({
    required List<ServiceRequest> data,
    required int page,
    required int totalPages,
    required int total,
    required int limit,
  }) = _RequestListResponse;

  factory RequestListResponse.fromJson(Map<String, dynamic> json) =>
      _$RequestListResponseFromJson(json);
}
