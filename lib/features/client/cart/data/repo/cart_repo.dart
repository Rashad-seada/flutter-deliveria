import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/client/cart/data/models/add_cart_response.dart';
import 'package:delveria/features/client/cart/data/models/add_order_response.dart';
import 'package:delveria/features/client/cart/data/models/add_to_cart_request.dart';
import 'package:delveria/features/client/cart/data/models/decrease_item_cart_response.dart';
import 'package:delveria/features/client/cart/data/models/get_cart_response.dart';
import 'package:delveria/features/client/cart/data/models/increase_item_cart_response.dart';
import 'package:delveria/features/client/cart/data/models/remove_cart_response.dart';

class CartRepo {
  final ApiServices apiServices;

  CartRepo({required this.apiServices});

  Future<ApiResult<AddCartResponse>> addToCart({
    required AddToCartRequest addToCart,
  }) async {
    try {
      final res = await apiServices.addToCart(addToCart);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
  Future<ApiResult<GetCartResponse>> getCart() async {
    try {
      final res = await apiServices.getCart({});
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
  Future<ApiResult<IncreaseItemCartResponse>> increaseItemCart({required Map<String,dynamic> body}) async {
    try {
      final res = await apiServices.increaseItemCart(body);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
  Future<ApiResult<DecreaseItemCartResponse>> decreaseItemCart({required Map<String,dynamic> body}) async {
    try {
      final res = await apiServices.decreaseItem(body);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
  Future<ApiResult<RemoveCartResponse>> removeCart({required Map<String,dynamic> body}) async {
    try {
      final res = await apiServices.removeCart(body);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
  Future<ApiResult<AddOrderResponse>> addOrder({required Map<String,dynamic> body}) async {
    try {
      final res = await apiServices.addOrder(body);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
