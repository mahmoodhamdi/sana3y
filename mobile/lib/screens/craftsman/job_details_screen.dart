import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/request.dart';
import '../../providers/request_provider.dart';

class JobDetailsScreen extends ConsumerWidget {
  final String jobId;

  const JobDetailsScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobAsync = ref.watch(requestDetailProvider(jobId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل العمل'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(requestDetailProvider(jobId)),
          ),
        ],
      ),
      body: jobAsync.when(
        data: (job) => _buildContent(context, ref, job),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('فشل في تحميل العمل: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(requestDetailProvider(jobId)),
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, ServiceRequest job) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(requestDetailProvider(jobId));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            _StatusCard(job: job),
            const SizedBox(height: 16),

            // Customer Info
            _CustomerCard(
              customer: job.customer,
              onChat: () {
                // Navigate to chat
                context.push('/chat/${job.id}');
              },
              onCall: () {
                // Make call
              },
            ),
            const SizedBox(height: 16),

            // Job Details
            _JobDetailsCard(job: job),
            const SizedBox(height: 16),

            // Location
            _LocationCard(location: job.location),
            const SizedBox(height: 16),

            // Images
            if (job.images.isNotEmpty) ...[
              _ImagesSection(images: job.images),
              const SizedBox(height: 16),
            ],

            // Action Buttons based on status
            _ActionButtons(
              job: job,
              onUpdateStatus: (status, {String? notes, double? amount}) async {
                try {
                  await ref.read(activeJobsNotifierProvider.notifier).updateStatus(
                        job.id,
                        status,
                        completionNotes: notes,
                        actualAmount: amount,
                      );
                  ref.invalidate(requestDetailProvider(jobId));

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
              },
              onComplete: () {
                context.push('/craftsman/job/${job.id}/complete');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final ServiceRequest job;

  const _StatusCard({required this.job});

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(job.status);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(_getStatusIcon(job.status), size: 48, color: statusColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.statusLabel,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  job.requestNumber,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
          if (job.acceptedQuote != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${job.acceptedQuote!.amount.toInt()} ج.م',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'السعر المتفق',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Color _getStatusColor(RequestStatus status) {
    switch (status) {
      case RequestStatus.accepted:
        return Colors.purple;
      case RequestStatus.inProgress:
        return Colors.teal;
      case RequestStatus.arrived:
        return Colors.green;
      case RequestStatus.completed:
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
      case RequestStatus.completed:
        return Icons.check_circle;
      default:
        return Icons.work;
    }
  }
}

class _CustomerCard extends StatelessWidget {
  final CustomerSummary customer;
  final VoidCallback onChat;
  final VoidCallback onCall;

  const _CustomerCard({
    required this.customer,
    required this.onChat,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: customer.avatar != null
                  ? NetworkImage(customer.avatar!)
                  : null,
              child: customer.avatar == null
                  ? const Icon(Icons.person, size: 28)
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (customer.phone != null)
                    Text(
                      customer.phone!,
                      style: TextStyle(color: Colors.grey[600]),
                      textDirection: TextDirection.ltr,
                    ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chat_outlined),
              color: Theme.of(context).primaryColor,
              onPressed: onChat,
            ),
            IconButton(
              icon: const Icon(Icons.phone_outlined),
              color: Colors.green,
              onPressed: onCall,
            ),
          ],
        ),
      ),
    );
  }
}

class _JobDetailsCard extends StatelessWidget {
  final ServiceRequest job;

  const _JobDetailsCard({required this.job});

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
                  child: Icon(
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
                        job.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        job.category.nameAr,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Text(
              job.description,
              style: TextStyle(color: Colors.grey[700], height: 1.5),
            ),
            if (job.preferredDate != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    'الموعد المفضل: ${job.preferredDate!.day}/${job.preferredDate!.month}/${job.preferredDate!.year}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  final RequestLocation location;

  const _LocationCard({required this.location});

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
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 8),
                const Text(
                  'الموقع',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              location.address,
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              '${location.city}، ${location.governorate}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  // Open in maps
                },
                icon: const Icon(Icons.map),
                label: const Text('فتح في الخريطة'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagesSection extends StatelessWidget {
  final List<String> images;

  const _ImagesSection({required this.images});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'صور الطلب',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: index == images.length - 1 ? 0 : 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    images[index],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 100,
                      height: 100,
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
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final ServiceRequest job;
  final Function(RequestStatus, {String? notes, double? amount}) onUpdateStatus;
  final VoidCallback onComplete;

  const _ActionButtons({
    required this.job,
    required this.onUpdateStatus,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    if (job.status == RequestStatus.completed ||
        job.status == RequestStatus.cancelled) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        if (job.status == RequestStatus.accepted)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => onUpdateStatus(RequestStatus.inProgress),
              icon: const Icon(Icons.play_arrow),
              label: const Text('بدء العمل'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        if (job.status == RequestStatus.inProgress)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => onUpdateStatus(RequestStatus.arrived),
              icon: const Icon(Icons.location_on),
              label: const Text('وصلت للموقع'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        if (job.status == RequestStatus.arrived ||
            job.status == RequestStatus.inProgress)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onComplete,
                icon: const Icon(Icons.check_circle),
                label: const Text('إتمام العمل'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => _showCancelDialog(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
            ),
            child: const Text('إلغاء العمل'),
          ),
        ),
      ],
    );
  }

  void _showCancelDialog(BuildContext context) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إلغاء العمل'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('هل أنت متأكد من إلغاء هذا العمل؟'),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'سبب الإلغاء',
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
            onPressed: () {
              Navigator.pop(context);
              onUpdateStatus(
                RequestStatus.cancelled,
                notes: reasonController.text,
              );
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
