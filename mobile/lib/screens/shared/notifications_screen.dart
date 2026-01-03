import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../providers/notification_provider.dart';
import '../../services/notification_service.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationsStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإشعارات'),
        actions: [
          notificationsAsync.whenOrNull(
                data: (data) => data.unreadCount > 0
                    ? TextButton(
                        onPressed: () {
                          ref
                              .read(notificationsStateProvider.notifier)
                              .markAllAsRead();
                        },
                        child: const Text('قراءة الكل'),
                      )
                    : null,
              ) ??
              const SizedBox.shrink(),
        ],
      ),
      body: notificationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                'حدث خطأ في تحميل الإشعارات',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(notificationsStateProvider.notifier).refresh();
                },
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
        data: (data) {
          if (data.notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد إشعارات',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ستظهر الإشعارات الجديدة هنا',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[500],
                        ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(notificationsStateProvider.notifier).refresh();
            },
            child: ListView.builder(
              itemCount: data.notifications.length + 1,
              itemBuilder: (context, index) {
                if (index == data.notifications.length) {
                  if (data.page < data.totalPages) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            ref
                                .read(notificationsStateProvider.notifier)
                                .loadMore();
                          },
                          child: const Text('تحميل المزيد'),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }

                final notification = data.notifications[index];
                return _NotificationTile(
                  notification: notification,
                  onTap: () => _handleNotificationTap(
                    context,
                    ref,
                    notification,
                  ),
                  onDelete: () {
                    ref
                        .read(notificationsStateProvider.notifier)
                        .deleteNotification(notification.id);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _handleNotificationTap(
    BuildContext context,
    WidgetRef ref,
    NotificationData notification,
  ) {
    // Mark as read
    if (!notification.isRead) {
      ref.read(notificationsStateProvider.notifier).markAsRead(notification.id);
    }

    // Navigate based on notification type
    switch (notification.type) {
      case 'request':
      case 'quote':
      case 'status':
        final requestId = notification.data['requestId'];
        if (requestId != null) {
          context.push('/request/$requestId');
        }
        break;
      case 'message':
        final conversationId = notification.data['conversationId'];
        if (conversationId != null) {
          context.push('/chat/$conversationId');
        }
        break;
      case 'review':
        // Navigate to reviews
        break;
      default:
        // System notification - no navigation
        break;
    }
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationData notification;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _NotificationTile({
    required this.notification,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDelete(),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: notification.isRead
                ? null
                : theme.primaryColor.withValues(alpha: 0.05),
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[200]!,
                width: 1,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIcon(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: notification.isRead
                            ? FontWeight.normal
                            : FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.body,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(notification.createdAt),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              if (!notification.isRead)
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    IconData icon;
    Color color;

    switch (notification.type) {
      case 'request':
        icon = Icons.assignment;
        color = Colors.blue;
        break;
      case 'quote':
        icon = Icons.attach_money;
        color = Colors.green;
        break;
      case 'status':
        icon = Icons.update;
        color = Colors.orange;
        break;
      case 'message':
        icon = Icons.message;
        color = Colors.purple;
        break;
      case 'review':
        icon = Icons.star;
        color = Colors.amber;
        break;
      default:
        icon = Icons.notifications;
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'الآن';
    } else if (difference.inMinutes < 60) {
      return 'منذ ${difference.inMinutes} دقيقة';
    } else if (difference.inHours < 24) {
      return 'منذ ${difference.inHours} ساعة';
    } else if (difference.inDays < 7) {
      return 'منذ ${difference.inDays} يوم';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }
}
