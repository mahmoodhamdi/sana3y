import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/request.dart';
import '../services/request_service.dart';

part 'request_provider.g.dart';

// Customer requests provider
@riverpod
class CustomerRequestsNotifier extends _$CustomerRequestsNotifier {
  @override
  Future<List<ServiceRequest>> build() async {
    return _loadRequests();
  }

  Future<List<ServiceRequest>> _loadRequests({RequestStatus? status}) async {
    final service = ref.read(requestServiceProvider);
    final response = await service.getMyRequests(status: status);
    return response.data;
  }

  Future<void> refresh({RequestStatus? status}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loadRequests(status: status));
  }

  Future<ServiceRequest> createRequest(CreateRequestData data) async {
    final service = ref.read(requestServiceProvider);
    final request = await service.createRequest(data);

    // Add to current list
    state = AsyncData([request, ...state.value ?? []]);
    return request;
  }

  Future<void> cancelRequest(String id, {String? reason}) async {
    final service = ref.read(requestServiceProvider);
    final updated = await service.cancelRequest(id, reason: reason);

    state = AsyncData(
      (state.value ?? [])
          .map((r) => r.id == id ? updated : r)
          .toList(),
    );
  }

  Future<void> acceptQuote(String requestId, String quoteId) async {
    final service = ref.read(requestServiceProvider);
    final updated = await service.acceptQuote(requestId, quoteId);

    state = AsyncData(
      (state.value ?? [])
          .map((r) => r.id == requestId ? updated : r)
          .toList(),
    );
  }

  Future<void> rejectQuote(String requestId, String quoteId) async {
    final service = ref.read(requestServiceProvider);
    final updated = await service.rejectQuote(requestId, quoteId);

    state = AsyncData(
      (state.value ?? [])
          .map((r) => r.id == requestId ? updated : r)
          .toList(),
    );
  }
}

// Single request detail provider
@riverpod
Future<ServiceRequest> requestDetail(RequestDetailRef ref, String id) async {
  final service = ref.watch(requestServiceProvider);
  return service.getRequestById(id);
}

// Active customer requests (pending, quoted, accepted, in progress)
@riverpod
Future<List<ServiceRequest>> activeCustomerRequests(
  ActiveCustomerRequestsRef ref,
) async {
  final service = ref.watch(requestServiceProvider);
  final response = await service.getMyRequests();
  return response.data.where((r) => r.isActive).toList();
}

// Completed customer requests
@riverpod
Future<List<ServiceRequest>> completedCustomerRequests(
  CompletedCustomerRequestsRef ref,
) async {
  final service = ref.watch(requestServiceProvider);
  final response = await service.getMyRequests(status: RequestStatus.completed);
  return response.data;
}

// =============== Craftsman Providers ===============

// Available requests for craftsman
@riverpod
class AvailableRequestsNotifier extends _$AvailableRequestsNotifier {
  int _currentPage = 1;
  bool _hasMore = true;

  @override
  Future<List<ServiceRequest>> build() async {
    return _loadRequests(refresh: true);
  }

  Future<List<ServiceRequest>> _loadRequests({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _hasMore = true;
    }

    final service = ref.read(requestServiceProvider);
    final response = await service.getAvailableRequests(page: _currentPage);

    _hasMore = response.page < response.totalPages;
    return response.data;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loadRequests(refresh: true));
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;

    _currentPage++;
    final service = ref.read(requestServiceProvider);
    final response = await service.getAvailableRequests(page: _currentPage);

    _hasMore = response.page < response.totalPages;
    state = AsyncData([...state.value ?? [], ...response.data]);
  }

  Future<void> submitQuote(String requestId, SubmitQuoteData data) async {
    final service = ref.read(requestServiceProvider);
    await service.submitQuote(requestId, data);

    // Remove from available list after quoting
    state = AsyncData(
      (state.value ?? []).where((r) => r.id != requestId).toList(),
    );
  }

  bool get hasMore => _hasMore;
}

// Craftsman active jobs
@riverpod
class ActiveJobsNotifier extends _$ActiveJobsNotifier {
  @override
  Future<List<ServiceRequest>> build() async {
    return _loadJobs();
  }

  Future<List<ServiceRequest>> _loadJobs() async {
    final service = ref.read(requestServiceProvider);
    final response = await service.getActiveJobs();
    return response.data;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadJobs);
  }

  Future<void> updateStatus(
    String requestId,
    RequestStatus status, {
    String? completionNotes,
    double? actualAmount,
    String? cancellationReason,
  }) async {
    final service = ref.read(requestServiceProvider);
    final updated = await service.updateStatus(
      requestId,
      status,
      completionNotes: completionNotes,
      actualAmount: actualAmount,
      cancellationReason: cancellationReason,
    );

    // If completed or cancelled, remove from active jobs
    if (status == RequestStatus.completed || status == RequestStatus.cancelled) {
      state = AsyncData(
        (state.value ?? []).where((r) => r.id != requestId).toList(),
      );
    } else {
      state = AsyncData(
        (state.value ?? [])
            .map((r) => r.id == requestId ? updated : r)
            .toList(),
      );
    }
  }
}

// Craftsman completed jobs
@riverpod
class CompletedJobsNotifier extends _$CompletedJobsNotifier {
  int _currentPage = 1;
  bool _hasMore = true;

  @override
  Future<List<ServiceRequest>> build() async {
    return _loadJobs(refresh: true);
  }

  Future<List<ServiceRequest>> _loadJobs({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _hasMore = true;
    }

    final service = ref.read(requestServiceProvider);
    final response = await service.getCompletedJobs(page: _currentPage);

    _hasMore = response.page < response.totalPages;
    return response.data;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loadJobs(refresh: true));
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;

    _currentPage++;
    final service = ref.read(requestServiceProvider);
    final response = await service.getCompletedJobs(page: _currentPage);

    _hasMore = response.page < response.totalPages;
    state = AsyncData([...state.value ?? [], ...response.data]);
  }

  bool get hasMore => _hasMore;
}

// Craftsman earnings summary
@riverpod
Future<Map<String, dynamic>> craftsmanEarnings(CraftsmanEarningsRef ref) async {
  final completedJobs = await ref.watch(completedJobsNotifierProvider.future);

  double totalEarnings = 0;
  double thisMonthEarnings = 0;
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);

  for (final job in completedJobs) {
    final amount = job.actualAmount ?? job.acceptedQuote?.amount ?? 0;
    totalEarnings += amount;

    if (job.completedAt != null && job.completedAt!.isAfter(startOfMonth)) {
      thisMonthEarnings += amount;
    }
  }

  return {
    'totalEarnings': totalEarnings,
    'thisMonthEarnings': thisMonthEarnings,
    'completedJobsCount': completedJobs.length,
  };
}
