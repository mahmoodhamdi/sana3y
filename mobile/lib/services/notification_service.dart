import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'api_client.dart';

part 'notification_service.g.dart';

// Singleton for early initialization (before Riverpod is available)
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  static NotificationService get instance => _instance;

  NotificationService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  String? _fcmToken;

  String? get fcmToken => _fcmToken;

  Future<void> initialize() async {
    // Request permission
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    debugPrint('FCM Authorization status: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      // Get FCM token
      _fcmToken = await _messaging.getToken();
      debugPrint('FCM Token: $_fcmToken');

      // Listen for token refresh
      _messaging.onTokenRefresh.listen((newToken) {
        _fcmToken = newToken;
        debugPrint('FCM Token refreshed: $newToken');
      });

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('Foreground message received: ${message.notification?.title}');
      });
    }
  }
}

class NotificationData {
  final String id;
  final String title;
  final String body;
  final String type;
  final Map<String, dynamic> data;
  final bool isRead;
  final DateTime createdAt;

  NotificationData({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.data,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json['_id'] ?? json['id'] ?? '',
      title: json['titleAr'] ?? json['title'] ?? '',
      body: json['bodyAr'] ?? json['body'] ?? '',
      type: json['type'] ?? 'system',
      data: json['data'] ?? {},
      isRead: json['isRead'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
}

class NotificationsResponse {
  final List<NotificationData> notifications;
  final int page;
  final int totalPages;
  final int total;
  final int unreadCount;

  NotificationsResponse({
    required this.notifications,
    required this.page,
    required this.totalPages,
    required this.total,
    required this.unreadCount,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    final notificationsList = (json['notifications'] as List?)
            ?.map((e) => NotificationData.fromJson(e))
            .toList() ??
        [];
    final pagination = json['pagination'] ?? {};
    return NotificationsResponse(
      notifications: notificationsList,
      page: pagination['page'] ?? 1,
      totalPages: pagination['totalPages'] ?? 1,
      total: pagination['total'] ?? 0,
      unreadCount: json['unreadCount'] ?? 0,
    );
  }
}

@riverpod
NotificationApiService notificationApiService(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return NotificationApiService(apiClient);
}

class NotificationApiService {
  final ApiClient _apiClient;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  NotificationApiService(this._apiClient);

  // Initialize Firebase Messaging and register token
  Future<void> initialize() async {
    final token = NotificationService.instance.fcmToken;
    if (token != null) {
      await registerFCMToken(token);
    }

    // Listen for token refresh
    _messaging.onTokenRefresh.listen((newToken) {
      registerFCMToken(newToken);
    });
  }

  // Register FCM token with backend
  Future<void> registerFCMToken(String token) async {
    try {
      await _apiClient.post('/notifications/fcm-token', data: {'token': token});
    } catch (e) {
      // Silently fail - non-critical
    }
  }

  // Remove FCM token
  Future<void> removeFCMToken(String token) async {
    try {
      await _apiClient.delete('/notifications/fcm-token');
    } catch (e) {
      // Silently fail
    }
  }

  // Get user's notifications
  Future<NotificationsResponse> getNotifications({int page = 1, int limit = 20}) async {
    try {
      final response = await _apiClient.get(
        '/notifications',
        queryParameters: {'page': page, 'limit': limit},
      );
      return NotificationsResponse.fromJson(response.data['data']);
    } catch (e) {
      return NotificationsResponse(
        notifications: [],
        page: 1,
        totalPages: 1,
        total: 0,
        unreadCount: 0,
      );
    }
  }

  // Get unread count
  Future<int> getUnreadCount() async {
    try {
      final response = await _apiClient.get('/notifications/unread-count');
      return response.data['data']['count'] ?? 0;
    } catch (e) {
      return 0;
    }
  }

  // Mark notification as read
  Future<bool> markAsRead(String notificationId) async {
    try {
      await _apiClient.put('/notifications/$notificationId/read');
      return true;
    } catch (e) {
      return false;
    }
  }

  // Mark all as read
  Future<int> markAllAsRead() async {
    try {
      final response = await _apiClient.put('/notifications/read-all');
      return response.data['data']['count'] ?? 0;
    } catch (e) {
      return 0;
    }
  }

  // Delete notification
  Future<bool> deleteNotification(String notificationId) async {
    try {
      await _apiClient.delete('/notifications/$notificationId');
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get FCM token
  Future<String?> getFCMToken() async {
    return _messaging.getToken();
  }
}
