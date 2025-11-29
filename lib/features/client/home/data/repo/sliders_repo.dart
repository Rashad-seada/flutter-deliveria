import 'dart:io';

import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/admin/slider/data/models/create_slider_response.dart';
import 'package:delveria/features/admin/slider/data/models/delete_slider_response.dart';
import 'package:delveria/features/client/home/data/models/get_sliders_response.dart';
import 'package:delveria/features/client/home/data/models/search_response.dart';

class SlidersRepo {
  final ApiServices apiServices;

  SlidersRepo({required this.apiServices});
  Future<ApiResult<GetSlidersResponse>> getSliders() async {
    try {
      final res = await apiServices.getSliders({});
      return ApiResult.success(res);
    } catch (e) {
      print("errrrror $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<CreateSliderResponse>> createSlider({
    required File image,
    required String resId,
  }) async {
    try {
      final res = await apiServices.createSlider(image, resId);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DeleteSliderResponse>> deleteSlider({
    required String sliderId,
  }) async {
    try {
      final res = await apiServices.deleteSlider(sliderId, {});
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<AllResturantAdminResponse>> searchResturantUserSide({
    required String query,
    required double lat,
    required double long,
  }) async {
    try {
      final res = await apiServices.searchResturantUserSider(
        {"search": query},
        lat,
        long,
      );
      return ApiResult.success(res);
    } catch (e) {
      print("🤬 error in search user side resturant  $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<SearchResponseItem>> searchResturantitems({
    required String query,
    required String id,
  }) async {
    try {
      final res = await apiServices.searchRestaurnt(id, query, {});
      return ApiResult.success(res);
    } catch (e) {
      print("🤬 error in search user side resturant item  $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
