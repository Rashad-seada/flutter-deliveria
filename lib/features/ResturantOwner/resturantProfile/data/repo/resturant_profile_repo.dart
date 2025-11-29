import 'dart:convert';
import 'dart:io';

import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/ResturantOwner/resturantProfile/data/models/get_resturant_data_response_for_profile.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/create_resturant_request.dart';
import 'package:dio/dio.dart';

class ResturantProfileRepo {
  final ApiServices apiServices;

  ResturantProfileRepo({required this.apiServices});

  Future<ApiResult<GetResturantDataResponseProfile>> getResturantData() async {
    try {
      final res = await apiServices.getResturantProfileData({});
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
  Future<ApiResult> updateRestaurnatInfo({
    required File? photo,
    required File? logo,
    required CreatResturantRequest creatRes,
    required String id,
  }) async {
    final token =
        'Bearer ${await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken)}';

    try {
      FormData formData = FormData();

      // Add logo and photo files only if they are not null
      if (logo != null) {
        formData.files.add(
          MapEntry('logo', await MultipartFile.fromFile(logo.path)),
        );
      }
      if (photo != null) {
        formData.files.add(
          MapEntry('photo', await MultipartFile.fromFile(photo.path)),
        );
      }

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

      // Only send a list of id values if present
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

      final response = await apiServices.editRestaurantProfile(
        id,
        formData,
        token,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

}
