import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/client/onboarding/data/models/get_system_data_response.dart';

class GetSystemDataRepo {
  final ApiServices apiServices;

  GetSystemDataRepo({required this.apiServices});

  Future<ApiResult<GetSystemDataResponse>> getSystemData() async {
    try {
      final res = await apiServices.getSystemData({});
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
