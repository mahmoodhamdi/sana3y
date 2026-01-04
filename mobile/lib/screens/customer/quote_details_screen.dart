import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/request.dart';
import '../../providers/request_provider.dart';

class QuoteDetailsScreen extends ConsumerWidget {
  final String quoteId;
  final String requestId;
  final Quote? quote;

  const QuoteDetailsScreen({
    super.key,
    required this.quoteId,
    required this.requestId,
    this.quote,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // If quote is passed directly, use it; otherwise fetch from request
    if (quote != null) {
      return _buildScreen(context, ref, quote!);
    }

    final requestAsync = ref.watch(requestDetailProvider(requestId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل العرض'),
      ),
      body: requestAsync.when(
        data: (request) {
          final foundQuote = request.quotes.firstWhere(
            (q) => q.id == quoteId,
            orElse: () => throw Exception('Quote not found'),
          );
          return _buildContent(context, ref, foundQuote, request);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('فشل في تحميل العرض: $error'),
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

  Widget _buildScreen(BuildContext context, WidgetRef ref, Quote quote) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل العرض'),
      ),
      body: _buildContent(context, ref, quote, null),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    Quote quote,
    ServiceRequest? request,
  ) {
    final canAccept = request?.status == RequestStatus.pending;
    final isAccepted = request?.assignedCraftsman?.id == quote.craftsman.id;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Craftsman Card
          _CraftsmanCard(
            craftsman: quote.craftsman,
            onViewProfile: () {
              context.push('/craftsman/${quote.craftsman.id}');
            },
          ),
          const SizedBox(height: 16),

          // Price Card
          _PriceCard(quote: quote),
          const SizedBox(height: 16),

          // Quote Details
          _QuoteDetailsCard(quote: quote),
          const SizedBox(height: 16),

          // Status Badge
          if (isAccepted)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 8),
                  const Text(
                    'تم قبول هذا العرض',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 24),

          // Actions
          if (canAccept && !isAccepted) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _acceptQuote(context, ref, quote),
                icon: const Icon(Icons.check),
                label: const Text('قبول العرض'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  context.push('/chat/${quote.craftsman.id}');
                },
                icon: const Icon(Icons.chat_bubble_outline),
                label: const Text('تواصل مع الصنايعي'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],

          // Contact buttons for accepted quotes
          if (isAccepted) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.push('/chat/${quote.craftsman.id}');
                    },
                    icon: const Icon(Icons.chat_bubble_outline),
                    label: const Text('محادثة'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Phone call
                    },
                    icon: const Icon(Icons.phone_outlined),
                    label: const Text('اتصال'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _acceptQuote(
    BuildContext context,
    WidgetRef ref,
    Quote quote,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('قبول العرض'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('هل أنت متأكد من قبول هذا العرض؟'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  CircleAvatar(
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
                        Text(
                          quote.craftsman.displayName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${quote.amount.toInt()} ج.م',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await ref.read(customerRequestsNotifierProvider.notifier).acceptQuote(
        requestId,
        quote.id,
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

class _CraftsmanCard extends StatelessWidget {
  final CraftsmanSummary craftsman;
  final VoidCallback onViewProfile;

  const _CraftsmanCard({
    required this.craftsman,
    required this.onViewProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onViewProfile,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: craftsman.profileImage != null
                    ? NetworkImage(craftsman.profileImage!)
                    : null,
                child: craftsman.profileImage == null
                    ? const Icon(Icons.person, size: 32)
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      craftsman.displayName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          (craftsman.rating ?? 0).toStringAsFixed(1),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${craftsman.completedJobs ?? 0} عمل مكتمل',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class _PriceCard extends StatelessWidget {
  final Quote quote;

  const _PriceCard({required this.quote});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[400]!, Colors.green[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            'السعر المقترح',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${quote.amount.toInt()}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'ج.م',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (quote.estimatedDuration != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.schedule, color: Colors.white, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'المدة المتوقعة: ${quote.estimatedDuration}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _QuoteDetailsCard extends StatelessWidget {
  final Quote quote;

  const _QuoteDetailsCard({required this.quote});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'تفاصيل العرض',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 24),
            _buildDetailRow(
              icon: Icons.calendar_today,
              label: 'تاريخ الإرسال',
              value:
                  '${quote.submittedAt.day}/${quote.submittedAt.month}/${quote.submittedAt.year}',
            ),
            if (quote.validUntil != null) ...[
              const SizedBox(height: 12),
              _buildDetailRow(
                icon: Icons.timer,
                label: 'صالح حتى',
                value:
                    '${quote.validUntil!.day}/${quote.validUntil!.month}/${quote.validUntil!.year}',
              ),
            ],
            const SizedBox(height: 12),
            _buildDetailRow(
              icon: Icons.info_outline,
              label: 'الحالة',
              value: _getStatusLabel(quote.status),
              valueColor: _getStatusColor(quote.status),
            ),
            if (quote.notes != null && quote.notes!.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'ملاحظات الصنايعي',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  quote.notes!,
                  style: TextStyle(
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(color: Colors.grey[600]),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'pending':
        return 'في الانتظار';
      case 'accepted':
        return 'مقبول';
      case 'rejected':
        return 'مرفوض';
      case 'expired':
        return 'منتهي الصلاحية';
      default:
        return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'expired':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}
