// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$unreadNotificationCountHash() =>
    r'318329319a3ac8fa18f46d44a16b3fb78239e011';

/// See also [unreadNotificationCount].
@ProviderFor(unreadNotificationCount)
final unreadNotificationCountProvider = AutoDisposeFutureProvider<int>.internal(
  unreadNotificationCount,
  name: r'unreadNotificationCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$unreadNotificationCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UnreadNotificationCountRef = AutoDisposeFutureProviderRef<int>;
String _$notificationsStateHash() =>
    r'6538ae0ff0fbd623c6ae9b173a0142a4cbf3b15d';

/// See also [NotificationsState].
@ProviderFor(NotificationsState)
final notificationsStateProvider = AutoDisposeAsyncNotifierProvider<
    NotificationsState, NotificationsResponse>.internal(
  NotificationsState.new,
  name: r'notificationsStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationsStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NotificationsState = AutoDisposeAsyncNotifier<NotificationsResponse>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
