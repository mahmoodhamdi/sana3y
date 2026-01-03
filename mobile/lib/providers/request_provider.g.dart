// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$requestDetailHash() => r'c96be94ae814e7316039f1247ce1f22751e99efb';

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

/// See also [requestDetail].
@ProviderFor(requestDetail)
const requestDetailProvider = RequestDetailFamily();

/// See also [requestDetail].
class RequestDetailFamily extends Family<AsyncValue<ServiceRequest>> {
  /// See also [requestDetail].
  const RequestDetailFamily();

  /// See also [requestDetail].
  RequestDetailProvider call(
    String id,
  ) {
    return RequestDetailProvider(
      id,
    );
  }

  @override
  RequestDetailProvider getProviderOverride(
    covariant RequestDetailProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'requestDetailProvider';
}

/// See also [requestDetail].
class RequestDetailProvider extends AutoDisposeFutureProvider<ServiceRequest> {
  /// See also [requestDetail].
  RequestDetailProvider(
    String id,
  ) : this._internal(
          (ref) => requestDetail(
            ref as RequestDetailRef,
            id,
          ),
          from: requestDetailProvider,
          name: r'requestDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$requestDetailHash,
          dependencies: RequestDetailFamily._dependencies,
          allTransitiveDependencies:
              RequestDetailFamily._allTransitiveDependencies,
          id: id,
        );

  RequestDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<ServiceRequest> Function(RequestDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RequestDetailProvider._internal(
        (ref) => create(ref as RequestDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ServiceRequest> createElement() {
    return _RequestDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RequestDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RequestDetailRef on AutoDisposeFutureProviderRef<ServiceRequest> {
  /// The parameter `id` of this provider.
  String get id;
}

class _RequestDetailProviderElement
    extends AutoDisposeFutureProviderElement<ServiceRequest>
    with RequestDetailRef {
  _RequestDetailProviderElement(super.provider);

  @override
  String get id => (origin as RequestDetailProvider).id;
}

String _$activeCustomerRequestsHash() =>
    r'827de7dcb564687f204f274cb5e3de02cfeeda79';

/// See also [activeCustomerRequests].
@ProviderFor(activeCustomerRequests)
final activeCustomerRequestsProvider =
    AutoDisposeFutureProvider<List<ServiceRequest>>.internal(
  activeCustomerRequests,
  name: r'activeCustomerRequestsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeCustomerRequestsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveCustomerRequestsRef
    = AutoDisposeFutureProviderRef<List<ServiceRequest>>;
String _$completedCustomerRequestsHash() =>
    r'9260e4259e9fe8cb4cd8c816c1dbe675ee2c6b9b';

/// See also [completedCustomerRequests].
@ProviderFor(completedCustomerRequests)
final completedCustomerRequestsProvider =
    AutoDisposeFutureProvider<List<ServiceRequest>>.internal(
  completedCustomerRequests,
  name: r'completedCustomerRequestsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$completedCustomerRequestsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CompletedCustomerRequestsRef
    = AutoDisposeFutureProviderRef<List<ServiceRequest>>;
String _$craftsmanEarningsHash() => r'd23313bccf09178bc22823636cdae1402b170ad1';

/// See also [craftsmanEarnings].
@ProviderFor(craftsmanEarnings)
final craftsmanEarningsProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>>.internal(
  craftsmanEarnings,
  name: r'craftsmanEarningsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$craftsmanEarningsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CraftsmanEarningsRef
    = AutoDisposeFutureProviderRef<Map<String, dynamic>>;
String _$customerRequestsNotifierHash() =>
    r'e1c1ba696b9291b62276d563a524eca0af2fd54d';

/// See also [CustomerRequestsNotifier].
@ProviderFor(CustomerRequestsNotifier)
final customerRequestsNotifierProvider = AutoDisposeAsyncNotifierProvider<
    CustomerRequestsNotifier, List<ServiceRequest>>.internal(
  CustomerRequestsNotifier.new,
  name: r'customerRequestsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customerRequestsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CustomerRequestsNotifier
    = AutoDisposeAsyncNotifier<List<ServiceRequest>>;
String _$availableRequestsNotifierHash() =>
    r'264d50d4fd28a6a4dd75c1d176c4f1c9b7da62c5';

/// See also [AvailableRequestsNotifier].
@ProviderFor(AvailableRequestsNotifier)
final availableRequestsNotifierProvider = AutoDisposeAsyncNotifierProvider<
    AvailableRequestsNotifier, List<ServiceRequest>>.internal(
  AvailableRequestsNotifier.new,
  name: r'availableRequestsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$availableRequestsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AvailableRequestsNotifier
    = AutoDisposeAsyncNotifier<List<ServiceRequest>>;
String _$activeJobsNotifierHash() =>
    r'0afaf2da16f3ffb8cadaa769c16763a580f2fde6';

/// See also [ActiveJobsNotifier].
@ProviderFor(ActiveJobsNotifier)
final activeJobsNotifierProvider = AutoDisposeAsyncNotifierProvider<
    ActiveJobsNotifier, List<ServiceRequest>>.internal(
  ActiveJobsNotifier.new,
  name: r'activeJobsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeJobsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ActiveJobsNotifier = AutoDisposeAsyncNotifier<List<ServiceRequest>>;
String _$completedJobsNotifierHash() =>
    r'8b12d0a65c0f63701a5e5adf40f83a6011638766';

/// See also [CompletedJobsNotifier].
@ProviderFor(CompletedJobsNotifier)
final completedJobsNotifierProvider = AutoDisposeAsyncNotifierProvider<
    CompletedJobsNotifier, List<ServiceRequest>>.internal(
  CompletedJobsNotifier.new,
  name: r'completedJobsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$completedJobsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CompletedJobsNotifier
    = AutoDisposeAsyncNotifier<List<ServiceRequest>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
