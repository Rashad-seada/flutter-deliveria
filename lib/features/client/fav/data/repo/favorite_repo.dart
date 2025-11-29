import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/client/fav/data/models/add_to_fav_res.dart';
import 'package:delveria/features/client/fav/data/models/delete_fav_response.dart';
import 'package:delveria/features/client/fav/data/models/get_fav_response.dart';

class FavoriteRepo {
  final ApiServices apiServices;

  FavoriteRepo({required this.apiServices});

  Future<ApiResult<AddToFavRes>> addToFav({required String resId}) async {
    try {
      final res = await apiServices.addToFav(resId, {});
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<GetFavResponse>> getFav() async {
    try {
      final res = await apiServices.getFav({});
      return ApiResult.success(res);
    } catch (e) {
      print("error fav $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DeleteFavResponse>> deleteFav({
    required String resId,
  }) async {
    try {
      final res = await apiServices.deleteFav(resId, {});
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
