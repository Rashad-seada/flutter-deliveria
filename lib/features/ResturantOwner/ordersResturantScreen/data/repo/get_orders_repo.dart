import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/data/models/get_orders_resturant_response.dart';

class GetOrdersRepo {
  final ApiServices apiServices;

  GetOrdersRepo({required this.apiServices});

  Future<ApiResult<GetOrdersResturantResponse>> getOrdersResturant() async {
    try {
      final res = await apiServices.getOrdersResturant({});
      return ApiResult.success(res);
    } catch (e) {
      print("❌ Errrrrror$e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
