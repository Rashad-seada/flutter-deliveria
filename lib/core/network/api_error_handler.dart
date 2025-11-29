import 'package:delveria/core/network/api_error_model.dart';
import 'package:dio/dio.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(message: "Connection to server failed", success: false);
        case DioExceptionType.cancel:
          return ApiErrorModel(message: "Request to the server was cancelled", success: false);
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(message: "Connection timeout with the server", success: false);
        case DioExceptionType.unknown:
          return ApiErrorModel(
            success: false,
            message: "Connection to the server failed due to internet connection",
          );
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
            success: false,
            message: "Receive timeout in connection with the server",
          );
        case DioExceptionType.badResponse:
          return _handleError(error.response?.data);
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
            success: false,
            message: "Send timeout in connection with the server",
          );
        default:
          return ApiErrorModel(message: "Something went wrong", success: false);
      }
    } else {
      return ApiErrorModel(message: error.toString(), success: false);
    }
  }
}

ApiErrorModel _handleError(dynamic data) {
  // If the response body contains a "success" field and it's false, use its message
  if (data is Map<String, dynamic>) {
    if (data.containsKey('success') && data['success'] == false) {
      return ApiErrorModel(
        success: false,
        message: data['message'] ?? "Unknown error occurred",
      );
    }
    // If "success" is not present, fallback to message if available
    return ApiErrorModel(
      success: false,
      message: data['message'] ?? "Unknown error occurred",
    );
  }
  // If data is not a map, fallback to generic error
  return ApiErrorModel(
    success: false,
    message: "Unknown error occurred",
  );
}
