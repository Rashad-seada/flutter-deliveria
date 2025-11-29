import 'dart:convert';
import 'dart:io';

import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/change_enable_response.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/create_resturant_request.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/create_resturant_response.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/super_categories_response.dart';
import 'package:delveria/features/client/filter/data/models/filter_by_category_response.dart';
import 'package:delveria/features/client/home/data/models/get_nearby_response.dart';
import 'package:dio/dio.dart';

class ResturantAdminRepo {
  final ApiServices apiServices;

  ResturantAdminRepo({required this.apiServices});

  Future<ApiResult<AllResturantAdminResponse>>
  getAllResturantsforAdmin() async {
    final token =
        'Bearer ${await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken)}';
    try {
      final response = await apiServices.getAllResturantAdmin({}, token);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  //? rated resturants (all)
  Future<ApiResult<AllResturantAdminResponse>> getAllRatedResturantsforAdmin({
    required double lat,
    required double long,
  }) async {
    try {
      final response = await apiServices.getAllRatedResturantAdmin(
        {},
        lat,
        long,
      );
      return ApiResult.success(response);
    } catch (e) {
      print("errrrrror $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  //? rated resturants (all)
  Future<ApiResult<AllResturantAdminResponse>>
  getAllRatedResturantsWithoutLocation() async {
    final token = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    );
    try {
      final response = await apiServices.getAllRatedResturantWithoutLocation(
        {},
      );
      return ApiResult.success(response);
    } catch (e) {
      print("errrrrror $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<SuperCategoriesResponse>> getAllSuperCategories() async {
    try {
      final response = await apiServices.getAllSuperCategories();
      return ApiResult.success(response);
    } catch (e) {
      print("eeeeeeeee$e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  //? change open button
  Future<ApiResult<ChangeEnableResponse>> changeEnable({
    required String resID,
  }) async {
    try {
      final response = await apiServices.changeEnable(resID, {});
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<CreateResturantResponse>> creatResturantIndexed({
    required File photo,
    required File logo,
    required CreatResturantRequest creatRes,
  }) async {
    final token =
        'Bearer ${await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken)}';

    try {
      FormData formData = FormData();
      formData.files.addAll([
        MapEntry('logo', await MultipartFile.fromFile(logo.path)),
        MapEntry('photo', await MultipartFile.fromFile(photo.path)),
      ]);

      formData.fields.addAll([
        MapEntry('name', creatRes.name ?? ""),
        MapEntry('password', creatRes.password ?? ""),
        MapEntry('about_us', creatRes.aboutUs ?? ""),
        MapEntry('delivery_cost', creatRes.deliveryCost ?? ""),
        MapEntry('loacation_map', creatRes.locationMap ?? ""),
        MapEntry('open_hour', creatRes.openHour ?? ""),
        MapEntry('close_hour', creatRes.closeHour ?? ""),
        // MapEntry('have_delivery', creatRes.haveDelivery ?? ""),
        MapEntry('phone', creatRes.phone ?? ""),
        MapEntry('estimated_time', creatRes.estimatedTime ?? ""),
        MapEntry('latitude', creatRes.latitude ?? ""),
        MapEntry('longitude', creatRes.longitude ?? ""),
      ]);

      // Fix: Only send a list of id values, not a list of sets
      if (creatRes.superCategory != null &&
          creatRes.superCategory!.isNotEmpty) {
        final superCategoryList = creatRes.superCategory!.toList();
        formData.fields.add(
          MapEntry('super_category', jsonEncode(superCategoryList)),
        );
      }

      if (creatRes.subCategory != null && creatRes.subCategory!.isNotEmpty) {
        final subCategoryList = creatRes.subCategory!.toList();
        formData.fields.add(
          MapEntry('sub_category', jsonEncode(subCategoryList)),
        );
      }

      final response = await apiServices.creatResturant(formData, token);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<GetNearbyResponse>> getNearbyResponse({
    required double lat,
    required double long,
  }) async {
    try {
      final res = await apiServices.getNearbyResturants({}, lat, long);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<FilterbyCategoryResponse>> filterByCategoryAdmin({
    required String superId,
    required String subId,
  }) async {
    try {
      final res = await apiServices.filterByCategoryAdmin({}, superId, subId);
      return ApiResult.success(res);
    } catch (e) {
      print("heeeeey this is error $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<AllResturantAdminResponse>> searchResturant({
    required String query,
  }) async {
    try {
      final res = await apiServices.searchResturant({"search": query});
      return ApiResult.success(res);
    } catch (e) {
      print("🤬 error $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
