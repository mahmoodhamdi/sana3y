import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/request.dart';
import '../../providers/request_provider.dart';

class JobsHistoryScreen extends ConsumerWidget {
  const JobsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(completedJobsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل الأعمال'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      body: jobsAsync.when(
        data: (jobs) => jobs.isEmpty
            ? _buildEmptyState()
            : _buildJobsList(context, ref, jobs),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('فشل في تحميل السجل: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.read(completedJobsNotifierProvider.notifier).refresh(),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text(
            'لا توجد أعمال مكتملة',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'ستظهر أعمالك المكتملة هنا',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildJobsList(
    BuildContext context,
    WidgetRef ref,
    List<ServiceRequest> jobs,
  ) {
    final notifier = ref.read(completedJobsNotifierProvider.notifier);

    return RefreshIndicator(
      onRefresh: () => notifier.refresh(),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              notification.metrics.extentAfter == 0 &&
              notifier.hasMore) {
            notifier.loadMore();
          }
          return false;
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            return _JobHistoryCard(
              job: jobs[index],
              onTap: () => context.push('/craftsman/job/${jobs[index].id}'),
            );
          },
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'تصفية حسب',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text('هذا الشهر'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text('آخر 3 أشهر'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('اختر تاريخ'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _JobHistoryCard extends StatelessWidget {
  final ServiceRequest job;
  final VoidCallback onTap;

  const _JobHistoryCard({required this.job, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final amount = job.actualAmount ?? job.acceptedQuote?.amount ?? 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
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
                        const SizedBox(height: 4),
                        Text(
                          job.category.nameAr,
                          style: TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${amount.toInt()} ج.م',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      if (job.completedAt != null)
                        Text(
                          '${job.completedAt!.day}/${job.completedAt!.month}/${job.completedAt!.year}',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 24),
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
                  Text(
                    job.customer.name,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle, size: 14, color: Colors.green),
                        const SizedBox(width: 4),
                        Text(
                          'مكتمل',
                          style: TextStyle(
                            color: Colors.green[700],
                            fontSize: 12,
                          ),
                        ),
                      ],
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
}
