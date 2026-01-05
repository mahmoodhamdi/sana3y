import '../config/constants.dart';
import 'api_client.dart';

class PaymentService {
  final ApiClient _client;

  PaymentService(this._client);

  /// Initialize card payment via Paymob
  Future<Map<String, dynamic>?> initializePayment({
    required String requestId,
    required double amount,
  }) async {
    try {
      final response = await _client.post(
        '${ApiEndpoints.payments}/initialize',
        data: {
          'requestId': requestId,
          'amount': amount,
        },
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return response.data['data'] as Map<String, dynamic>;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  /// Initialize wallet payment (Vodafone Cash, Orange Money, etc.)
  Future<Map<String, dynamic>?> initializeWalletPayment({
    required String requestId,
    required double amount,
    required String walletPhone,
  }) async {
    try {
      final response = await _client.post(
        '${ApiEndpoints.payments}/wallet',
        data: {
          'requestId': requestId,
          'amount': amount,
          'walletPhone': walletPhone,
        },
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return response.data['data'] as Map<String, dynamic>;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  /// Get payment status
  Future<Map<String, dynamic>?> getPaymentStatus(String transactionId) async {
    try {
      final response = await _client.get(
        '${ApiEndpoints.payments}/$transactionId/status',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return response.data['data'] as Map<String, dynamic>;
      }
    } catch (e) {
      // Handle error
    }
    return null;
  }
}
