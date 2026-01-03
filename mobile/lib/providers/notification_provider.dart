import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/notification_service.dart';

part 'notification_provider.g.dart';

@riverpod
class NotificationsState extends _$NotificationsState {
  @override
  Future<NotificationsResponse> build() async {
    return _fetchNotifications();
  }

  Future<NotificationsResponse> _fetchNotifications({int page = 1}) async {
    final service = ref.read(notificationServiceProvider);
    return service.getNotifications(page: page);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchNotifications());
  }

  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null || current.page >= current.totalPages) return;

    final moreData = await _fetchNotifications(page: current.page + 1);
    state = AsyncData(NotificationsResponse(
      notifications: [...current.notifications, ...moreData.notifications],
      page: moreData.page,
      totalPages: moreData.totalPages,
      total: moreData.total,
      unreadCount: moreData.unreadCount,
    ));
  }

  Future<void> markAsRead(String id) async {
    final service = ref.read(notificationServiceProvider);
    await service.markAsRead(id);

    final current = state.valueOrNull;
    if (current != null) {
      final updated = current.notifications.map((n) {
        if (n.id == id) {
          return NotificationData(
            id: n.id,
            title: n.title,
            body: n.body,
            type: n.type,
            data: n.data,
            isRead: true,
            createdAt: n.createdAt,
          );
        }
        return n;
      }).toList();

      state = AsyncData(NotificationsResponse(
        notifications: updated,
        page: current.page,
        totalPages: current.totalPages,
        total: current.total,
        unreadCount: current.unreadCount - 1,
      ));
    }
  }

  Future<void> markAllAsRead() async {
    final service = ref.read(notificationServiceProvider);
    await service.markAllAsRead();
    await refresh();
  }

  Future<void> deleteNotification(String id) async {
    final service = ref.read(notificationServiceProvider);
    await service.deleteNotification(id);

    final current = state.valueOrNull;
    if (current != null) {
      final updated = current.notifications.where((n) => n.id != id).toList();
      state = AsyncData(NotificationsResponse(
        notifications: updated,
        page: current.page,
        totalPages: current.totalPages,
        total: current.total - 1,
        unreadCount: current.unreadCount,
      ));
    }
  }
}

@riverpod
Future<int> unreadNotificationCount(Ref ref) async {
  final service = ref.watch(notificationServiceProvider);
  return service.getUnreadCount();
}
