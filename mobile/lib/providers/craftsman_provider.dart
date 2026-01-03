import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/craftsman.dart';
import '../services/craftsman_service.dart';
import 'category_provider.dart';

part 'craftsman_provider.g.dart';

// Craftsman service provider
final craftsmanServiceProvider = Provider<CraftsmanService>((ref) {
  final client = ref.watch(apiClientProvider);
  return CraftsmanService(client);
});

// Featured craftsmen provider
@riverpod
Future<List<Craftsman>> featuredCraftsmen(Ref ref) async {
  final service = ref.watch(craftsmanServiceProvider);
  return service.getFeaturedCraftsmen(limit: 10);
}

// Craftsmen by category provider
@riverpod
Future<List<Craftsman>> craftsmenByCategory(
  Ref ref,
  String categoryId, {
  int limit = 10,
}) async {
  final service = ref.watch(craftsmanServiceProvider);
  return service.getCraftsmenByCategory(categoryId, limit: limit);
}

// Nearby craftsmen provider
@riverpod
class NearbyCraftsmen extends _$NearbyCraftsmen {
  @override
  Future<List<Craftsman>> build({
    required double lat,
    required double lng,
    double radius = 10,
    String? categoryId,
  }) async {
    final service = ref.watch(craftsmanServiceProvider);
    return service.getNearbyCraftsmen(
      lat: lat,
      lng: lng,
      radius: radius,
      categoryId: categoryId,
    );
  }
}

// Craftsman by ID provider
@riverpod
Future<Craftsman?> craftsmanById(Ref ref, String id) async {
  final service = ref.watch(craftsmanServiceProvider);
  return service.getCraftsmanById(id);
}

// My craftsman profile (for craftsman users)
@riverpod
Future<Craftsman?> myCraftsmanProfile(Ref ref) async {
  final service = ref.watch(craftsmanServiceProvider);
  return service.getMyProfile();
}

// Craftsman list state with pagination
@riverpod
class CraftsmanList extends _$CraftsmanList {
  int _currentPage = 1;
  bool _hasMore = true;
  List<Craftsman> _craftsmen = [];
  String? _categoryId;
  String? _search;

  @override
  AsyncValue<List<Craftsman>> build() {
    return const AsyncValue.data([]);
  }

  Future<void> loadCraftsmen({
    String? categoryId,
    String? search,
    bool refresh = false,
  }) async {
    if (refresh) {
      _currentPage = 1;
      _craftsmen = [];
      _hasMore = true;
    }

    _categoryId = categoryId;
    _search = search;

    if (!_hasMore && !refresh) return;

    state = _craftsmen.isEmpty
        ? const AsyncValue.loading()
        : AsyncValue.data(_craftsmen);

    try {
      final service = ref.read(craftsmanServiceProvider);
      final response = await service.getApprovedCraftsmen(
        page: _currentPage,
        categoryId: _categoryId,
        search: _search,
      );

      if (response != null) {
        _craftsmen = refresh
            ? response.data
            : [..._craftsmen, ...response.data];
        _hasMore = _currentPage < response.totalPages;
        _currentPage++;
        state = AsyncValue.data(_craftsmen);
      } else {
        if (_craftsmen.isEmpty) {
          state = AsyncValue.error('Failed to load', StackTrace.current);
        }
      }
    } catch (e, st) {
      if (_craftsmen.isEmpty) {
        state = AsyncValue.error(e, st);
      }
    }
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;
    await loadCraftsmen(categoryId: _categoryId, search: _search);
  }

  void refresh() {
    loadCraftsmen(categoryId: _categoryId, search: _search, refresh: true);
  }

  bool get hasMore => _hasMore;
}
