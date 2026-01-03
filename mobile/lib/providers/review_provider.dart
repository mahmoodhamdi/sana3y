import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/review.dart';
import '../services/review_service.dart';

part 'review_provider.g.dart';

// Craftsman reviews provider
@riverpod
Future<List<Review>> craftsmanReviews(
  CraftsmanReviewsRef ref,
  String craftsmanId, {
  int? minScore,
}) async {
  final service = ref.watch(reviewServiceProvider);
  final response = await service.getCraftsmanReviews(
    craftsmanId,
    minScore: minScore,
  );
  return response.data;
}

// Craftsman reviews summary provider
@riverpod
Future<ReviewsSummary> craftsmanReviewsSummary(
  CraftsmanReviewsSummaryRef ref,
  String craftsmanId,
) async {
  final service = ref.watch(reviewServiceProvider);
  return service.getCraftsmanReviewsSummary(craftsmanId);
}

// My reviews provider
@riverpod
class MyReviewsNotifier extends _$MyReviewsNotifier {
  @override
  Future<List<Review>> build() async {
    return _loadReviews();
  }

  Future<List<Review>> _loadReviews() async {
    final service = ref.read(reviewServiceProvider);
    final response = await service.getMyReviews();
    return response.data;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadReviews);
  }

  Future<Review> createReview(CreateReviewData data) async {
    final service = ref.read(reviewServiceProvider);
    final review = await service.createReview(data);

    // Add to local list
    state = AsyncData([review, ...state.value ?? []]);

    return review;
  }

  Future<Review> updateReview(
    String reviewId, {
    String? comment,
    List<String>? images,
  }) async {
    final service = ref.read(reviewServiceProvider);
    final updated = await service.updateReview(
      reviewId,
      comment: comment,
      images: images,
    );

    state = AsyncData(
      (state.value ?? [])
          .map((r) => r.id == reviewId ? updated : r)
          .toList(),
    );

    return updated;
  }
}

// Single review provider
@riverpod
Future<Review> reviewDetail(ReviewDetailRef ref, String reviewId) async {
  final service = ref.watch(reviewServiceProvider);
  return service.getReviewById(reviewId);
}
