import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/request.dart';
import '../providers/auth_provider.dart';
import 'api_client.dart';

part 'request_service.g.dart';

@riverpod
RequestService requestService(RequestServiceRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return RequestService(apiClient);
}

class RequestService {
  final ApiClient _apiClient;

  RequestService(this._apiClient);

  // Create a new service request
  Future<ServiceRequest> createRequest(CreateRequestData data) async {
    final response = await _apiClient.post(
      '/requests',
      data: {
        'title': data.title,
        'description': data.description,
        'category': data.category,
        'subcategory': data.subcategory,
        'location': {
          'address': data.location.address,
          'coordinates': data.location.coordinates,
          'governorate': data.location.governorate,
          'city': data.location.city,
          'area': data.location.area,
        },
        'preferredDate': data.preferredDate?.toIso8601String(),
        'preferredTime': data.preferredTime != null
            ? {
                'start': data.preferredTime!.start,
                'end': data.preferredTime!.end,
              }
            : null,
        'images': data.images,
        'budget': data.budget != null
            ? {
                'min': data.budget!.min,
                'max': data.budget!.max,
              }
            : null,
        'urgency': data.urgency.name,
      },
    );

    return ServiceRequest.fromJson(response.data['data']);
  }

  // Get customer's requests
  Future<RequestListResponse> getMyRequests({
    RequestStatus? status,
    int page = 1,
    int limit = 20,
  }) async {
    final params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };

    if (status != null) {
      params['status'] = status.name;
    }

    final response = await _apiClient.get('/requests/my', queryParameters: params);

    return RequestListResponse(
      data: (response.data['data'] as List)
          .map((e) => ServiceRequest.fromJson(e))
          .toList(),
      page: response.data['pagination']['page'],
      totalPages: response.data['pagination']['totalPages'],
      total: response.data['pagination']['total'],
      limit: response.data['pagination']['limit'],
    );
  }

  // Get single request by ID
  Future<ServiceRequest> getRequestById(String id) async {
    final response = await _apiClient.get('/requests/$id');
    return ServiceRequest.fromJson(response.data['data']);
  }

  // Update request
  Future<ServiceRequest> updateRequest(
    String id, {
    String? title,
    String? description,
    DateTime? preferredDate,
    PreferredTime? preferredTime,
    List<String>? images,
    RequestBudget? budget,
    RequestUrgency? urgency,
  }) async {
    final data = <String, dynamic>{};

    if (title != null) data['title'] = title;
    if (description != null) data['description'] = description;
    if (preferredDate != null) {
      data['preferredDate'] = preferredDate.toIso8601String();
    }
    if (preferredTime != null) {
      data['preferredTime'] = {
        'start': preferredTime.start,
        'end': preferredTime.end,
      };
    }
    if (images != null) data['images'] = images;
    if (budget != null) {
      data['budget'] = {
        'min': budget.min,
        'max': budget.max,
      };
    }
    if (urgency != null) data['urgency'] = urgency.name;

    final response = await _apiClient.put('/requests/$id', data: data);
    return ServiceRequest.fromJson(response.data['data']);
  }

  // Cancel request
  Future<ServiceRequest> cancelRequest(String id, {String? reason}) async {
    final response = await _apiClient.post(
      '/requests/$id/cancel',
      data: reason != null ? {'reason': reason} : null,
    );
    return ServiceRequest.fromJson(response.data['data']);
  }

  // Accept a quote
  Future<ServiceRequest> acceptQuote(String requestId, String quoteId) async {
    final response = await _apiClient.post(
      '/requests/$requestId/quotes/$quoteId/accept',
    );
    return ServiceRequest.fromJson(response.data['data']);
  }

  // Reject a quote
  Future<ServiceRequest> rejectQuote(String requestId, String quoteId) async {
    final response = await _apiClient.post(
      '/requests/$requestId/quotes/$quoteId/reject',
    );
    return ServiceRequest.fromJson(response.data['data']);
  }

  // Get status timeline
  Future<List<StatusHistoryEntry>> getStatusTimeline(String requestId) async {
    final response = await _apiClient.get('/requests/$requestId/timeline');
    return (response.data['data'] as List)
        .map((e) => StatusHistoryEntry.fromJson(e))
        .toList();
  }

  // ============ Craftsman Methods ============

  // Get available requests for craftsman
  Future<RequestListResponse> getAvailableRequests({
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _apiClient.get(
      '/requests/available',
      queryParameters: {'page': page, 'limit': limit},
    );

    return RequestListResponse(
      data: (response.data['data'] as List)
          .map((e) => ServiceRequest.fromJson(e))
          .toList(),
      page: response.data['pagination']['page'],
      totalPages: response.data['pagination']['totalPages'],
      total: response.data['pagination']['total'],
      limit: response.data['pagination']['limit'],
    );
  }

  // Get craftsman's active jobs
  Future<RequestListResponse> getActiveJobs({
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _apiClient.get(
      '/requests/my-jobs/active',
      queryParameters: {'page': page, 'limit': limit},
    );

    return RequestListResponse(
      data: (response.data['data'] as List)
          .map((e) => ServiceRequest.fromJson(e))
          .toList(),
      page: response.data['pagination']['page'],
      totalPages: response.data['pagination']['totalPages'],
      total: response.data['pagination']['total'],
      limit: response.data['pagination']['limit'],
    );
  }

  // Get craftsman's completed jobs
  Future<RequestListResponse> getCompletedJobs({
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _apiClient.get(
      '/requests/my-jobs/completed',
      queryParameters: {'page': page, 'limit': limit},
    );

    return RequestListResponse(
      data: (response.data['data'] as List)
          .map((e) => ServiceRequest.fromJson(e))
          .toList(),
      page: response.data['pagination']['page'],
      totalPages: response.data['pagination']['totalPages'],
      total: response.data['pagination']['total'],
      limit: response.data['pagination']['limit'],
    );
  }

  // Submit a quote
  Future<ServiceRequest> submitQuote(String requestId, SubmitQuoteData data) async {
    final response = await _apiClient.post(
      '/requests/$requestId/quotes',
      data: {
        'amount': data.amount,
        'estimatedDuration': data.estimatedDuration,
        'notes': data.notes,
        'validUntil': data.validUntil?.toIso8601String(),
      },
    );
    return ServiceRequest.fromJson(response.data['data']);
  }

  // Update request status (craftsman)
  Future<ServiceRequest> updateStatus(
    String requestId,
    RequestStatus status, {
    String? completionNotes,
    double? actualAmount,
    String? cancellationReason,
  }) async {
    final data = <String, dynamic>{
      'status': status.name,
    };

    if (completionNotes != null) data['completionNotes'] = completionNotes;
    if (actualAmount != null) data['actualAmount'] = actualAmount;
    if (cancellationReason != null) {
      data['cancellationReason'] = cancellationReason;
    }

    final response = await _apiClient.put(
      '/requests/$requestId/status',
      data: data,
    );
    return ServiceRequest.fromJson(response.data['data']);
  }
}
