import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/request.dart';
import '../../providers/request_provider.dart';

class CraftsmanRequestDetailsScreen extends ConsumerWidget {
  final String requestId;

  const CraftsmanRequestDetailsScreen({super.key, required this.requestId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestAsync = ref.watch(requestDetailProvider(requestId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الطلب'),
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status & Urgency Header
          _HeaderCard(request: request),
          const SizedBox(height: 16),

          // Customer Info
          _CustomerCard(customer: request.customer),
          const SizedBox(height: 16),

          // Request Details
          _RequestDetailsCard(request: request),
          const SizedBox(height: 16),

          // Location Card
          _LocationCard(location: request.location),
          const SizedBox(height: 16),

          // Images
          if (request.images.isNotEmpty) ...[
            _ImagesSection(images: request.images),
            const SizedBox(height: 16),
          ],

          // Budget Info
          if (request.budget != null) ...[
            _BudgetCard(budget: request.budget!),
            const SizedBox(height: 16),
          ],

          // Quotes Count
          if (request.quotes.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.people, color: Colors.blue[700]),
                  const SizedBox(width: 8),
                  Text(
                    '${request.quotes.length} عرض مقدم',
                    style: TextStyle(color: Colors.blue[700]),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 24),

          // Action Button
          if (request.status == RequestStatus.pending)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.push('/craftsman/request/$requestId/quote');
                },
                icon: const Icon(Icons.send),
                label: const Text('تقديم عرض سعر'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final ServiceRequest request;

  const _HeaderCard({required this.request});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  request.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _UrgencyBadge(urgency: request.urgency),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.category, color: Colors.white70, size: 16),
              const SizedBox(width: 4),
              Text(
                request.category.nameAr,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.white70, size: 16),
              const SizedBox(width: 4),
              Text(
                _getTimeAgo(request.createdAt),
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) {
      return 'منذ ${diff.inMinutes} دقيقة';
    } else if (diff.inHours < 24) {
      return 'منذ ${diff.inHours} ساعة';
    } else {
      return 'منذ ${diff.inDays} يوم';
    }
  }
}

class _UrgencyBadge extends StatelessWidget {
  final RequestUrgency urgency;

  const _UrgencyBadge({required this.urgency});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;
    IconData icon;

    switch (urgency) {
      case RequestUrgency.normal:
        color = Colors.white;
        label = 'عادي';
        icon = Icons.schedule;
        break;
      case RequestUrgency.urgent:
        color = Colors.orange;
        label = 'مستعجل';
        icon = Icons.bolt;
        break;
      case RequestUrgency.emergency:
        color = Colors.red;
        label = 'طوارئ';
        icon = Icons.warning;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _CustomerCard extends StatelessWidget {
  final CustomerSummary customer;

  const _CustomerCard({required this.customer});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:
              customer.avatar != null ? NetworkImage(customer.avatar!) : null,
          child: customer.avatar == null ? const Icon(Icons.person) : null,
        ),
        title: Text(
          customer.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text('صاحب الطلب'),
      ),
    );
  }
}

class _RequestDetailsCard extends StatelessWidget {
  final ServiceRequest request;

  const _RequestDetailsCard({required this.request});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'وصف المشكلة',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              request.description,
              style: TextStyle(
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),
            if (request.preferredDate != null) ...[
              const Divider(height: 24),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 18, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    'الموعد المفضل: ',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Text(
                    '${request.preferredDate!.day}/${request.preferredDate!.month}/${request.preferredDate!.year}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
            if (request.preferredTime != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.access_time, size: 18, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    'الوقت المفضل: ',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Text(
                    '${request.preferredTime!.start} - ${request.preferredTime!.end}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                  'موقع العمل',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              location.address,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 4),
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
          'صور المشكلة',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _showImageDialog(context, images[index]);
                },
                child: Container(
                  margin: EdgeInsets.only(left: index == images.length - 1 ? 0 : 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      images[index],
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 120,
                        height: 120,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image_not_supported, size: 40),
                      ),
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

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BudgetCard extends StatelessWidget {
  final RequestBudget budget;

  const _BudgetCard({required this.budget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green[100],
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.attach_money, color: Colors.green[700]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ميزانية العميل',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '${budget.min.toInt()} - ${budget.max.toInt()} ج.م',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
