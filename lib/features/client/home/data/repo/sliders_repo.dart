import 'dart:io';

import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/network/dio_factory.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/admin/slider/data/models/create_slider_response.dart';
import 'package:delveria/features/admin/slider/data/models/delete_slider_response.dart';
import 'package:delveria/features/client/home/data/models/get_sliders_response.dart';
import 'package:delveria/features/client/home/data/models/search_response.dart';
import 'package:delveria/features/client/home/data/models/offers_response.dart';
import 'package:delveria/features/client/home/data/models/best_sellers_response.dart';

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
        {
          "search": query,
          "query": query,
          "text": query,
          "search_text": query,
        },
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

  // ============ OFFERS API METHODS ============

  /// Get restaurants with active offers for home carousel
  Future<ApiResult<RestaurantsWithOffersResponse>> getRestaurantsWithOffers({
    required double lat,
    required double long,
  }) async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.getRestaurantsWithOffersLink}/$lat/$long",
      );
      final res = RestaurantsWithOffersResponse.fromJson(response.data);
      return ApiResult.success(res);
    } catch (e) {
      print("🔥 error getting restaurants with offers: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  /// Get offer items for a specific restaurant (for Offers tab)
  Future<ApiResult<RestaurantOffersResponse>> getRestaurantOffers({
    required String restaurantId,
  }) async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.getRestaurantOffersLink}/$restaurantId/offers",
      );
      final res = RestaurantOffersResponse.fromJson(response.data);
      return ApiResult.success(res);
    } catch (e) {
      print("🔥 error getting restaurant offers: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  /// Get restaurant details with has_offers flag
  Future<ApiResult<RestaurantDetailsResponse>> getRestaurantDetails({
    required String restaurantId,
  }) async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.getRestaurantDetailsLink}/$restaurantId",
      );
      final res = RestaurantDetailsResponse.fromJson(response.data);
      return ApiResult.success(res);
    } catch (e) {
      print("🔥 error getting restaurant details: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  // ============ BEST SELLERS API METHODS ============

  /// Get best seller restaurants (top 10 by completed orders)
  Future<ApiResult<BestSellersResponse>> getBestSellers({
    required double lat,
    required double long,
    int limit = 10,
  }) async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.getBestSellersLink}/$lat/$long",
        queryParameters: {'limit': limit},
      );
      final res = BestSellersResponse.fromJson(response.data);
      return ApiResult.success(res);
    } catch (e) {
      print("🔥 error getting best sellers: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
