import 'dart:io';

import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/change_enable_item_response.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/create_item_response.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/edit_item_response.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/get_all_item_response.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/item_categories_response_user.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/items_category_model.dart';

class ItemsRepo {
  final ApiServices apiServices;

  ItemsRepo({required this.apiServices});

  Future<ApiResult<CreateItemResponse>> createItem({
    required File photo,
    required String name,
    required String description,
    required String itemCategory,
    required String sizes,
    required String toppings,
    required bool have_option,
  }) async {
    try {
      final res = await apiServices.createItem(
        photo,
        name,
        description,
        itemCategory,
        sizes,
        toppings,
        have_option
      );
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<EditItemResponse>> editItem({
    required String itemId,
    required String name,
    required String description,
    required String sizes,
    required String toppings,
  }) async {
    final token =
        'Bearer ${await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken)}';

    try {
      final body = {
        "name": name,
        "description": description,
        "sizes": sizes,
        "toppings": toppings,
      };
      final res = await apiServices.editItem(itemId, body, token);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<EditItemResponse>> deleteItem({
    required String itemId,
  }) async {
    try {
      final res = await apiServices.deletItem(itemId, {});
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<GetAllItemsResponse>> getAllItem({
    required String code,
  }) async {
    try {
      final res = await apiServices.getAllItems(code);
      return ApiResult.success(res);
    } catch (e) {
      print("error $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<ItemsCategoryResponse>> getItemCategories() async {
    try {
      final res = await apiServices.getItemsCategories({});
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<ItemsCategoryResponseUser>> getItemCategoriesUser({
    required String resId,
  }) async {
    final token =
        'Bearer ${await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken)}';

    try {
      final res = await apiServices.getItemsCategoriesUser(resId, token, {});
      return ApiResult.success(res);
    } catch (e) {
      print("errrrrrror $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<GetAllItemsResponse>> filterItemCategoriesUser({
    required String cateId,
    required String resId,
  }) async {
    final token =
        'Bearer ${await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken)}';

    try {
      final res = await apiServices.filtertemsCategoriesUser(
        cateId,
        resId,
        token,
        {},
      );
      return ApiResult.success(res);
    } catch (e) {
      print("errrrrrror $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<CreateItemResponse>> createItemCategory({
    required Map<String, dynamic> body,
  }) async {
    try {
      final res = await apiServices.createItemCategory(body);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<ChangeEnableItemResponse>> changeEnableItem({
    required String id,
  }) async {
    try {
      final res = await apiServices.changeEnableItem(id, {});
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
