import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/review.dart';
import '../../providers/review_provider.dart';

class RateServiceScreen extends ConsumerStatefulWidget {
  final String requestId;
  final String craftsmanName;

  const RateServiceScreen({
    super.key,
    required this.requestId,
    required this.craftsmanName,
  });

  @override
  ConsumerState<RateServiceScreen> createState() => _RateServiceScreenState();
}

class _RateServiceScreenState extends ConsumerState<RateServiceScreen> {
  int _overallRating = 0;
  int _punctualityRating = 0;
  int _professionalismRating = 0;
  int _qualityRating = 0;
  int _cleanlinessRating = 0;
  int _communicationRating = 0;
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;
  bool _showDetailedRatings = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تقييم الخدمة'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Craftsman info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      child: Icon(Icons.person, size: 40),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.craftsmanName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'كيف كانت تجربتك مع هذا الصنايعي؟',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Overall Rating
            Text(
              'التقييم العام',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _buildOverallStarRating(),
            const SizedBox(height: 8),
            Center(
              child: Text(
                _getRatingLabel(_overallRating),
                style: TextStyle(
                  color: _getRatingColor(_overallRating),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Detailed Ratings Toggle
            InkWell(
              onTap: () {
                setState(() {
                  _showDetailedRatings = !_showDetailedRatings;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'تقييمات تفصيلية (اختياري)',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Icon(
                    _showDetailedRatings
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),

            if (_showDetailedRatings) ...[
              const SizedBox(height: 16),
              _buildDetailedRatingItem(
                'الالتزام بالموعد',
                Icons.schedule,
                _punctualityRating,
                (rating) => setState(() => _punctualityRating = rating),
              ),
              _buildDetailedRatingItem(
                'الاحترافية',
                Icons.workspace_premium,
                _professionalismRating,
                (rating) => setState(() => _professionalismRating = rating),
              ),
              _buildDetailedRatingItem(
                'جودة العمل',
                Icons.star,
                _qualityRating,
                (rating) => setState(() => _qualityRating = rating),
              ),
              _buildDetailedRatingItem(
                'النظافة',
                Icons.cleaning_services,
                _cleanlinessRating,
                (rating) => setState(() => _cleanlinessRating = rating),
              ),
              _buildDetailedRatingItem(
                'التواصل',
                Icons.chat,
                _communicationRating,
                (rating) => setState(() => _communicationRating = rating),
              ),
            ],

            const SizedBox(height: 24),

            // Comment
            Text(
              'اكتب تعليقك (اختياري)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _commentController,
              maxLines: 4,
              maxLength: 500,
              decoration: InputDecoration(
                hintText: 'شاركنا تجربتك مع هذا الصنايعي...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _overallRating > 0 && !_isSubmitting
                    ? _submitReview
                    : null,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'إرسال التقييم',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
            const SizedBox(height: 16),

            // Skip Button
            TextButton(
              onPressed: _isSubmitting ? null : () => context.pop(),
              child: const Text('تخطي'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _overallRating = index + 1;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              index < _overallRating ? Icons.star : Icons.star_border,
              size: 48,
              color: index < _overallRating ? Colors.amber : Colors.grey[400],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDetailedRatingItem(
    String label,
    IconData icon,
    int currentRating,
    ValueChanged<int> onRatingChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(label),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () => onRatingChanged(index + 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      index < currentRating ? Icons.star : Icons.star_border,
                      size: 24,
                      color:
                          index < currentRating ? Colors.amber : Colors.grey[400],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  String _getRatingLabel(int rating) {
    switch (rating) {
      case 1:
        return 'سيء';
      case 2:
        return 'مقبول';
      case 3:
        return 'جيد';
      case 4:
        return 'جيد جداً';
      case 5:
        return 'ممتاز';
      default:
        return 'اختر تقييمك';
    }
  }

  Color _getRatingColor(int rating) {
    switch (rating) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.amber;
      case 4:
        return Colors.lightGreen;
      case 5:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Future<void> _submitReview() async {
    if (_overallRating == 0) return;

    setState(() => _isSubmitting = true);

    try {
      QualityRatings? qualities;
      if (_showDetailedRatings &&
          (_punctualityRating > 0 ||
              _professionalismRating > 0 ||
              _qualityRating > 0 ||
              _cleanlinessRating > 0 ||
              _communicationRating > 0)) {
        qualities = QualityRatings(
          punctuality: _punctualityRating > 0 ? _punctualityRating : null,
          professionalism:
              _professionalismRating > 0 ? _professionalismRating : null,
          quality: _qualityRating > 0 ? _qualityRating : null,
          cleanliness: _cleanlinessRating > 0 ? _cleanlinessRating : null,
          communication: _communicationRating > 0 ? _communicationRating : null,
        );
      }

      final data = CreateReviewData(
        requestId: widget.requestId,
        score: _overallRating,
        comment:
            _commentController.text.trim().isNotEmpty ? _commentController.text.trim() : null,
        qualities: qualities,
      );

      await ref.read(myReviewsNotifierProvider.notifier).createReview(data);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إرسال تقييمك بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل في إرسال التقييم: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}
