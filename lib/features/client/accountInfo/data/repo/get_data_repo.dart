import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/client/accountInfo/data/model/get_user_data_response.dart';
import 'package:delveria/features/client/accountInfo/data/model/update_user_info_response.dart';

class GetDataRepo {
  final ApiServices apiServices;

  GetDataRepo({required this.apiServices});

  Future<ApiResult<GetUserDataResponse>> getUserData() async {
    try {
      final res = await apiServices.getUserData({});
      return ApiResult.success(res);
    } catch (e) {
      print("eeeeeeror $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<UpdateUserInfoResponse>> updateUserInfo({
    required Map<String, dynamic> body,
  }) async {
    try {
      final res = await apiServices.updateUserInfo(body);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
