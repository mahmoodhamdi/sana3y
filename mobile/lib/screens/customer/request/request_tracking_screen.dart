import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../models/request.dart';
import '../../../providers/request_provider.dart';

class RequestTrackingScreen extends ConsumerWidget {
  final String requestId;

  const RequestTrackingScreen({super.key, required this.requestId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestAsync = ref.watch(requestDetailProvider(requestId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('تتبع الطلب'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(requestDetailProvider(requestId)),
          ),
        ],
      ),
      body: requestAsync.when(
        data: (request) => _buildContent(context, ref, request),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('فشل في تحميل الطلب: $error'),
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

  Widget _buildContent(BuildContext context, WidgetRef ref, ServiceRequest request) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(requestDetailProvider(requestId));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            _StatusCard(request: request),
            const SizedBox(height: 16),

            // Request Info
            _RequestInfoCard(request: request),
            const SizedBox(height: 16),

            // Assigned Craftsman (if any)
            if (request.assignedCraftsman != null) ...[
              _AssignedCraftsmanCard(
                craftsman: request.assignedCraftsman!,
                onTap: () {
                  context.push('/craftsman/${request.assignedCraftsman!.id}');
                },
              ),
              const SizedBox(height: 16),
            ],

            // Quotes Section
            if (request.status == RequestStatus.quoted ||
                request.status == RequestStatus.pending) ...[
              _QuotesSection(
                quotes: request.quotes,
                onAccept: (quoteId) async {
                  try {
                    await ref
                        .read(customerRequestsNotifierProvider.notifier)
                        .acceptQuote(requestId, quoteId);
                    ref.invalidate(requestDetailProvider(requestId));
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('فشل في قبول العرض: $e')),
                      );
                    }
                  }
                },
                onReject: (quoteId) async {
                  try {
                    await ref
                        .read(customerRequestsNotifierProvider.notifier)
                        .rejectQuote(requestId, quoteId);
                    ref.invalidate(requestDetailProvider(requestId));
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('فشل في رفض العرض: $e')),
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 16),
            ],

            // Status Timeline
            _StatusTimeline(request: request),
            const SizedBox(height: 16),

            // Actions
            if (request.canCancel)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _showCancelDialog(context, ref, request),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                  child: const Text('إلغاء الطلب'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context, WidgetRef ref, ServiceRequest request) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إلغاء الطلب'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('هل أنت متأكد من إلغاء هذا الطلب؟'),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'سبب الإلغاء (اختياري)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('تراجع'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await ref
                    .read(customerRequestsNotifierProvider.notifier)
                    .cancelRequest(requestId, reason: reasonController.text);
                ref.invalidate(requestDetailProvider(requestId));
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('فشل في إلغاء الطلب: $e')),
                  );
                }
              }
            },
            child: const Text(
              'تأكيد الإلغاء',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final ServiceRequest request;

  const _StatusCard({required this.request});

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(request.status);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(
            _getStatusIcon(request.status),
            size: 48,
            color: statusColor,
          ),
          const SizedBox(height: 12),
          Text(
            request.statusLabel,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            request.requestNumber,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          if (request.status == RequestStatus.quoted) ...[
            const SizedBox(height: 8),
            Text(
              '${request.quotesCount} عرض سعر',
              style: TextStyle(color: statusColor, fontWeight: FontWeight.w500),
            ),
          ],
        ],
      ),
    );
  }

  Color _getStatusColor(RequestStatus status) {
    switch (status) {
      case RequestStatus.pending:
        return Colors.orange;
      case RequestStatus.quoted:
        return Colors.blue;
      case RequestStatus.accepted:
        return Colors.purple;
      case RequestStatus.inProgress:
        return Colors.teal;
      case RequestStatus.arrived:
        return Colors.green;
      case RequestStatus.completed:
        return Colors.green;
      case RequestStatus.cancelled:
        return Colors.red;
      case RequestStatus.disputed:
        return Colors.orange;
      case RequestStatus.refunded:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(RequestStatus status) {
    switch (status) {
      case RequestStatus.pending:
        return Icons.hourglass_empty;
      case RequestStatus.quoted:
        return Icons.local_offer;
      case RequestStatus.accepted:
        return Icons.handshake;
      case RequestStatus.inProgress:
        return Icons.engineering;
      case RequestStatus.arrived:
        return Icons.location_on;
      case RequestStatus.completed:
        return Icons.check_circle;
      case RequestStatus.cancelled:
        return Icons.cancel;
      case RequestStatus.disputed:
        return Icons.gavel;
      case RequestStatus.refunded:
        return Icons.replay;
    }
  }
}

class _RequestInfoCard extends StatelessWidget {
  final ServiceRequest request;

  const _RequestInfoCard({required this.request});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: request.category.icon != null
                      ? Image.network(
                          request.category.icon!,
                          width: 24,
                          height: 24,
                        )
                      : Icon(
                          Icons.category,
                          color: Theme.of(context).primaryColor,
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        request.category.nameAr,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ),
                _UrgencyBadge(urgency: request.urgency),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              request.description,
              style: TextStyle(color: Colors.grey[700], height: 1.5),
            ),
            const Divider(height: 24),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${request.location.address}\n${request.location.city}، ${request.location.governorate}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ),
              ],
            ),
            if (request.preferredDate != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    '${request.preferredDate!.day}/${request.preferredDate!.month}/${request.preferredDate!.year}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
            ],
            if (request.acceptedQuote != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('المبلغ المتفق عليه'),
                    Text(
                      '${request.acceptedQuote!.amount.toInt()} ج.م',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _UrgencyBadge extends StatelessWidget {
  final RequestUrgency urgency;

  const _UrgencyBadge({required this.urgency});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (urgency) {
      case RequestUrgency.normal:
        color = Colors.grey;
        label = 'عادي';
        break;
      case RequestUrgency.urgent:
        color = Colors.orange;
        label = 'مستعجل';
        break;
      case RequestUrgency.emergency:
        color = Colors.red;
        label = 'طوارئ';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _AssignedCraftsmanCard extends StatelessWidget {
  final CraftsmanSummary craftsman;
  final VoidCallback onTap;

  const _AssignedCraftsmanCard({
    required this.craftsman,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundImage: craftsman.profileImage != null
              ? NetworkImage(craftsman.profileImage!)
              : null,
          child: craftsman.profileImage == null
              ? const Icon(Icons.person)
              : null,
        ),
        title: Text(craftsman.displayName),
        subtitle: Row(
          children: [
            const Icon(Icons.star, size: 16, color: Colors.amber),
            const SizedBox(width: 4),
            Text('${craftsman.rating?.toStringAsFixed(1) ?? '0.0'}'),
            const SizedBox(width: 8),
            Text('${craftsman.completedJobs ?? 0} عمل'),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}

class _QuotesSection extends StatelessWidget {
  final List<Quote> quotes;
  final Function(String) onAccept;
  final Function(String) onReject;

  const _QuotesSection({
    required this.quotes,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final pendingQuotes = quotes.where((q) => q.status == 'pending').toList();

    if (pendingQuotes.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Icon(Icons.hourglass_empty, size: 48, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'في انتظار عروض الأسعار',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Text(
                'سيتم إعلامك عند وصول عروض جديدة',
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'عروض الأسعار (${pendingQuotes.length})',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...pendingQuotes.map((quote) => _QuoteCard(
              quote: quote,
              onAccept: () => onAccept(quote.id),
              onReject: () => onReject(quote.id),
            )),
      ],
    );
  }
}

class _QuoteCard extends StatelessWidget {
  final Quote quote;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const _QuoteCard({
    required this.quote,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                      Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                          Text(
                            ' ${quote.craftsman.rating?.toStringAsFixed(1) ?? '0.0'} • ${quote.craftsman.completedJobs ?? 0} عمل',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${quote.amount.toInt()} ج.م',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    if (quote.estimatedDuration != null)
                      Text(
                        quote.estimatedDuration!,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                  ],
                ),
              ],
            ),
            if (quote.notes != null && quote.notes!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                quote.notes!,
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onReject,
                    child: const Text('رفض'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: onAccept,
                    child: const Text('قبول العرض'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusTimeline extends StatelessWidget {
  final ServiceRequest request;

  const _StatusTimeline({required this.request});

  @override
  Widget build(BuildContext context) {
    final timeline = [
      _TimelineStep(
        status: RequestStatus.pending,
        title: 'تم إنشاء الطلب',
        timestamp: request.createdAt,
        isCompleted: true,
      ),
      if (request.quotes.isNotEmpty)
        _TimelineStep(
          status: RequestStatus.quoted,
          title: 'تم استلام عروض الأسعار',
          timestamp: request.quotes.first.submittedAt,
          isCompleted: true,
        ),
      if (request.assignedCraftsman != null)
        _TimelineStep(
          status: RequestStatus.accepted,
          title: 'تم قبول العرض',
          timestamp: null,
          isCompleted: true,
        ),
      if (request.startedAt != null)
        _TimelineStep(
          status: RequestStatus.inProgress,
          title: 'بدأ العمل',
          timestamp: request.startedAt,
          isCompleted: true,
        ),
      if (request.arrivedAt != null)
        _TimelineStep(
          status: RequestStatus.arrived,
          title: 'وصل الصنايعي',
          timestamp: request.arrivedAt,
          isCompleted: true,
        ),
      if (request.completedAt != null)
        _TimelineStep(
          status: RequestStatus.completed,
          title: 'تم إكمال العمل',
          timestamp: request.completedAt,
          isCompleted: true,
        ),
      if (request.cancelledAt != null)
        _TimelineStep(
          status: RequestStatus.cancelled,
          title: 'تم إلغاء الطلب',
          timestamp: request.cancelledAt,
          isCompleted: true,
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'مراحل الطلب',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...timeline.map((step) => _TimelineItem(step: step)),
      ],
    );
  }
}

class _TimelineStep {
  final RequestStatus status;
  final String title;
  final DateTime? timestamp;
  final bool isCompleted;

  _TimelineStep({
    required this.status,
    required this.title,
    this.timestamp,
    required this.isCompleted,
  });
}

class _TimelineItem extends StatelessWidget {
  final _TimelineStep step;

  const _TimelineItem({required this.step});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: step.isCompleted
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: step.isCompleted
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            Container(
              width: 2,
              height: 40,
              color: Colors.grey[300],
            ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.title,
                style: TextStyle(
                  fontWeight: step.isCompleted ? FontWeight.w500 : FontWeight.normal,
                  color: step.isCompleted ? Colors.black : Colors.grey,
                ),
              ),
              if (step.timestamp != null)
                Text(
                  '${step.timestamp!.day}/${step.timestamp!.month} - ${step.timestamp!.hour}:${step.timestamp!.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
