import 'dart:convert';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/network/dio_factory.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart' as dio;

/// OTP Service that delegates OTP sending/verification to the backend,
/// which uses BeOn SDK for WhatsApp/SMS delivery.
///
/// This replaces the old client-side Akedly SDK approach for better security —
/// OTP generation now happens on the server, preventing bypass attacks.
class OTPService {
  final _dio = DioFactory.getDio();

  /// Send OTP to the given phone number via the backend
  /// The backend will use BeOn SDK to deliver via WhatsApp (with SMS fallback)
  Future<bool> sendOTPToUser(
    String phoneNumber, {
    Function(String error, int? retryAfter)? onError,
  }) async {
    final url = '${ApiConstants.baseUrl}/otp/send';
    final data = {'phone': phoneNumber, 'channel': 'whatsapp'};
    debugPrint('[OTP] ▶ sendOTPToUser | URL: $url | body: $data');

    try {
      final response = await _dio.post(url, data: data);

      debugPrint('[OTP] ◀ sendOTPToUser | status: ${response.statusCode} | body: ${response.data}');

      if (response.statusCode == 200 && response.data['success'] == true) {
        debugPrint('[OTP] ✅ OTP sent successfully to $phoneNumber');
        return true;
      } else {
        final msg = response.data['message'] ?? 'Failed to send OTP';
        debugPrint('[OTP] ❌ sendOTPToUser error: $msg');
        onError?.call(msg, null);
        return false;
      }
    } on dio.DioException catch (e) {
      debugPrint('[OTP] 🚫 sendOTPToUser DioError: ${e.type} | ${e.message}');
      
      if (e.response?.statusCode == 429) {
        final retryAfter = e.response?.data['retry_after'] ?? 60;
        debugPrint('[OTP] ⏳ Rate limited. Retry after: ${retryAfter}s');
        onError?.call('Please wait $retryAfter seconds before requesting a new OTP', retryAfter);
      } else {
        final msg = e.response?.data['message'] ?? 'Network error occurred';
        onError?.call(msg, null);
      }
      return false;
    } catch (e, stack) {
      debugPrint('[OTP] 🔥 sendOTPToUser exception: $e\n$stack');
      onError?.call('Error sending OTP: ${e.toString()}', null);
      return false;
    }
  }

  /// Verify OTP code via the backend
  /// The backend checks the code and marks the user as verified on success
  Future<bool> verifyUserOTP(
    String phoneNumber,
    String otpCode, {
    Function(String error, int? remainingAttempts)? onError,
  }) async {
    final url = '${ApiConstants.baseUrl}/otp/verify';
    final data = {'phone': phoneNumber, 'code': otpCode};
    debugPrint('[OTP] ▶ verifyUserOTP | URL: $url | body: $data');

    try {
      final response = await _dio.post(url, data: data);

      debugPrint('[OTP] ◀ verifyUserOTP | status: ${response.statusCode} | body: ${response.data}');

      if (response.statusCode == 200 && response.data['success'] == true) {
        debugPrint('[OTP] ✅ OTP verified for $phoneNumber');
        return true;
      } else {
        final msg = response.data['message'] ?? 'Invalid OTP code';
        final remainingAttempts = response.data['remaining_attempts'];
        debugPrint('[OTP] ❌ verifyUserOTP failed: $msg | remaining attempts: $remainingAttempts');
        onError?.call(msg, remainingAttempts);
        return false;
      }
    } on dio.DioException catch (e) {
      final msg = e.response?.data['message'] ?? 'Verification failed';
      final remainingAttempts = e.response?.data['remaining_attempts'];
      onError?.call(msg, remainingAttempts);
      return false;
    } catch (e, stack) {
      debugPrint('[OTP] 🔥 verifyUserOTP exception: $e\n$stack');
      onError?.call('Error verifying OTP: ${e.toString()}', null);
      return false;
    }
  }

  /// Resend OTP via the backend (generates a fresh code)
  Future<bool> resendOTP(
    String phoneNumber, {
    Function(String error, int? retryAfter)? onError,
  }) async {
    final url = '${ApiConstants.baseUrl}/otp/resend';
    final data = {'phone': phoneNumber, 'channel': 'whatsapp'};
    debugPrint('[OTP] ▶ resendOTP | URL: $url | body: $data');

    try {
      final response = await _dio.post(url, data: data);

      debugPrint('[OTP] ◀ resendOTP | status: ${response.statusCode} | body: ${response.data}');

      if (response.statusCode == 200 && response.data['success'] == true) {
        debugPrint('[OTP] ✅ OTP resent successfully to $phoneNumber');
        return true;
      } else {
        final msg = response.data['message'] ?? 'Failed to resend OTP';
        onError?.call(msg, null);
        return false;
      }
    } on dio.DioException catch (e) {
      if (e.response?.statusCode == 429) {
        final retryAfter = e.response?.data['retry_after'] ?? 60;
        onError?.call('Please wait $retryAfter seconds before requesting a new OTP', retryAfter);
      } else {
        final msg = e.response?.data['message'] ?? 'Failed to resend OTP';
        onError?.call(msg, null);
      }
      return false;
    } catch (e, stack) {
      debugPrint('[OTP] 🔥 resendOTP exception: $e\n$stack');
      onError?.call('Error resending OTP: ${e.toString()}', null);
      return false;
    }
  }

  void dispose() {
    // No resources to dispose (Dio client is shared)
  }
}
