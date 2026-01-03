// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$craftsmanReviewsHash() => r'377c3943a65ce9cb5cd5fc84c9365d27fd5ab2f0';

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

/// See also [craftsmanReviews].
@ProviderFor(craftsmanReviews)
const craftsmanReviewsProvider = CraftsmanReviewsFamily();

/// See also [craftsmanReviews].
class CraftsmanReviewsFamily extends Family<AsyncValue<List<Review>>> {
  /// See also [craftsmanReviews].
  const CraftsmanReviewsFamily();

  /// See also [craftsmanReviews].
  CraftsmanReviewsProvider call(
    String craftsmanId, {
    int? minScore,
  }) {
    return CraftsmanReviewsProvider(
      craftsmanId,
      minScore: minScore,
    );
  }

  @override
  CraftsmanReviewsProvider getProviderOverride(
    covariant CraftsmanReviewsProvider provider,
  ) {
    return call(
      provider.craftsmanId,
      minScore: provider.minScore,
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
  String? get name => r'craftsmanReviewsProvider';
}

/// See also [craftsmanReviews].
class CraftsmanReviewsProvider extends AutoDisposeFutureProvider<List<Review>> {
  /// See also [craftsmanReviews].
  CraftsmanReviewsProvider(
    String craftsmanId, {
    int? minScore,
  }) : this._internal(
          (ref) => craftsmanReviews(
            ref as CraftsmanReviewsRef,
            craftsmanId,
            minScore: minScore,
          ),
          from: craftsmanReviewsProvider,
          name: r'craftsmanReviewsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$craftsmanReviewsHash,
          dependencies: CraftsmanReviewsFamily._dependencies,
          allTransitiveDependencies:
              CraftsmanReviewsFamily._allTransitiveDependencies,
          craftsmanId: craftsmanId,
          minScore: minScore,
        );

  CraftsmanReviewsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.craftsmanId,
    required this.minScore,
  }) : super.internal();

  final String craftsmanId;
  final int? minScore;

  @override
  Override overrideWith(
    FutureOr<List<Review>> Function(CraftsmanReviewsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CraftsmanReviewsProvider._internal(
        (ref) => create(ref as CraftsmanReviewsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        craftsmanId: craftsmanId,
        minScore: minScore,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Review>> createElement() {
    return _CraftsmanReviewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CraftsmanReviewsProvider &&
        other.craftsmanId == craftsmanId &&
        other.minScore == minScore;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, craftsmanId.hashCode);
    hash = _SystemHash.combine(hash, minScore.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CraftsmanReviewsRef on AutoDisposeFutureProviderRef<List<Review>> {
  /// The parameter `craftsmanId` of this provider.
  String get craftsmanId;

  /// The parameter `minScore` of this provider.
  int? get minScore;
}

class _CraftsmanReviewsProviderElement
    extends AutoDisposeFutureProviderElement<List<Review>>
    with CraftsmanReviewsRef {
  _CraftsmanReviewsProviderElement(super.provider);

  @override
  String get craftsmanId => (origin as CraftsmanReviewsProvider).craftsmanId;
  @override
  int? get minScore => (origin as CraftsmanReviewsProvider).minScore;
}

String _$craftsmanReviewsSummaryHash() =>
    r'30db8be4fae301adcbdad4e6e18c7baf380a00f2';

/// See also [craftsmanReviewsSummary].
@ProviderFor(craftsmanReviewsSummary)
const craftsmanReviewsSummaryProvider = CraftsmanReviewsSummaryFamily();

/// See also [craftsmanReviewsSummary].
class CraftsmanReviewsSummaryFamily extends Family<AsyncValue<ReviewsSummary>> {
  /// See also [craftsmanReviewsSummary].
  const CraftsmanReviewsSummaryFamily();

  /// See also [craftsmanReviewsSummary].
  CraftsmanReviewsSummaryProvider call(
    String craftsmanId,
  ) {
    return CraftsmanReviewsSummaryProvider(
      craftsmanId,
    );
  }

  @override
  CraftsmanReviewsSummaryProvider getProviderOverride(
    covariant CraftsmanReviewsSummaryProvider provider,
  ) {
    return call(
      provider.craftsmanId,
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
  String? get name => r'craftsmanReviewsSummaryProvider';
}

/// See also [craftsmanReviewsSummary].
class CraftsmanReviewsSummaryProvider
    extends AutoDisposeFutureProvider<ReviewsSummary> {
  /// See also [craftsmanReviewsSummary].
  CraftsmanReviewsSummaryProvider(
    String craftsmanId,
  ) : this._internal(
          (ref) => craftsmanReviewsSummary(
            ref as CraftsmanReviewsSummaryRef,
            craftsmanId,
          ),
          from: craftsmanReviewsSummaryProvider,
          name: r'craftsmanReviewsSummaryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$craftsmanReviewsSummaryHash,
          dependencies: CraftsmanReviewsSummaryFamily._dependencies,
          allTransitiveDependencies:
              CraftsmanReviewsSummaryFamily._allTransitiveDependencies,
          craftsmanId: craftsmanId,
        );

  CraftsmanReviewsSummaryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.craftsmanId,
  }) : super.internal();

  final String craftsmanId;

  @override
  Override overrideWith(
    FutureOr<ReviewsSummary> Function(CraftsmanReviewsSummaryRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CraftsmanReviewsSummaryProvider._internal(
        (ref) => create(ref as CraftsmanReviewsSummaryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        craftsmanId: craftsmanId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ReviewsSummary> createElement() {
    return _CraftsmanReviewsSummaryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CraftsmanReviewsSummaryProvider &&
        other.craftsmanId == craftsmanId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, craftsmanId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CraftsmanReviewsSummaryRef
    on AutoDisposeFutureProviderRef<ReviewsSummary> {
  /// The parameter `craftsmanId` of this provider.
  String get craftsmanId;
}

class _CraftsmanReviewsSummaryProviderElement
    extends AutoDisposeFutureProviderElement<ReviewsSummary>
    with CraftsmanReviewsSummaryRef {
  _CraftsmanReviewsSummaryProviderElement(super.provider);

  @override
  String get craftsmanId =>
      (origin as CraftsmanReviewsSummaryProvider).craftsmanId;
}

String _$reviewDetailHash() => r'f08128ffb99677a05990b0899884a3ecb246b3e0';

/// See also [reviewDetail].
@ProviderFor(reviewDetail)
const reviewDetailProvider = ReviewDetailFamily();

/// See also [reviewDetail].
class ReviewDetailFamily extends Family<AsyncValue<Review>> {
  /// See also [reviewDetail].
  const ReviewDetailFamily();

  /// See also [reviewDetail].
  ReviewDetailProvider call(
    String reviewId,
  ) {
    return ReviewDetailProvider(
      reviewId,
    );
  }

  @override
  ReviewDetailProvider getProviderOverride(
    covariant ReviewDetailProvider provider,
  ) {
    return call(
      provider.reviewId,
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
  String? get name => r'reviewDetailProvider';
}

/// See also [reviewDetail].
class ReviewDetailProvider extends AutoDisposeFutureProvider<Review> {
  /// See also [reviewDetail].
  ReviewDetailProvider(
    String reviewId,
  ) : this._internal(
          (ref) => reviewDetail(
            ref as ReviewDetailRef,
            reviewId,
          ),
          from: reviewDetailProvider,
          name: r'reviewDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$reviewDetailHash,
          dependencies: ReviewDetailFamily._dependencies,
          allTransitiveDependencies:
              ReviewDetailFamily._allTransitiveDependencies,
          reviewId: reviewId,
        );

  ReviewDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.reviewId,
  }) : super.internal();

  final String reviewId;

  @override
  Override overrideWith(
    FutureOr<Review> Function(ReviewDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReviewDetailProvider._internal(
        (ref) => create(ref as ReviewDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        reviewId: reviewId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Review> createElement() {
    return _ReviewDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReviewDetailProvider && other.reviewId == reviewId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, reviewId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ReviewDetailRef on AutoDisposeFutureProviderRef<Review> {
  /// The parameter `reviewId` of this provider.
  String get reviewId;
}

class _ReviewDetailProviderElement
    extends AutoDisposeFutureProviderElement<Review> with ReviewDetailRef {
  _ReviewDetailProviderElement(super.provider);

  @override
  String get reviewId => (origin as ReviewDetailProvider).reviewId;
}

String _$myReviewsNotifierHash() => r'4c7e7b5dd732409d943592468ac650ed5f567084';

/// See also [MyReviewsNotifier].
@ProviderFor(MyReviewsNotifier)
final myReviewsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<MyReviewsNotifier, List<Review>>.internal(
  MyReviewsNotifier.new,
  name: r'myReviewsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myReviewsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MyReviewsNotifier = AutoDisposeAsyncNotifier<List<Review>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
