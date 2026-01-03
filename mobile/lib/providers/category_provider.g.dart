// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activeCategoriesHash() => r'23981c4d5c201917f07f9a2a5decbc827aeefc75';

/// See also [activeCategories].
@ProviderFor(activeCategories)
final activeCategoriesProvider =
    AutoDisposeFutureProvider<List<Category>>.internal(
  activeCategories,
  name: r'activeCategoriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeCategoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveCategoriesRef = AutoDisposeFutureProviderRef<List<Category>>;
String _$popularCategoriesHash() => r'c7a3ac5326e2e06c53387333efa021d398eaf834';

/// See also [popularCategories].
@ProviderFor(popularCategories)
final popularCategoriesProvider =
    AutoDisposeFutureProvider<List<Category>>.internal(
  popularCategories,
  name: r'popularCategoriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$popularCategoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PopularCategoriesRef = AutoDisposeFutureProviderRef<List<Category>>;
String _$categoryByIdHash() => r'c165baa2cf0372a13df7f953f06001fe5a295c5c';

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

/// See also [categoryById].
@ProviderFor(categoryById)
const categoryByIdProvider = CategoryByIdFamily();

/// See also [categoryById].
class CategoryByIdFamily extends Family<AsyncValue<Category?>> {
  /// See also [categoryById].
  const CategoryByIdFamily();

  /// See also [categoryById].
  CategoryByIdProvider call(
    String id,
  ) {
    return CategoryByIdProvider(
      id,
    );
  }

  @override
  CategoryByIdProvider getProviderOverride(
    covariant CategoryByIdProvider provider,
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
  String? get name => r'categoryByIdProvider';
}

/// See also [categoryById].
class CategoryByIdProvider extends AutoDisposeFutureProvider<Category?> {
  /// See also [categoryById].
  CategoryByIdProvider(
    String id,
  ) : this._internal(
          (ref) => categoryById(
            ref as CategoryByIdRef,
            id,
          ),
          from: categoryByIdProvider,
          name: r'categoryByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$categoryByIdHash,
          dependencies: CategoryByIdFamily._dependencies,
          allTransitiveDependencies:
              CategoryByIdFamily._allTransitiveDependencies,
          id: id,
        );

  CategoryByIdProvider._internal(
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
    FutureOr<Category?> Function(CategoryByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CategoryByIdProvider._internal(
        (ref) => create(ref as CategoryByIdRef),
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
  AutoDisposeFutureProviderElement<Category?> createElement() {
    return _CategoryByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryByIdProvider && other.id == id;
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
mixin CategoryByIdRef on AutoDisposeFutureProviderRef<Category?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _CategoryByIdProviderElement
    extends AutoDisposeFutureProviderElement<Category?> with CategoryByIdRef {
  _CategoryByIdProviderElement(super.provider);

  @override
  String get id => (origin as CategoryByIdProvider).id;
}

String _$categoryBySlugHash() => r'21f0e0f50baa6bf6cbd2d6df49efc0a297d0d266';

/// See also [categoryBySlug].
@ProviderFor(categoryBySlug)
const categoryBySlugProvider = CategoryBySlugFamily();

/// See also [categoryBySlug].
class CategoryBySlugFamily extends Family<AsyncValue<Category?>> {
  /// See also [categoryBySlug].
  const CategoryBySlugFamily();

  /// See also [categoryBySlug].
  CategoryBySlugProvider call(
    String slug,
  ) {
    return CategoryBySlugProvider(
      slug,
    );
  }

  @override
  CategoryBySlugProvider getProviderOverride(
    covariant CategoryBySlugProvider provider,
  ) {
    return call(
      provider.slug,
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
  String? get name => r'categoryBySlugProvider';
}

/// See also [categoryBySlug].
class CategoryBySlugProvider extends AutoDisposeFutureProvider<Category?> {
  /// See also [categoryBySlug].
  CategoryBySlugProvider(
    String slug,
  ) : this._internal(
          (ref) => categoryBySlug(
            ref as CategoryBySlugRef,
            slug,
          ),
          from: categoryBySlugProvider,
          name: r'categoryBySlugProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$categoryBySlugHash,
          dependencies: CategoryBySlugFamily._dependencies,
          allTransitiveDependencies:
              CategoryBySlugFamily._allTransitiveDependencies,
          slug: slug,
        );

  CategoryBySlugProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.slug,
  }) : super.internal();

  final String slug;

  @override
  Override overrideWith(
    FutureOr<Category?> Function(CategoryBySlugRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CategoryBySlugProvider._internal(
        (ref) => create(ref as CategoryBySlugRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        slug: slug,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Category?> createElement() {
    return _CategoryBySlugProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryBySlugProvider && other.slug == slug;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, slug.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CategoryBySlugRef on AutoDisposeFutureProviderRef<Category?> {
  /// The parameter `slug` of this provider.
  String get slug;
}

class _CategoryBySlugProviderElement
    extends AutoDisposeFutureProviderElement<Category?> with CategoryBySlugRef {
  _CategoryBySlugProviderElement(super.provider);

  @override
  String get slug => (origin as CategoryBySlugProvider).slug;
}

String _$selectedCategoryHash() => r'717061c6ca34363491a51b27c437ea7ca38bc538';

/// See also [SelectedCategory].
@ProviderFor(SelectedCategory)
final selectedCategoryProvider =
    AutoDisposeNotifierProvider<SelectedCategory, Category?>.internal(
  SelectedCategory.new,
  name: r'selectedCategoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedCategoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedCategory = AutoDisposeNotifier<Category?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
