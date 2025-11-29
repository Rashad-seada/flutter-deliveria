import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/client/auth/signUp/data/models/sign_up_request_body.dart';
import 'package:delveria/features/client/auth/signUp/data/models/sign_up_response.dart';

class SignUpRepo {
  final ApiServices apiServices;

  SignUpRepo({required this.apiServices});
  Future<ApiResult<SignUpResponse>> signUp(
    SignUpRequestBody signUpRequestBody,
  ) async {
    try {
      final res = await apiServices.signUp(signUpRequestBody);
      return ApiResult.success(res);
    } catch (e) {
      print(e);
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
