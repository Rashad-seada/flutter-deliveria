import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/ResturantOwner/home/data/models/get_home_data_resturant_response.dart';
import 'package:delveria/features/ResturantOwner/home/data/models/get_resturant_data_response.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/change_enable_response.dart';

class ResturantDataRepo {
  final ApiServices apiServices;

  ResturantDataRepo({required this.apiServices});

  Future<ApiResult<GetResturantDataResponseHome>> getResturantData() async {
    try {
      final res = await apiServices.getResturantData({});
      return ApiResult.success(res);
    } catch (e) {
      print("error $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<GetHomeDataResturantResponse>>
  getResturantDataForHome() async {
    try {
      final res = await apiServices.getHomeDataResturant({});
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<ChangeEnableResponse>> changeEnableResturantOwner({
    required String resID,
  }) async {
    try {
      final response = await apiServices.changeEnableResturantOwner(resID, {});
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
