import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/request.dart';
import '../../providers/request_provider.dart';

class ActiveJobsScreen extends ConsumerWidget {
  const ActiveJobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(activeJobsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('أعمالي النشطة'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(activeJobsNotifierProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: jobsAsync.when(
        data: (jobs) {
          if (jobs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.work_off, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد أعمال نشطة',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => context.push('/craftsman/requests/available'),
                    child: const Text('استعرض الطلبات المتاحة'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(activeJobsNotifierProvider.notifier).refresh();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final job = jobs[index];
                return _ActiveJobCard(
                  job: job,
                  onStatusUpdate: (status) => _updateStatus(context, ref, job, status),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('خطأ: $e')),
      ),
    );
  }

  Future<void> _updateStatus(
    BuildContext context,
    WidgetRef ref,
    ServiceRequest job,
    RequestStatus status,
  ) async {
    try {
      await ref.read(activeJobsNotifierProvider.notifier).updateStatus(
            job.id,
            status,
          );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم تحديث الحالة')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل في تحديث الحالة: $e')),
        );
      }
    }
  }
}

class _ActiveJobCard extends StatelessWidget {
  final ServiceRequest job;
  final Function(RequestStatus) onStatusUpdate;

  const _ActiveJobCard({
    required this.job,
    required this.onStatusUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          // Header with status
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getStatusColor(job.status).withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Icon(
                  _getStatusIcon(job.status),
                  color: _getStatusColor(job.status),
                ),
                const SizedBox(width: 8),
                Text(
                  job.statusLabel,
                  style: TextStyle(
                    color: _getStatusColor(job.status),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  job.requestNumber,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: job.customer.avatar != null
                          ? NetworkImage(job.customer.avatar!)
                          : null,
                      child: job.customer.avatar == null
                          ? const Icon(Icons.person, size: 16)
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.customer.name,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          if (job.customer.phone != null)
                            Text(
                              job.customer.phone!,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (job.acceptedQuote != null)
                      Text(
                        '${job.acceptedQuote!.amount.toInt()} ج.م',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        job.location.address,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Actions
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Open phone/WhatsApp
                    },
                    icon: const Icon(Icons.phone),
                    label: const Text('اتصال'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => _showNextAction(context),
                    child: Text(_getNextActionLabel(job.status)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showNextAction(BuildContext context) {
    final nextStatus = _getNextStatus(job.status);
    if (nextStatus == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_getNextActionLabel(job.status)),
        content: Text(_getConfirmMessage(nextStatus)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onStatusUpdate(nextStatus);
            },
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  String _getNextActionLabel(RequestStatus status) {
    switch (status) {
      case RequestStatus.accepted:
        return 'بدء العمل';
      case RequestStatus.inProgress:
        return 'وصلت للموقع';
      case RequestStatus.arrived:
        return 'إكمال العمل';
      default:
        return 'متابعة';
    }
  }

  RequestStatus? _getNextStatus(RequestStatus status) {
    switch (status) {
      case RequestStatus.accepted:
        return RequestStatus.inProgress;
      case RequestStatus.inProgress:
        return RequestStatus.arrived;
      case RequestStatus.arrived:
        return RequestStatus.completed;
      default:
        return null;
    }
  }

  String _getConfirmMessage(RequestStatus status) {
    switch (status) {
      case RequestStatus.inProgress:
        return 'هل أنت متأكد من بدء العمل؟';
      case RequestStatus.arrived:
        return 'هل وصلت لموقع العميل؟';
      case RequestStatus.completed:
        return 'هل تم إكمال العمل بنجاح؟';
      default:
        return 'هل أنت متأكد؟';
    }
  }

  Color _getStatusColor(RequestStatus status) {
    switch (status) {
      case RequestStatus.accepted:
        return Colors.purple;
      case RequestStatus.inProgress:
        return Colors.teal;
      case RequestStatus.arrived:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(RequestStatus status) {
    switch (status) {
      case RequestStatus.accepted:
        return Icons.handshake;
      case RequestStatus.inProgress:
        return Icons.engineering;
      case RequestStatus.arrived:
        return Icons.location_on;
      default:
        return Icons.work;
    }
  }
}
