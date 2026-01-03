import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/review.dart';
import '../../providers/review_provider.dart';

class CraftsmanReviewsScreen extends ConsumerWidget {
  final String craftsmanId;
  final String craftsmanName;

  const CraftsmanReviewsScreen({
    super.key,
    required this.craftsmanId,
    required this.craftsmanName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(craftsmanReviewsProvider(craftsmanId));
    final summaryAsync = ref.watch(craftsmanReviewsSummaryProvider(craftsmanId));

    return Scaffold(
      appBar: AppBar(
        title: Text('تقييمات $craftsmanName'),
      ),
      body: Column(
        children: [
          // Summary Card
          summaryAsync.when(
            data: (summary) => _ReviewsSummaryCard(summary: summary),
            loading: () => const SizedBox(
              height: 150,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => const SizedBox.shrink(),
          ),

          // Reviews List
          Expanded(
            child: reviewsAsync.when(
              data: (reviews) {
                if (reviews.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.rate_review_outlined,
                            size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'لا توجد تقييمات',
                          style: TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    return _ReviewCard(review: reviews[index]);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('خطأ: $e'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewsSummaryCard extends StatelessWidget {
  final ReviewsSummary summary;

  const _ReviewsSummaryCard({required this.summary});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Average Rating
          Expanded(
            child: Column(
              children: [
                Text(
                  summary.averageRating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    final filled = index < summary.averageRating.round();
                    return Icon(
                      filled ? Icons.star : Icons.star_border,
                      size: 20,
                      color: Colors.amber,
                    );
                  }),
                ),
                const SizedBox(height: 4),
                Text(
                  '${summary.totalReviews} تقييم',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          // Rating Distribution
          Expanded(
            child: Column(
              children: List.generate(5, (index) {
                final rating = 5 - index;
                final count = summary.ratingDistribution[rating.toString()] ?? 0;
                final percentage = summary.totalReviews > 0
                    ? count / summary.totalReviews
                    : 0.0;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Text('$rating', style: const TextStyle(fontSize: 12)),
                      const SizedBox(width: 4),
                      const Icon(Icons.star, size: 12, color: Colors.amber),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: LinearProgressIndicator(
                            value: percentage,
                            backgroundColor: Colors.grey[200],
                            valueColor: const AlwaysStoppedAnimation(Colors.amber),
                            minHeight: 6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 24,
                        child: Text(
                          '$count',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final Review review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Customer info and rating
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: review.customerAvatar != null
                    ? NetworkImage(review.customerAvatar!)
                    : null,
                child: review.customerAvatar == null
                    ? Text(
                        review.customerName.substring(0, 1).toUpperCase(),
                        style: const TextStyle(fontSize: 16),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.customerName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _formatDate(review.createdAt),
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
              // Stars
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < review.score ? Icons.star : Icons.star_border,
                    size: 18,
                    color: Colors.amber,
                  );
                }),
              ),
            ],
          ),

          // Comment
          if (review.comment != null && review.comment!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(review.comment!),
          ],

          // Quality ratings
          if (_hasQualityRatings(review.qualities)) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (review.qualities.punctuality != null)
                  _buildQualityChip('الالتزام', review.qualities.punctuality!),
                if (review.qualities.professionalism != null)
                  _buildQualityChip('الاحترافية', review.qualities.professionalism!),
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
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: review.images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        review.images[index],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],

          // Craftsman response
          if (review.craftsmanResponse != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
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
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(review.craftsmanResponse!),
                ],
              ),
            ),
          ],

          // Request info
          if (review.request != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                review.request!.title,
                style: TextStyle(color: Colors.grey[700], fontSize: 12),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQualityChip(String label, int rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(width: 4),
          Icon(Icons.star, size: 12, color: Colors.amber),
          const SizedBox(width: 2),
          Text(
            '$rating',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
