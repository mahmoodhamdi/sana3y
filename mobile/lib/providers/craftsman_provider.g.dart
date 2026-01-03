// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'craftsman_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$featuredCraftsmenHash() => r'f9211c6714800353179418aa6e595948ad2db88e';

/// See also [featuredCraftsmen].
@ProviderFor(featuredCraftsmen)
final featuredCraftsmenProvider =
    AutoDisposeFutureProvider<List<Craftsman>>.internal(
  featuredCraftsmen,
  name: r'featuredCraftsmenProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$featuredCraftsmenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FeaturedCraftsmenRef = AutoDisposeFutureProviderRef<List<Craftsman>>;
String _$craftsmenByCategoryHash() =>
    r'66e8e570f701ca3695a358f6af0d5f27d3359979';

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

/// See also [craftsmenByCategory].
@ProviderFor(craftsmenByCategory)
const craftsmenByCategoryProvider = CraftsmenByCategoryFamily();

/// See also [craftsmenByCategory].
class CraftsmenByCategoryFamily extends Family<AsyncValue<List<Craftsman>>> {
  /// See also [craftsmenByCategory].
  const CraftsmenByCategoryFamily();

  /// See also [craftsmenByCategory].
  CraftsmenByCategoryProvider call(
    String categoryId, {
    int limit = 10,
  }) {
    return CraftsmenByCategoryProvider(
      categoryId,
      limit: limit,
    );
  }

  @override
  CraftsmenByCategoryProvider getProviderOverride(
    covariant CraftsmenByCategoryProvider provider,
  ) {
    return call(
      provider.categoryId,
      limit: provider.limit,
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
  String? get name => r'craftsmenByCategoryProvider';
}

/// See also [craftsmenByCategory].
class CraftsmenByCategoryProvider
    extends AutoDisposeFutureProvider<List<Craftsman>> {
  /// See also [craftsmenByCategory].
  CraftsmenByCategoryProvider(
    String categoryId, {
    int limit = 10,
  }) : this._internal(
          (ref) => craftsmenByCategory(
            ref as CraftsmenByCategoryRef,
            categoryId,
            limit: limit,
          ),
          from: craftsmenByCategoryProvider,
          name: r'craftsmenByCategoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$craftsmenByCategoryHash,
          dependencies: CraftsmenByCategoryFamily._dependencies,
          allTransitiveDependencies:
              CraftsmenByCategoryFamily._allTransitiveDependencies,
          categoryId: categoryId,
          limit: limit,
        );

  CraftsmenByCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
    required this.limit,
  }) : super.internal();

  final String categoryId;
  final int limit;

  @override
  Override overrideWith(
    FutureOr<List<Craftsman>> Function(CraftsmenByCategoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CraftsmenByCategoryProvider._internal(
        (ref) => create(ref as CraftsmenByCategoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Craftsman>> createElement() {
    return _CraftsmenByCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CraftsmenByCategoryProvider &&
        other.categoryId == categoryId &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CraftsmenByCategoryRef on AutoDisposeFutureProviderRef<List<Craftsman>> {
  /// The parameter `categoryId` of this provider.
  String get categoryId;

  /// The parameter `limit` of this provider.
  int get limit;
}

class _CraftsmenByCategoryProviderElement
    extends AutoDisposeFutureProviderElement<List<Craftsman>>
    with CraftsmenByCategoryRef {
  _CraftsmenByCategoryProviderElement(super.provider);

  @override
  String get categoryId => (origin as CraftsmenByCategoryProvider).categoryId;
  @override
  int get limit => (origin as CraftsmenByCategoryProvider).limit;
}

String _$craftsmanByIdHash() => r'0f85d771e730f3dde3cd2370895ab2d14a7888a4';

/// See also [craftsmanById].
@ProviderFor(craftsmanById)
const craftsmanByIdProvider = CraftsmanByIdFamily();

/// See also [craftsmanById].
class CraftsmanByIdFamily extends Family<AsyncValue<Craftsman?>> {
  /// See also [craftsmanById].
  const CraftsmanByIdFamily();

  /// See also [craftsmanById].
  CraftsmanByIdProvider call(
    String id,
  ) {
    return CraftsmanByIdProvider(
      id,
    );
  }

  @override
  CraftsmanByIdProvider getProviderOverride(
    covariant CraftsmanByIdProvider provider,
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
  String? get name => r'craftsmanByIdProvider';
}

/// See also [craftsmanById].
class CraftsmanByIdProvider extends AutoDisposeFutureProvider<Craftsman?> {
  /// See also [craftsmanById].
  CraftsmanByIdProvider(
    String id,
  ) : this._internal(
          (ref) => craftsmanById(
            ref as CraftsmanByIdRef,
            id,
          ),
          from: craftsmanByIdProvider,
          name: r'craftsmanByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$craftsmanByIdHash,
          dependencies: CraftsmanByIdFamily._dependencies,
          allTransitiveDependencies:
              CraftsmanByIdFamily._allTransitiveDependencies,
          id: id,
        );

  CraftsmanByIdProvider._internal(
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
    FutureOr<Craftsman?> Function(CraftsmanByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CraftsmanByIdProvider._internal(
        (ref) => create(ref as CraftsmanByIdRef),
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
  AutoDisposeFutureProviderElement<Craftsman?> createElement() {
    return _CraftsmanByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CraftsmanByIdProvider && other.id == id;
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
mixin CraftsmanByIdRef on AutoDisposeFutureProviderRef<Craftsman?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _CraftsmanByIdProviderElement
    extends AutoDisposeFutureProviderElement<Craftsman?> with CraftsmanByIdRef {
  _CraftsmanByIdProviderElement(super.provider);

  @override
  String get id => (origin as CraftsmanByIdProvider).id;
}

String _$myCraftsmanProfileHash() =>
    r'c6d62518b26981bdc318a75589a207e0353c6278';

/// See also [myCraftsmanProfile].
@ProviderFor(myCraftsmanProfile)
final myCraftsmanProfileProvider =
    AutoDisposeFutureProvider<Craftsman?>.internal(
  myCraftsmanProfile,
  name: r'myCraftsmanProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myCraftsmanProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyCraftsmanProfileRef = AutoDisposeFutureProviderRef<Craftsman?>;
String _$nearbyCraftsmenHash() => r'b5a05ba928a87fa56d933a0ccfdfed277ab9bf87';

abstract class _$NearbyCraftsmen
    extends BuildlessAutoDisposeAsyncNotifier<List<Craftsman>> {
  late final double lat;
  late final double lng;
  late final double radius;
  late final String? categoryId;

  FutureOr<List<Craftsman>> build({
    required double lat,
    required double lng,
    double radius = 10,
    String? categoryId,
  });
}

/// See also [NearbyCraftsmen].
@ProviderFor(NearbyCraftsmen)
const nearbyCraftsmenProvider = NearbyCraftsmenFamily();

/// See also [NearbyCraftsmen].
class NearbyCraftsmenFamily extends Family<AsyncValue<List<Craftsman>>> {
  /// See also [NearbyCraftsmen].
  const NearbyCraftsmenFamily();

  /// See also [NearbyCraftsmen].
  NearbyCraftsmenProvider call({
    required double lat,
    required double lng,
    double radius = 10,
    String? categoryId,
  }) {
    return NearbyCraftsmenProvider(
      lat: lat,
      lng: lng,
      radius: radius,
      categoryId: categoryId,
    );
  }

  @override
  NearbyCraftsmenProvider getProviderOverride(
    covariant NearbyCraftsmenProvider provider,
  ) {
    return call(
      lat: provider.lat,
      lng: provider.lng,
      radius: provider.radius,
      categoryId: provider.categoryId,
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
  String? get name => r'nearbyCraftsmenProvider';
}

/// See also [NearbyCraftsmen].
class NearbyCraftsmenProvider extends AutoDisposeAsyncNotifierProviderImpl<
    NearbyCraftsmen, List<Craftsman>> {
  /// See also [NearbyCraftsmen].
  NearbyCraftsmenProvider({
    required double lat,
    required double lng,
    double radius = 10,
    String? categoryId,
  }) : this._internal(
          () => NearbyCraftsmen()
            ..lat = lat
            ..lng = lng
            ..radius = radius
            ..categoryId = categoryId,
          from: nearbyCraftsmenProvider,
          name: r'nearbyCraftsmenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$nearbyCraftsmenHash,
          dependencies: NearbyCraftsmenFamily._dependencies,
          allTransitiveDependencies:
              NearbyCraftsmenFamily._allTransitiveDependencies,
          lat: lat,
          lng: lng,
          radius: radius,
          categoryId: categoryId,
        );

  NearbyCraftsmenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lat,
    required this.lng,
    required this.radius,
    required this.categoryId,
  }) : super.internal();

  final double lat;
  final double lng;
  final double radius;
  final String? categoryId;

  @override
  FutureOr<List<Craftsman>> runNotifierBuild(
    covariant NearbyCraftsmen notifier,
  ) {
    return notifier.build(
      lat: lat,
      lng: lng,
      radius: radius,
      categoryId: categoryId,
    );
  }

  @override
  Override overrideWith(NearbyCraftsmen Function() create) {
    return ProviderOverride(
      origin: this,
      override: NearbyCraftsmenProvider._internal(
        () => create()
          ..lat = lat
          ..lng = lng
          ..radius = radius
          ..categoryId = categoryId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lat: lat,
        lng: lng,
        radius: radius,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<NearbyCraftsmen, List<Craftsman>>
      createElement() {
    return _NearbyCraftsmenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NearbyCraftsmenProvider &&
        other.lat == lat &&
        other.lng == lng &&
        other.radius == radius &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lat.hashCode);
    hash = _SystemHash.combine(hash, lng.hashCode);
    hash = _SystemHash.combine(hash, radius.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NearbyCraftsmenRef
    on AutoDisposeAsyncNotifierProviderRef<List<Craftsman>> {
  /// The parameter `lat` of this provider.
  double get lat;

  /// The parameter `lng` of this provider.
  double get lng;

  /// The parameter `radius` of this provider.
  double get radius;

  /// The parameter `categoryId` of this provider.
  String? get categoryId;
}

class _NearbyCraftsmenProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<NearbyCraftsmen,
        List<Craftsman>> with NearbyCraftsmenRef {
  _NearbyCraftsmenProviderElement(super.provider);

  @override
  double get lat => (origin as NearbyCraftsmenProvider).lat;
  @override
  double get lng => (origin as NearbyCraftsmenProvider).lng;
  @override
  double get radius => (origin as NearbyCraftsmenProvider).radius;
  @override
  String? get categoryId => (origin as NearbyCraftsmenProvider).categoryId;
}

String _$craftsmanListHash() => r'904c964a78fe745d47e692a15c0ac63b250fc514';

/// See also [CraftsmanList].
@ProviderFor(CraftsmanList)
final craftsmanListProvider = AutoDisposeNotifierProvider<CraftsmanList,
    AsyncValue<List<Craftsman>>>.internal(
  CraftsmanList.new,
  name: r'craftsmanListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$craftsmanListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CraftsmanList = AutoDisposeNotifier<AsyncValue<List<Craftsman>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
