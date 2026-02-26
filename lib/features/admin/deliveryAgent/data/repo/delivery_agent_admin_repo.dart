import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/admin/deliveryAgent/data/models/all_orders_model.dart';
import 'package:delveria/features/admin/deliveryAgent/data/models/create_agent_request.dart';
import 'package:delveria/features/admin/deliveryAgent/data/models/create_agnet_response.dart';
import 'package:delveria/features/admin/deliveryAgent/data/models/each_agent_order_model.dart';
import 'package:delveria/features/admin/deliveryAgent/data/models/get_delivery_agent_response.dart';
import 'package:delveria/features/admin/deliveryAgent/data/models/order_details_model.dart';
import 'package:delveria/features/admin/users/data/models/ban_user_response.dart';

class DeliveryAgentAdminRepo {
  final ApiServices apiServices;

  DeliveryAgentAdminRepo({required this.apiServices});

  Future<ApiResult<GetDeliveryAgentResponse>> getAllAgents() async {
    try {
      final res = await apiServices.getAllAgents();
      return ApiResult.success(res);
    } catch (e) {
      print("agent error $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<CreateAgentResponse>> createAgents({
    required CreateAgentRequest createAgentReq,
  }) async {
    try {
      final res = await apiServices.createAgent(createAgentReq);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<BanUserResponse>> banAgent({required String agentId}) async {
    try {
      final res = await apiServices.banAgent({}, agentId);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<AllOrdersModel>> getAllOrders({
    String? date,
    String? startDate,
    String? endDate,
    String? paymentType,
    String? status,
    String? restaurantId,
    String? userId,
    String? agentId,
    String? orderType,
    String? deliveryType,
  }) async {
    try {
      final res = await apiServices.getAllOrders(
        {},
        date: date,
        startDate: startDate,
        endDate: endDate,
        paymentType: paymentType,
        status: status,
        restaurantId: restaurantId,
        userId: userId,
        agentId: agentId,
        orderType: orderType,
        deliveryType: deliveryType,
      );
      return ApiResult.success(res);
    } catch (e) {
      print("eee all $e");

      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<EachAgentOrderResponse>> getAllOrdersForEachAgent({
    required String id,
    String? status,
  }) async {
    try {
      final res = await apiServices.getAllOrdersForEachAgent({}, id, status);
      // print(res.);
      return ApiResult.success(res);
    } catch (e) {
      print("eee order $e");

      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<OrderDetailsResponse>> getEachOrderDetails({
    required String id,
  }) async {
    try {
      final res = await apiServices.getOrderDetails({}, id);
      return ApiResult.success(res);
    } catch (e) {
      print("eee $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
