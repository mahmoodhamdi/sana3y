import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/review.dart';
import '../../providers/review_provider.dart';

class MyReviewsScreen extends ConsumerWidget {
  const MyReviewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(myReviewsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('تقييماتي'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(myReviewsNotifierProvider.notifier).refresh(),
          ),
        ],
      ),
      body: reviewsAsync.when(
        data: (reviews) {
          if (reviews.isEmpty) {
            return _buildEmptyState();
          }
          return RefreshIndicator(
            onRefresh: () =>
                ref.read(myReviewsNotifierProvider.notifier).refresh(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return _ReviewCard(review: reviews[index]);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('فشل في تحميل التقييمات: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.read(myReviewsNotifierProvider.notifier).refresh(),
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.rate_review_outlined, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 24),
            const Text(
              'لم تقم بكتابة أي تقييمات بعد',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'بعد إتمام أي طلب، يمكنك تقييم الصنايعي من هنا',
              style: TextStyle(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewCard extends ConsumerWidget {
  final Review review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // Navigate to craftsman profile
          context.push('/craftsman/${review.craftsmanId}');
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Request and Rating Info
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.build,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review.request?.title ?? 'طلب خدمة',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (review.request?.category != null)
                          Text(
                            review.request!.category!.nameAr,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  // Rating
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${review.score}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Rating Stars
              const SizedBox(height: 12),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < review.score ? Icons.star : Icons.star_border,
                    size: 20,
                    color: Colors.amber,
                  );
                }),
              ),

              // Comment
              if (review.comment != null && review.comment!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  review.comment!,
                  style: TextStyle(color: Colors.grey[700], height: 1.5),
                ),
              ],

              // Quality Ratings
              if (_hasQualityRatings(review.qualities)) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (review.qualities.punctuality != null)
                      _buildQualityChip('الالتزام', review.qualities.punctuality!),
                    if (review.qualities.professionalism != null)
                      _buildQualityChip(
                          'الاحترافية', review.qualities.professionalism!),
                    if (review.qualities.quality != null)
                      _buildQualityChip('الجودة', review.qualities.quality!),
                    if (review.qualities.cleanliness != null)
                      _buildQualityChip('النظافة', review.qualities.cleanliness!),
                    if (review.qualities.communication != null)
                      _buildQualityChip('التواصل', review.qualities.communication!),
                  ],
                ),
              ],

              // Images
              if (review.images.isNotEmpty) ...[
                const SizedBox(height: 12),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: review.images.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: index == review.images.length - 1 ? 0 : 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            review.images[index],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey[200],
                              child: const Icon(Icons.image_not_supported),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],

              // Craftsman Response
              if (review.craftsmanResponse != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                      right: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.reply,
                              size: 16, color: Theme.of(context).primaryColor),
                          const SizedBox(width: 8),
                          Text(
                            'رد الصنايعي',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        review.craftsmanResponse!,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ],

              // Date
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(review.createdAt),
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQualityChip(String label, int rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.star, size: 12, color: Colors.amber),
          const SizedBox(width: 2),
          Text(
            '$rating',
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  bool _hasQualityRatings(QualityRatings qualities) {
    return qualities.punctuality != null ||
        qualities.professionalism != null ||
        qualities.quality != null ||
        qualities.cleanliness != null ||
        qualities.communication != null;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return 'اليوم';
    } else if (diff.inDays == 1) {
      return 'أمس';
    } else if (diff.inDays < 7) {
      return 'منذ ${diff.inDays} أيام';
    } else if (diff.inDays < 30) {
      return 'منذ ${(diff.inDays / 7).floor()} أسابيع';
    } else if (diff.inDays < 365) {
      return 'منذ ${(diff.inDays / 30).floor()} شهور';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
