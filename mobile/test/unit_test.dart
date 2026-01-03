import 'package:flutter_test/flutter_test.dart';
import 'package:sana3y/config/constants.dart';

void main() {
  group('AppConstants', () {
    test('should have correct commission rate', () {
      expect(AppConstants.defaultCommission, 15.0);
    });

    test('should have correct service fee', () {
      expect(AppConstants.defaultServiceFee, 5.0);
    });

    test('should have correct urgent fee', () {
      expect(AppConstants.urgentFee, 20.0);
    });

    test('should have valid default location', () {
      expect(AppConstants.defaultLatitude, closeTo(30.4522, 0.001));
      expect(AppConstants.defaultLongitude, closeTo(30.9667, 0.001));
    });

    test('should have valid default radius', () {
      expect(AppConstants.defaultRadius, greaterThan(0));
      expect(AppConstants.defaultRadius, lessThanOrEqualTo(50));
    });
  });

  group('Phone Validation', () {
    final egyptPhoneRegex = RegExp(AppConstants.egyptPhonePattern);

    test('should validate correct Egyptian phone numbers', () {
      expect(egyptPhoneRegex.hasMatch('+201012345678'), true);
      expect(egyptPhoneRegex.hasMatch('+201112345678'), true);
      expect(egyptPhoneRegex.hasMatch('+201212345678'), true);
      expect(egyptPhoneRegex.hasMatch('+201512345678'), true);
    });

    test('should reject invalid phone numbers', () {
      expect(egyptPhoneRegex.hasMatch('01012345678'), false);
      expect(egyptPhoneRegex.hasMatch('+20101234567'), false);
    });
  });

  group('Fee Calculations', () {
    test('should calculate service fee correctly', () {
      const amount = 1000.0;
      final serviceFee = amount * (AppConstants.defaultServiceFee / 100);
      expect(serviceFee, 50.0);
    });

    test('should calculate urgent fee correctly', () {
      const amount = 1000.0;
      final urgentFee = amount * (AppConstants.urgentFee / 100);
      expect(urgentFee, 200.0);
    });

    test('should calculate commission correctly', () {
      const amount = 1000.0;
      final commission = amount * (AppConstants.defaultCommission / 100);
      expect(commission, 150.0);
    });

    test('should calculate total with all fees', () {
      const baseAmount = 1000.0;
      final serviceFee = baseAmount * (AppConstants.defaultServiceFee / 100);
      final urgentFee = baseAmount * (AppConstants.urgentFee / 100);
      final total = baseAmount + serviceFee + urgentFee;
      expect(total, 1250.0);
    });
  });

  group('Socket Events', () {
    test('should have request events defined', () {
      expect(SocketEvents.requestNew, 'request:new');
      expect(SocketEvents.requestQuote, 'request:quote');
      expect(SocketEvents.requestAccepted, 'request:accepted');
      expect(SocketEvents.requestStatus, 'request:status');
    });

    test('should have message events defined', () {
      expect(SocketEvents.messageNew, 'message:new');
      expect(SocketEvents.messageRead, 'message:read');
    });

    test('should have craftsman events defined', () {
      expect(SocketEvents.craftsmanOnline, 'craftsman:online');
      expect(SocketEvents.craftsmanOffline, 'craftsman:offline');
    });
  });

  group('API Endpoints', () {
    test('should have auth endpoints defined', () {
      expect(ApiEndpoints.sendOtp, '/auth/send-otp');
      expect(ApiEndpoints.verifyOtp, '/auth/verify-otp');
      expect(ApiEndpoints.register, '/auth/register');
      expect(ApiEndpoints.login, '/auth/login');
    });

    test('should have category endpoint defined', () {
      expect(ApiEndpoints.categories, '/categories');
    });

    test('should have craftsmen endpoints defined', () {
      expect(ApiEndpoints.craftsmen, '/craftsmen');
      expect(ApiEndpoints.nearbyCraftsmen, '/craftsmen/nearby');
      expect(ApiEndpoints.searchCraftsmen, '/craftsmen/search');
    });

    test('should have request endpoint defined', () {
      expect(ApiEndpoints.requests, '/requests');
    });
  });

  group('Storage Keys', () {
    test('should have auth storage keys', () {
      expect(AppConstants.tokenKey, 'auth_token');
      expect(AppConstants.refreshTokenKey, 'refresh_token');
      expect(AppConstants.userKey, 'user_data');
    });
  });
}
