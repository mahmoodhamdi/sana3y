import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/request.dart';
import '../../providers/request_provider.dart';

class RequestDetailsScreen extends ConsumerWidget {
  final String requestId;

  const RequestDetailsScreen({super.key, required this.requestId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestAsync = ref.watch(requestDetailProvider(requestId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الطلب'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: requestAsync.when(
        data: (request) => _buildRequestDetails(context, ref, request),
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

  Widget _buildRequestDetails(BuildContext context, WidgetRef ref, ServiceRequest request) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Card
          _StatusCard(status: request.status),
          const SizedBox(height: 16),

          // Request Info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.build,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              request.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              request.category.nameAr,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  const Text(
                    'الوصف',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    request.description,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  if (request.images.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'الصور',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: request.images.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                request.images[index],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.broken_image),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Location
          Card(
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.location_on, color: Colors.blue[700]),
              ),
              title: const Text('العنوان'),
              subtitle: Text(request.location.address),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 16),

          // Date & Time
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.grey[600]),
                        const SizedBox(height: 8),
                        const Text('تاريخ الإنشاء'),
                        const SizedBox(height: 4),
                        Text(
                          '${request.createdAt.day}/${request.createdAt.month}/${request.createdAt.year}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 60, color: Colors.grey[300]),
                  Expanded(
                    child: Column(
                      children: [
                        Icon(
                          request.urgency == RequestUrgency.urgent
                              ? Icons.bolt
                              : Icons.access_time,
                          color: request.urgency == RequestUrgency.urgent
                              ? Colors.orange
                              : Colors.grey[600],
                        ),
                        const SizedBox(height: 8),
                        const Text('الأولوية'),
                        const SizedBox(height: 4),
                        Text(
                          request.urgency == RequestUrgency.urgent ? 'عاجل' : 'عادي',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: request.urgency == RequestUrgency.urgent
                                ? Colors.orange
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Quotes Section
          if (request.quotes.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'عروض الأسعار (${request.quotes.length})',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => context.push('/request/$requestId/quotes'),
                  child: const Text('عرض الكل'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...request.quotes.take(2).map((quote) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: quote.craftsman.profileImage != null
                      ? NetworkImage(quote.craftsman.profileImage!)
                      : null,
                  child: quote.craftsman.profileImage == null
                      ? const Icon(Icons.person)
                      : null,
                ),
                title: Text(quote.craftsman.displayName),
                subtitle: Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text((quote.craftsman.rating ?? 0).toStringAsFixed(1)),
                  ],
                ),
                trailing: Text(
                  '${quote.amount.toInt()} ج.م',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
                onTap: () => context.push('/request/$requestId/quotes'),
              ),
            )),
          ],

          // Assigned Craftsman
          if (request.assignedCraftsman != null) ...[
            const SizedBox(height: 16),
            const Text(
              'الصنايعي المختار',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 24,
                  backgroundImage: request.assignedCraftsman!.profileImage != null
                      ? NetworkImage(request.assignedCraftsman!.profileImage!)
                      : null,
                  child: request.assignedCraftsman!.profileImage == null
                      ? const Icon(Icons.person)
                      : null,
                ),
                title: Text(request.assignedCraftsman!.displayName),
                subtitle: Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text((request.assignedCraftsman!.rating ?? 0).toStringAsFixed(1)),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chat_bubble_outline),
                      onPressed: () {
                        // Navigate to chat
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.phone_outlined),
                      onPressed: () {
                        // Make phone call
                      },
                    ),
                  ],
                ),
                onTap: () => context.push(
                  '/craftsman/${request.assignedCraftsman!.id}',
                ),
              ),
            ),
          ],
          const SizedBox(height: 32),

          // Action Buttons
          if (request.status == RequestStatus.pending) ...[
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _cancelRequest(context, ref, requestId),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                ),
                child: const Text('إلغاء الطلب'),
              ),
            ),
          ],
          if (request.status == RequestStatus.completed) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.push(
                  '/rate/${request.id}',
                  extra: {
                    'craftsmanName': request.assignedCraftsman?.displayName ?? 'الصنايعي',
                  },
                ),
                icon: const Icon(Icons.star),
                label: const Text('تقييم الخدمة'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _cancelRequest(BuildContext context, WidgetRef ref, String requestId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إلغاء الطلب'),
        content: const Text('هل أنت متأكد من إلغاء هذا الطلب؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('لا'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('نعم، إلغاء', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await ref.read(customerRequestsNotifierProvider.notifier).cancelRequest(requestId);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إلغاء الطلب'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل في إلغاء الطلب: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

class _StatusCard extends StatelessWidget {
  final RequestStatus status;

  const _StatusCard({required this.status});

  @override
  Widget build(BuildContext context) {
    final statusInfo = _getStatusInfo(status);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusInfo.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusInfo.color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: statusInfo.color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(statusInfo.icon, color: statusInfo.color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusInfo.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: statusInfo.color,
                    fontSize: 16,
                  ),
                ),
                Text(
                  statusInfo.description,
                  style: TextStyle(
                    color: statusInfo.color.withValues(alpha: 0.8),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ({Color color, IconData icon, String title, String description}) _getStatusInfo(RequestStatus status) {
    switch (status) {
      case RequestStatus.pending:
        return (
          color: Colors.orange,
          icon: Icons.hourglass_empty,
          title: 'في انتظار العروض',
          description: 'الطلب جاري البحث عن صنايعية',
        );
      case RequestStatus.quoted:
        return (
          color: Colors.blue,
          icon: Icons.request_quote,
          title: 'تم استلام عروض',
          description: 'راجع العروض واختر المناسب',
        );
      case RequestStatus.accepted:
        return (
          color: Colors.purple,
          icon: Icons.check_circle,
          title: 'تم قبول عرض',
          description: 'الصنايعي في الطريق إليك',
        );
      case RequestStatus.arrived:
        return (
          color: Colors.indigo,
          icon: Icons.location_on,
          title: 'وصل الصنايعي',
          description: 'الصنايعي في موقع العمل',
        );
      case RequestStatus.inProgress:
        return (
          color: Colors.teal,
          icon: Icons.engineering,
          title: 'جاري العمل',
          description: 'الصنايعي يعمل على طلبك',
        );
      case RequestStatus.completed:
        return (
          color: Colors.green,
          icon: Icons.check_circle,
          title: 'مكتمل',
          description: 'تم إنهاء العمل بنجاح',
        );
      case RequestStatus.cancelled:
        return (
          color: Colors.red,
          icon: Icons.cancel,
          title: 'ملغي',
          description: 'تم إلغاء هذا الطلب',
        );
      case RequestStatus.disputed:
        return (
          color: Colors.deepOrange,
          icon: Icons.warning,
          title: 'نزاع',
          description: 'يوجد نزاع على هذا الطلب',
        );
      case RequestStatus.refunded:
        return (
          color: Colors.grey,
          icon: Icons.money_off,
          title: 'مسترد',
          description: 'تم استرداد المبلغ',
        );
    }
  }
}
