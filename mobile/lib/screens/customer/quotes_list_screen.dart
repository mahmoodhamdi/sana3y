import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/request.dart';
import '../../providers/request_provider.dart';

class QuotesListScreen extends ConsumerWidget {
  final String requestId;

  const QuotesListScreen({super.key, required this.requestId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestAsync = ref.watch(requestDetailProvider(requestId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('عروض الأسعار'),
      ),
      body: requestAsync.when(
        data: (request) => _buildQuotesList(context, ref, request),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('فشل في تحميل العروض: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(requestDetailProvider(requestId)),
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuotesList(BuildContext context, WidgetRef ref, ServiceRequest request) {
    final quotes = request.quotes;

    if (quotes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.request_quote, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            const Text(
              'لا توجد عروض أسعار بعد',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'انتظر حتى يرسل الصنايعية عروضهم',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: quotes.length,
      itemBuilder: (context, index) {
        final quote = quotes[index];
        final isAccepted = request.assignedCraftsman?.id == quote.craftsman.id;

        return _QuoteCard(
          quote: quote,
          isAccepted: isAccepted,
          canAccept: request.status == RequestStatus.pending,
          onViewDetails: () => context.push(
            '/quote/${quote.id}',
            extra: {'requestId': requestId, 'quote': quote},
          ),
          onAccept: () => _acceptQuote(context, ref, requestId, quote.id),
        );
      },
    );
  }

  Future<void> _acceptQuote(
    BuildContext context,
    WidgetRef ref,
    String requestId,
    String quoteId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('قبول العرض'),
        content: const Text('هل أنت متأكد من قبول هذا العرض؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('قبول'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await ref.read(customerRequestsNotifierProvider.notifier).acceptQuote(
        requestId,
        quoteId,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم قبول العرض بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل في قبول العرض: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

class _QuoteCard extends StatelessWidget {
  final Quote quote;
  final bool isAccepted;
  final bool canAccept;
  final VoidCallback onViewDetails;
  final VoidCallback onAccept;

  const _QuoteCard({
    required this.quote,
    required this.isAccepted,
    required this.canAccept,
    required this.onViewDetails,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isAccepted
            ? const BorderSide(color: Colors.green, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onViewDetails,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: quote.craftsman.profileImage != null
                        ? NetworkImage(quote.craftsman.profileImage!)
                        : null,
                    child: quote.craftsman.profileImage == null
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                quote.craftsman.displayName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            if (isAccepted)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'مقبول',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 14, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              (quote.craftsman.rating ?? 0).toStringAsFixed(1),
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${quote.craftsman.completedJobs ?? 0} عمل مكتمل',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),

              // Price and Duration
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'السعر',
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                        Text(
                          '${quote.amount.toInt()} ج.م',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (quote.estimatedDuration != null)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'المدة المتوقعة',
                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          ),
                          Text(
                            quote.estimatedDuration!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              // Notes
              if (quote.notes != null && quote.notes!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.note, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          quote.notes!,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Accept Button
              if (canAccept && !isAccepted) ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('قبول العرض'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
