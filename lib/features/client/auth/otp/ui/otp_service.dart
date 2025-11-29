import 'package:akedly/akedly.dart';
import 'package:delveria/core/network/api_constants.dart';

class OTPService {
  late final AkedlyClient _client;

  OTPService() {
    _client = AkedlyClient(
      apiKey: ApiConstants.apiKeyOtp,
      pipelineId: ApiConstants.piplineId,
    );
  }

  Future<String?> sendOTPToUser(
    String phoneNumber, {
    Function(String error)? onError,
  }) async {
    try {
      final verificationId = await _client.sendOTP(phoneNumber, "");
      return verificationId;
    } on AkedlyException catch (e) {
      final msg = e.message.toLowerCase() ?? '';

      if (msg.contains("pipeline is not configured") ||
          msg.contains("no callback urls")) {
        final errorMsg =
            "Service is not available: OTP pipeline is not properly configured. Please contact support.";
        onError?.call(errorMsg);
      } else {
        final errorMsg = 'Error sending OTP: ${e.message ?? "Unknown error"}';
        onError?.call(errorMsg);
      }
      return null;
    } catch (e) {
      final errorMsg = 'Error sending OTP: ${e.toString()}';
      onError?.call(errorMsg);
      return null;
    }
  }

  Future<bool> verifyUserOTP(
    String verificationId,
    String otpCode, {
    Function(String error)? onError,
  }) async {
    try {
      final result = await _client.verifyOTP(verificationId, otpCode);

      return result;
    } on AkedlyException catch (e) {
      final msg = e.message.toLowerCase() ?? '';

      if (msg.contains("pipeline is not configured") ||
          msg.contains("no callback urls")) {
        final errorMsg =
            "Service is not available: OTP pipeline is not properly configured. Please contact support.";
        onError?.call(errorMsg);
      } else {
        final errorMsg = 'Error verifying OTP: ${e.message ?? "Unknown error"}';
        onError?.call(errorMsg);
      }
      return false;
    } catch (e) {
      final errorMsg = 'Error verifying OTP: ${e.toString()}';
      onError?.call(errorMsg);
      return false;
    }
  }

  void dispose() {
    _client.dispose();
  }
}
