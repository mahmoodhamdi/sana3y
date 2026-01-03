import '../config/constants.dart';
import '../models/category.dart';
import 'api_client.dart';

class CategoryService {
  final ApiClient _client;

  CategoryService(this._client);

  /// Get all active categories
  Future<List<Category>> getActiveCategories() async {
    try {
      final response = await _client.get(
        '${ApiEndpoints.categories}/active',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'] as List?;
        if (data != null) {
          return data
              .map((json) => Category.fromJson(json as Map<String, dynamic>))
              .toList();
        }
      }
    } catch (e) {
      // Handle error
    }

    return [];
  }

  /// Get popular categories
  Future<List<Category>> getPopularCategories({int limit = 6}) async {
    try {
      final response = await _client.get(
        '${ApiEndpoints.categories}/popular',
        queryParameters: {'limit': limit},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'] as List?;
        if (data != null) {
          return data
              .map((json) => Category.fromJson(json as Map<String, dynamic>))
              .toList();
        }
      }
    } catch (e) {
      // Handle error
    }

    return [];
  }

  /// Get category by ID
  Future<Category?> getCategoryById(String id) async {
    try {
      final response = await _client.get(
        '${ApiEndpoints.categories}/$id',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        if (data != null) {
          return Category.fromJson(data as Map<String, dynamic>);
        }
      }
    } catch (e) {
      // Handle error
    }

    return null;
  }

  /// Get category by slug
  Future<Category?> getCategoryBySlug(String slug) async {
    try {
      final response = await _client.get(
        '${ApiEndpoints.categories}/slug/$slug',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        if (data != null) {
          return Category.fromJson(data as Map<String, dynamic>);
        }
      }
    } catch (e) {
      // Handle error
    }

    return null;
  }
}
