import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/category.dart';
import '../services/category_service.dart';
import '../services/api_client.dart';

part 'category_provider.g.dart';

// API Client provider
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

// Category service provider
final categoryServiceProvider = Provider<CategoryService>((ref) {
  final client = ref.watch(apiClientProvider);
  return CategoryService(client);
});

// Active categories provider
@riverpod
Future<List<Category>> activeCategories(Ref ref) async {
  final service = ref.watch(categoryServiceProvider);
  return service.getActiveCategories();
}

// Popular categories provider
@riverpod
Future<List<Category>> popularCategories(Ref ref) async {
  final service = ref.watch(categoryServiceProvider);
  return service.getPopularCategories(limit: 6);
}

// Category by ID provider
@riverpod
Future<Category?> categoryById(Ref ref, String id) async {
  final service = ref.watch(categoryServiceProvider);
  return service.getCategoryById(id);
}

// Category by slug provider
@riverpod
Future<Category?> categoryBySlug(Ref ref, String slug) async {
  final service = ref.watch(categoryServiceProvider);
  return service.getCategoryBySlug(slug);
}

// Selected category state
@riverpod
class SelectedCategory extends _$SelectedCategory {
  @override
  Category? build() => null;

  void select(Category category) {
    state = category;
  }

  void clear() {
    state = null;
  }
}
