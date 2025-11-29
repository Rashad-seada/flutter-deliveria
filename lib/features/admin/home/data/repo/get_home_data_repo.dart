import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/admin/home/data/models/get_home_data_admin_response.dart';

class GetHomeDataRepo {
  final ApiServices apiServices;

  GetHomeDataRepo({required this.apiServices});

  Future<ApiResult<GetHomeDataAdminResponse>> getHomeDataAdmin() async {
    final token = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    );
    try {
      final res = await apiServices.getHomeDataAdmin({});
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
