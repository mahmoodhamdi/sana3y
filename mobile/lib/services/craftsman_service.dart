import '../config/constants.dart';
import '../models/craftsman.dart';
import 'api_client.dart';

class CraftsmanService {
  final ApiClient _client;

  CraftsmanService(this._client);

  /// Get approved craftsmen (public listing)
  Future<CraftsmanListResponse?> getApprovedCraftsmen({
    int page = 1,
    int limit = 20,
    String? categoryId,
    String? subcategory,
    double? minRating,
    String? search,
    String sort = 'rating',
    String order = 'desc',
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        'sort': sort,
        'order': order,
      };

      if (categoryId != null) queryParams['categoryId'] = categoryId;
      if (subcategory != null) queryParams['subcategory'] = subcategory;
      if (minRating != null) queryParams['minRating'] = minRating;
      if (search != null) queryParams['search'] = search;

      final response = await _client.get(
        '${ApiEndpoints.craftsmen}/public',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return CraftsmanListResponse(
          data: (response.data['data'] as List)
              .map((json) => Craftsman.fromJson(json as Map<String, dynamic>))
              .toList(),
          page: response.data['meta']['page'] ?? page,
          limit: response.data['meta']['limit'] ?? limit,
          total: response.data['meta']['total'] ?? 0,
          totalPages: response.data['meta']['totalPages'] ?? 1,
        );
      }
    } catch (e) {
      // Handle error
    }

    return null;
  }

  /// Get craftsmen by category
  Future<List<Craftsman>> getCraftsmenByCategory(
    String categoryId, {
    int limit = 10,
  }) async {
    try {
      final response = await _client.get(
        '${ApiEndpoints.craftsmen}/category/$categoryId',
        queryParameters: {'limit': limit},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'] as List?;
        if (data != null) {
          return data
              .map((json) => Craftsman.fromJson(json as Map<String, dynamic>))
              .toList();
        }
      }
    } catch (e) {
      // Handle error
    }

    return [];
  }

  /// Get nearby craftsmen
  Future<List<Craftsman>> getNearbyCraftsmen({
    required double lat,
    required double lng,
    double radius = 10,
    String? categoryId,
    int limit = 20,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'lat': lat,
        'lng': lng,
        'radius': radius,
        'limit': limit,
      };

      if (categoryId != null) queryParams['categoryId'] = categoryId;

      final response = await _client.get(
        ApiEndpoints.nearbyCraftsmen,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'] as List?;
        if (data != null) {
          return data
              .map((json) => Craftsman.fromJson(json as Map<String, dynamic>))
              .toList();
        }
      }
    } catch (e) {
      // Handle error
    }

    return [];
  }

  /// Get featured craftsmen
  Future<List<Craftsman>> getFeaturedCraftsmen({int limit = 10}) async {
    try {
      final response = await _client.get(
        '${ApiEndpoints.craftsmen}/featured',
        queryParameters: {'limit': limit},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'] as List?;
        if (data != null) {
          return data
              .map((json) => Craftsman.fromJson(json as Map<String, dynamic>))
              .toList();
        }
      }
    } catch (e) {
      // Handle error
    }

    return [];
  }

  /// Get craftsman by ID
  Future<Craftsman?> getCraftsmanById(String id) async {
    try {
      final response = await _client.get(
        '${ApiEndpoints.craftsmen}/$id',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        if (data != null) {
          return Craftsman.fromJson(data as Map<String, dynamic>);
        }
      }
    } catch (e) {
      // Handle error
    }

    return null;
  }

  /// Get my craftsman profile (for craftsman users)
  Future<Craftsman?> getMyProfile() async {
    try {
      final response = await _client.get(
        '${ApiEndpoints.craftsmen}/me',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        if (data != null) {
          return Craftsman.fromJson(data as Map<String, dynamic>);
        }
      }
    } catch (e) {
      // Handle error
    }

    return null;
  }

  /// Create craftsman profile
  Future<Craftsman?> createProfile(Map<String, dynamic> profileData) async {
    try {
      final response = await _client.post(
        '${ApiEndpoints.craftsmen}/profile',
        data: profileData,
      );

      if (response.statusCode == 201 && response.data['success'] == true) {
        final data = response.data['data'];
        if (data != null) {
          return Craftsman.fromJson(data as Map<String, dynamic>);
        }
      }
    } catch (e) {
      // Handle error
    }

    return null;
  }

  /// Update craftsman profile
  Future<Craftsman?> updateProfile(Map<String, dynamic> updates) async {
    try {
      final response = await _client.put(
        '${ApiEndpoints.craftsmen}/profile',
        data: updates,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        if (data != null) {
          return Craftsman.fromJson(data as Map<String, dynamic>);
        }
      }
    } catch (e) {
      // Handle error
    }

    return null;
  }

  /// Toggle online status
  Future<Craftsman?> toggleOnlineStatus(bool isOnline) async {
    try {
      final response = await _client.put(
        '${ApiEndpoints.craftsmen}/online',
        data: {'isOnline': isOnline},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        if (data != null) {
          return Craftsman.fromJson(data as Map<String, dynamic>);
        }
      }
    } catch (e) {
      // Handle error
    }

    return null;
  }

  /// Toggle availability
  Future<Craftsman?> toggleAvailability(bool isAvailable) async {
    try {
      final response = await _client.put(
        '${ApiEndpoints.craftsmen}/availability',
        data: {'isAvailable': isAvailable},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        if (data != null) {
          return Craftsman.fromJson(data as Map<String, dynamic>);
        }
      }
    } catch (e) {
      // Handle error
    }

    return null;
  }

  /// Get earnings summary from API
  Future<Map<String, dynamic>?> getEarnings() async {
    try {
      final response = await _client.get(
        '${ApiEndpoints.craftsmen}/earnings',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return response.data['data'] as Map<String, dynamic>;
      }
    } catch (e) {
      // Handle error
    }
    return null;
  }

  /// Request a payout/withdrawal
  Future<Map<String, dynamic>?> requestPayout(double amount) async {
    try {
      final response = await _client.post(
        '${ApiEndpoints.craftsmen}/payout',
        data: {'amount': amount},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return response.data['data'] as Map<String, dynamic>;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  /// Get payout history
  Future<List<dynamic>?> getPayoutHistory({int page = 1, int limit = 20}) async {
    try {
      final response = await _client.get(
        '${ApiEndpoints.craftsmen}/payout/history',
        queryParameters: {'page': page, 'limit': limit},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return response.data['data'] as List<dynamic>;
      }
    } catch (e) {
      // Handle error
    }
    return null;
  }
}
