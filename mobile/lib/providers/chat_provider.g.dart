// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$unreadMessagesCountHash() =>
    r'cb074dfaced2371481d8fb9ad111cb96c92af5b2';

/// See also [unreadMessagesCount].
@ProviderFor(unreadMessagesCount)
final unreadMessagesCountProvider = AutoDisposeFutureProvider<int>.internal(
  unreadMessagesCount,
  name: r'unreadMessagesCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$unreadMessagesCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UnreadMessagesCountRef = AutoDisposeFutureProviderRef<int>;
String _$getOrCreateConversationHash() =>
    r'36d8c9b5d0b030d1c718eed47ab29166a63e09ac';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getOrCreateConversation].
@ProviderFor(getOrCreateConversation)
const getOrCreateConversationProvider = GetOrCreateConversationFamily();

/// See also [getOrCreateConversation].
class GetOrCreateConversationFamily extends Family<AsyncValue<Conversation>> {
  /// See also [getOrCreateConversation].
  const GetOrCreateConversationFamily();

  /// See also [getOrCreateConversation].
  GetOrCreateConversationProvider call({
    required String requestId,
    required String otherUserId,
  }) {
    return GetOrCreateConversationProvider(
      requestId: requestId,
      otherUserId: otherUserId,
    );
  }

  @override
  GetOrCreateConversationProvider getProviderOverride(
    covariant GetOrCreateConversationProvider provider,
  ) {
    return call(
      requestId: provider.requestId,
      otherUserId: provider.otherUserId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getOrCreateConversationProvider';
}

/// See also [getOrCreateConversation].
class GetOrCreateConversationProvider
    extends AutoDisposeFutureProvider<Conversation> {
  /// See also [getOrCreateConversation].
  GetOrCreateConversationProvider({
    required String requestId,
    required String otherUserId,
  }) : this._internal(
          (ref) => getOrCreateConversation(
            ref as GetOrCreateConversationRef,
            requestId: requestId,
            otherUserId: otherUserId,
          ),
          from: getOrCreateConversationProvider,
          name: r'getOrCreateConversationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getOrCreateConversationHash,
          dependencies: GetOrCreateConversationFamily._dependencies,
          allTransitiveDependencies:
              GetOrCreateConversationFamily._allTransitiveDependencies,
          requestId: requestId,
          otherUserId: otherUserId,
        );

  GetOrCreateConversationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.requestId,
    required this.otherUserId,
  }) : super.internal();

  final String requestId;
  final String otherUserId;

  @override
  Override overrideWith(
    FutureOr<Conversation> Function(GetOrCreateConversationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetOrCreateConversationProvider._internal(
        (ref) => create(ref as GetOrCreateConversationRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        requestId: requestId,
        otherUserId: otherUserId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Conversation> createElement() {
    return _GetOrCreateConversationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetOrCreateConversationProvider &&
        other.requestId == requestId &&
        other.otherUserId == otherUserId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, requestId.hashCode);
    hash = _SystemHash.combine(hash, otherUserId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetOrCreateConversationRef on AutoDisposeFutureProviderRef<Conversation> {
  /// The parameter `requestId` of this provider.
  String get requestId;

  /// The parameter `otherUserId` of this provider.
  String get otherUserId;
}

class _GetOrCreateConversationProviderElement
    extends AutoDisposeFutureProviderElement<Conversation>
    with GetOrCreateConversationRef {
  _GetOrCreateConversationProviderElement(super.provider);

  @override
  String get requestId => (origin as GetOrCreateConversationProvider).requestId;
  @override
  String get otherUserId =>
      (origin as GetOrCreateConversationProvider).otherUserId;
}

String _$conversationsNotifierHash() =>
    r'6b17073a01c88699837a478262b8d9aeb27c6dde';

/// See also [ConversationsNotifier].
@ProviderFor(ConversationsNotifier)
final conversationsNotifierProvider = AutoDisposeAsyncNotifierProvider<
    ConversationsNotifier, List<Conversation>>.internal(
  ConversationsNotifier.new,
  name: r'conversationsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$conversationsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ConversationsNotifier = AutoDisposeAsyncNotifier<List<Conversation>>;
String _$messagesNotifierHash() => r'14d0160f80b10d728b299a0795b4a2e9918592f0';

abstract class _$MessagesNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<Message>> {
  late final String conversationId;

  FutureOr<List<Message>> build(
    String conversationId,
  );
}

/// See also [MessagesNotifier].
@ProviderFor(MessagesNotifier)
const messagesNotifierProvider = MessagesNotifierFamily();

/// See also [MessagesNotifier].
class MessagesNotifierFamily extends Family<AsyncValue<List<Message>>> {
  /// See also [MessagesNotifier].
  const MessagesNotifierFamily();

  /// See also [MessagesNotifier].
  MessagesNotifierProvider call(
    String conversationId,
  ) {
    return MessagesNotifierProvider(
      conversationId,
    );
  }

  @override
  MessagesNotifierProvider getProviderOverride(
    covariant MessagesNotifierProvider provider,
  ) {
    return call(
      provider.conversationId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'messagesNotifierProvider';
}

/// See also [MessagesNotifier].
class MessagesNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    MessagesNotifier, List<Message>> {
  /// See also [MessagesNotifier].
  MessagesNotifierProvider(
    String conversationId,
  ) : this._internal(
          () => MessagesNotifier()..conversationId = conversationId,
          from: messagesNotifierProvider,
          name: r'messagesNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$messagesNotifierHash,
          dependencies: MessagesNotifierFamily._dependencies,
          allTransitiveDependencies:
              MessagesNotifierFamily._allTransitiveDependencies,
          conversationId: conversationId,
        );

  MessagesNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.conversationId,
  }) : super.internal();

  final String conversationId;

  @override
  FutureOr<List<Message>> runNotifierBuild(
    covariant MessagesNotifier notifier,
  ) {
    return notifier.build(
      conversationId,
    );
  }

  @override
  Override overrideWith(MessagesNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: MessagesNotifierProvider._internal(
        () => create()..conversationId = conversationId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        conversationId: conversationId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<MessagesNotifier, List<Message>>
      createElement() {
    return _MessagesNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MessagesNotifierProvider &&
        other.conversationId == conversationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, conversationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MessagesNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<Message>> {
  /// The parameter `conversationId` of this provider.
  String get conversationId;
}

class _MessagesNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<MessagesNotifier,
        List<Message>> with MessagesNotifierRef {
  _MessagesNotifierProviderElement(super.provider);

  @override
  String get conversationId =>
      (origin as MessagesNotifierProvider).conversationId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
