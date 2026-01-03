import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';
part 'review.g.dart';

@freezed
class QualityRatings with _$QualityRatings {
  const factory QualityRatings({
    int? punctuality,
    int? professionalism,
    int? quality,
    int? cleanliness,
    int? communication,
  }) = _QualityRatings;

  factory QualityRatings.fromJson(Map<String, dynamic> json) =>
      _$QualityRatingsFromJson(json);
}

@freezed
class ReviewCustomer with _$ReviewCustomer {
  const factory ReviewCustomer({
    @JsonKey(name: '_id') required String id,
    ReviewCustomerUser? userId,
  }) = _ReviewCustomer;

  factory ReviewCustomer.fromJson(Map<String, dynamic> json) =>
      _$ReviewCustomerFromJson(json);
}

@freezed
class ReviewCustomerUser with _$ReviewCustomerUser {
  const factory ReviewCustomerUser({
    @JsonKey(name: '_id') required String id,
    required String name,
    String? avatar,
  }) = _ReviewCustomerUser;

  factory ReviewCustomerUser.fromJson(Map<String, dynamic> json) =>
      _$ReviewCustomerUserFromJson(json);
}

@freezed
class ReviewRequest with _$ReviewRequest {
  const factory ReviewRequest({
    @JsonKey(name: '_id') required String id,
    required String requestNumber,
    required String title,
    ReviewCategory? category,
  }) = _ReviewRequest;

  factory ReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$ReviewRequestFromJson(json);
}

@freezed
class ReviewCategory with _$ReviewCategory {
  const factory ReviewCategory({
    @JsonKey(name: '_id') required String id,
    required String nameAr,
  }) = _ReviewCategory;

  factory ReviewCategory.fromJson(Map<String, dynamic> json) =>
      _$ReviewCategoryFromJson(json);
}

@freezed
class Review with _$Review {
  const Review._();

  const factory Review({
    @JsonKey(name: '_id') required String id,
    required String requestId,
    required String customerId,
    required String craftsmanId,
    required int score,
    String? comment,
    @Default(QualityRatings()) QualityRatings qualities,
    @Default([]) List<String> images,
    String? craftsmanResponse,
    DateTime? respondedAt,
    @Default(true) bool isVisible,
    @Default(false) bool isReported,
    String? reportReason,
    ReviewCustomer? customer,
    ReviewRequest? request,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  String get customerName => customer?.userId?.name ?? 'عميل';
  String? get customerAvatar => customer?.userId?.avatar;
}

@freezed
class ReviewsSummary with _$ReviewsSummary {
  const factory ReviewsSummary({
    @Default(0) double averageRating,
    @Default(0) int totalReviews,
    @Default({}) Map<String, int> ratingDistribution,
    @Default({}) Map<String, double> qualityAverages,
  }) = _ReviewsSummary;

  factory ReviewsSummary.fromJson(Map<String, dynamic> json) =>
      _$ReviewsSummaryFromJson(json);
}

@freezed
class CreateReviewData with _$CreateReviewData {
  const factory CreateReviewData({
    required String requestId,
    required int score,
    String? comment,
    QualityRatings? qualities,
    @Default([]) List<String> images,
  }) = _CreateReviewData;

  factory CreateReviewData.fromJson(Map<String, dynamic> json) =>
      _$CreateReviewDataFromJson(json);
}

@freezed
class ReviewListResponse with _$ReviewListResponse {
  const factory ReviewListResponse({
    required List<Review> data,
    required int page,
    required int totalPages,
    required int total,
    required int limit,
  }) = _ReviewListResponse;

  factory ReviewListResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewListResponseFromJson(json);
}
