import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/client/auth/login/data/models/login_request.dart';
import 'package:delveria/features/client/auth/login/data/models/login_response.dart';

class LoginRepo {
  final ApiServices apiServices;

  LoginRepo({required this.apiServices});
  Future<ApiResult<LoginResponse>> login(LoginRequestBody loginRequest) async {
    try {
      final response = await apiServices.login(loginRequest);
      return ApiResult.success(response);
    } catch (e) {
      print("errrrrrror $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
