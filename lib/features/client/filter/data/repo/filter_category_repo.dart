import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/client/filter/data/models/filter_by_category_response.dart';
import 'package:delveria/features/client/filter/data/models/sort_by_price.dart';

class FilterCategoryRepo {
  final ApiServices apiServices;

  FilterCategoryRepo({required this.apiServices});

  Future<ApiResult<FilterbyCategoryResponse>> filterByCategory({
    required String superId,
    required String subId,
    required double lat,
    required double long,
  }) async {
    try {
      final res = await apiServices.filterByCategory(
        {},
        superId,
        subId,
        lat,
        long,
      );
      return ApiResult.success(res);
    } catch (e) {
      print("errror$e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<SortByPriceResponse>> sortByPrice({
    required String resId,
  }) async {
    try {
      final res = await apiServices.sortByPrice(resId);
      print("successsss");
      return ApiResult.success(res);
    } catch (e) {
      print(e);
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
