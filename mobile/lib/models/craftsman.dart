import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'craftsman.freezed.dart';
part 'craftsman.g.dart';

enum CraftsmanStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('approved')
  approved,
  @JsonValue('rejected')
  rejected,
  @JsonValue('suspended')
  suspended,
}

enum PriceType {
  @JsonValue('fixed')
  fixed,
  @JsonValue('hourly')
  hourly,
  @JsonValue('quote')
  quote,
}

@freezed
class ServiceInfo with _$ServiceInfo {
  const factory ServiceInfo({
    required String categoryId,
    @Default([]) List<String> subcategories,
    @Default(0) int experience,
    @Default(PriceType.quote) PriceType priceType,
    double? basePrice,
    String? description,
    // Populated category details
    Map<String, dynamic>? category,
  }) = _ServiceInfo;

  factory ServiceInfo.fromJson(Map<String, dynamic> json) =>
      _$ServiceInfoFromJson(json);
}

@freezed
class WorkingHour with _$WorkingHour {
  const factory WorkingHour({
    required int day,
    @Default(true) bool isWorking,
    @Default('08:00') String start,
    @Default('20:00') String end,
  }) = _WorkingHour;

  factory WorkingHour.fromJson(Map<String, dynamic> json) =>
      _$WorkingHourFromJson(json);
}

@freezed
class CraftsmanDocuments with _$CraftsmanDocuments {
  const factory CraftsmanDocuments({
    String? nationalIdFront,
    String? nationalIdBack,
    String? nationalIdNumber,
    @Default([]) List<String> certificates,
    String? commercialRegister,
  }) = _CraftsmanDocuments;

  factory CraftsmanDocuments.fromJson(Map<String, dynamic> json) =>
      _$CraftsmanDocumentsFromJson(json);
}

@freezed
class GeoLocation with _$GeoLocation {
  const factory GeoLocation({
    @Default('Point') String type,
    @Default([]) List<double> coordinates,
  }) = _GeoLocation;

  factory GeoLocation.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationFromJson(json);
}

@freezed
class Craftsman with _$Craftsman {
  const Craftsman._();

  const factory Craftsman({
    @JsonKey(name: '_id') required String id,
    required String userId,
    required String displayName,
    String? bio,
    String? profileImage,
    String? coverImage,
    @Default([]) List<String> workPhotos,
    String? whatsapp,
    String? alternatePhone,
    @Default([]) List<ServiceInfo> services,
    CraftsmanDocuments? documents,
    String? address,
    GeoLocation? location,
    @Default(10) double serviceRadius,
    @Default([]) List<String> serviceZones,
    @Default(false) bool isOnline,
    @Default(true) bool isAvailable,
    @Default([]) List<WorkingHour> workingHours,
    @Default(CraftsmanStatus.pending) CraftsmanStatus status,
    DateTime? approvedAt,
    String? approvedBy,
    String? rejectionReason,
    String? suspensionReason,
    @Default(0.0) double rating,
    @Default(0) int totalRatings,
    @Default(0) int totalJobs,
    @Default(0) int completedJobs,
    @Default(0) int cancelledJobs,
    @Default(0.0) double responseRate,
    @Default(0) int responseTime,
    @Default(0.0) double totalEarnings,
    @Default(0.0) double currentBalance,
    @Default(15) int commission,
    @Default([]) List<String> badges,
    @Default(false) bool isFeatured,
    DateTime? featuredUntil,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Populated user details
    User? user,
    // Distance from current location (populated in nearby queries)
    double? distance,
  }) = _Craftsman;

  factory Craftsman.fromJson(Map<String, dynamic> json) =>
      _$CraftsmanFromJson(json);

  /// Get phone from user data
  String? get phone => user?.phone;

  /// Get name (displayName or user name)
  String get name => displayName;

  /// Get completion rate percentage
  double get completionRate {
    if (totalJobs == 0) return 0;
    return (completedJobs / totalJobs) * 100;
  }

  /// Check if craftsman is approved
  bool get isApproved => status == CraftsmanStatus.approved;

  /// Get rating as string (e.g., "4.5")
  String get ratingText => rating.toStringAsFixed(1);

  /// Get formatted distance (e.g., "2.5 كم")
  String? get formattedDistance {
    if (distance == null) return null;
    if (distance! < 1) {
      return '${(distance! * 1000).toInt()} م';
    }
    return '${distance!.toStringAsFixed(1)} كم';
  }
}

@freezed
class CraftsmanListResponse with _$CraftsmanListResponse {
  const factory CraftsmanListResponse({
    required List<Craftsman> data,
    required int page,
    required int limit,
    required int total,
    required int totalPages,
  }) = _CraftsmanListResponse;

  factory CraftsmanListResponse.fromJson(Map<String, dynamic> json) =>
      _$CraftsmanListResponseFromJson(json);
}
