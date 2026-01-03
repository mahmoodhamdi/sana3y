import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/review.dart';
import '../providers/auth_provider.dart';
import 'api_client.dart';

part 'review_service.g.dart';

@riverpod
ReviewService reviewService(ReviewServiceRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ReviewService(apiClient);
}

class ReviewService {
  final ApiClient _apiClient;

  ReviewService(this._apiClient);

  // Create a review
  Future<Review> createReview(CreateReviewData data) async {
    final response = await _apiClient.post(
      '/reviews',
      data: {
        'requestId': data.requestId,
        'score': data.score,
        if (data.comment != null) 'comment': data.comment,
        if (data.qualities != null)
          'qualities': {
            if (data.qualities!.punctuality != null)
              'punctuality': data.qualities!.punctuality,
            if (data.qualities!.professionalism != null)
              'professionalism': data.qualities!.professionalism,
            if (data.qualities!.quality != null)
              'quality': data.qualities!.quality,
            if (data.qualities!.cleanliness != null)
              'cleanliness': data.qualities!.cleanliness,
            if (data.qualities!.communication != null)
              'communication': data.qualities!.communication,
          },
        'images': data.images,
      },
    );
    return Review.fromJson(response.data['data']);
  }

  // Get review by ID
  Future<Review> getReviewById(String reviewId) async {
    final response = await _apiClient.get('/reviews/$reviewId');
    return Review.fromJson(response.data['data']);
  }

  // Get craftsman reviews
  Future<ReviewListResponse> getCraftsmanReviews(
    String craftsmanId, {
    int page = 1,
    int limit = 20,
    int? minScore,
    String sortBy = 'createdAt',
    String sortOrder = 'desc',
  }) async {
    final params = <String, dynamic>{
      'page': page,
      'limit': limit,
      'sortBy': sortBy,
      'sortOrder': sortOrder,
    };
    if (minScore != null) {
      params['minScore'] = minScore;
    }

    final response = await _apiClient.get(
      '/reviews/craftsman/$craftsmanId',
      queryParameters: params,
    );

    return ReviewListResponse(
      data: (response.data['data'] as List)
          .map((e) => Review.fromJson(e))
          .toList(),
      page: response.data['pagination']['page'],
      totalPages: response.data['pagination']['totalPages'],
      total: response.data['pagination']['total'],
      limit: response.data['pagination']['limit'],
    );
  }

  // Get craftsman reviews summary
  Future<ReviewsSummary> getCraftsmanReviewsSummary(String craftsmanId) async {
    final response =
        await _apiClient.get('/reviews/craftsman/$craftsmanId/summary');
    return ReviewsSummary.fromJson(response.data['data']);
  }

  // Get my reviews
  Future<ReviewListResponse> getMyReviews({
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _apiClient.get(
      '/reviews/my',
      queryParameters: {'page': page, 'limit': limit},
    );

    return ReviewListResponse(
      data: (response.data['data'] as List)
          .map((e) => Review.fromJson(e))
          .toList(),
      page: response.data['pagination']['page'],
      totalPages: response.data['pagination']['totalPages'],
      total: response.data['pagination']['total'],
      limit: response.data['pagination']['limit'],
    );
  }

  // Update review
  Future<Review> updateReview(
    String reviewId, {
    String? comment,
    List<String>? images,
  }) async {
    final response = await _apiClient.put(
      '/reviews/$reviewId',
      data: {
        if (comment != null) 'comment': comment,
        if (images != null) 'images': images,
      },
    );
    return Review.fromJson(response.data['data']);
  }

  // Respond to review (craftsman)
  Future<Review> respondToReview(String reviewId, String response) async {
    final res = await _apiClient.post(
      '/reviews/$reviewId/respond',
      data: {'response': response},
    );
    return Review.fromJson(res.data['data']);
  }

  // Report a review
  Future<void> reportReview(String reviewId, String reason) async {
    await _apiClient.post(
      '/reviews/$reviewId/report',
      data: {'reason': reason},
    );
  }
}
