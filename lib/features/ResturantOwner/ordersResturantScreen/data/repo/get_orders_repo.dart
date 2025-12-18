import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/data/models/get_orders_resturant_response.dart';
import 'package:delveria/features/deliveryAgent/data/models/accept_orders_model.dart';

class GetOrdersRepo {
  final ApiServices apiServices;

  GetOrdersRepo({required this.apiServices});

  Future<ApiResult<GetOrdersResturantResponse>> getOrdersResturant() async {
    try {
      final res = await apiServices.getOrdersResturant({});
      return ApiResult.success(res);
    } catch (e) {
      print("❌ Error getting orders: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<AcceptOrdersModel>> acceptOrder({required String orderId, required String subOrderId}) async {
    try {
      final res = await apiServices.acceptOrderRestaurant(orderId, subOrderId, {});
      return ApiResult.success(res);
    } catch (e) {
      print("❌ Error accepting order: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<AcceptOrdersModel>> markReady({required String orderId, required String subOrderId}) async {
    try {
      final res = await apiServices.readyForPickUp(orderId, subOrderId, {});
      return ApiResult.success(res);
    } catch (e) {
      print("❌ Error marking ready: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
