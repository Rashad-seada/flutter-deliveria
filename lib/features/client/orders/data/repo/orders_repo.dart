import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/client/orders/data/models/get_orders_model.dart';
import 'package:delveria/features/client/orders/data/models/reorder_response.dart';

class OrdersRepo {
  final ApiServices apiServices;

  OrdersRepo({required this.apiServices});

  Future<ApiResult<GetOrdersModel>> getOrders() async {
    try {
      final res = await apiServices.getOrders({});
      return ApiResult.success(res);
    } catch (e) {
      print("orrrders error $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<ReorderResponse>> reorder({required String orderId}) async {
    try {
      final res = await apiServices.reorder(orderId, {});
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
