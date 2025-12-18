import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/deliveryAgent/data/models/accept_orders_model.dart';
import 'package:delveria/features/deliveryAgent/data/models/get_accepted_orders.dart';
import 'package:delveria/features/deliveryAgent/data/models/get_not_accepted_order_agent.dart';
import 'package:delveria/features/deliveryAgent/data/models/update_agent_order_status_response.dart';
import 'package:delveria/features/deliveryAgent/data/models/update_location_response.dart';

class AgentOrdrsRepo {
  final ApiServices apiServices;

  AgentOrdrsRepo({required this.apiServices});

  Future<ApiResult<GetNotAcceptedOrderAgentResponse>>
  getCurrentOrdersForAgent() async {
    try {
      final res = await apiServices.getCurrentOrders({});

      print(res);
      return ApiResult.success(res);
    } catch (e) {
      print('Error in comingOrdersForAgent: $e');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
  Future<ApiResult<GetAcceptedOrdersResponse>>
  getAcceptedOrders() async {
    try {
      final res = await apiServices.getAcceptedOrders({});
      return ApiResult.success(res);
    } catch (e) {
      print('Error in getCurrentOrdersForAgent: $e');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
  Future<ApiResult<AcceptOrdersModel>>
  acceptOrder({required String orderId}) async {
    try {
      final res = await apiServices.acceptOrder(orderId,{});
      return ApiResult.success(res);
    } catch (e) {
      print('Error in getCurrentOrdersForAgent: $e');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
  Future<ApiResult<AcceptOrdersModel>>
  acceptOrderRestaurant({required String orderId, required String subOrderId}) async {
    try {
      final res = await apiServices.acceptOrderRestaurant(orderId, subOrderId, {});
      return ApiResult.success(res);
    } catch (e) {
      print('Error in accept order restaurnat : $e');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
  Future<ApiResult<AcceptOrdersModel>>
  readyForPickup({required String orderId, required String subOrderId}) async {
    try {
      final res = await apiServices.readyForPickUp(orderId, subOrderId, {});
      return ApiResult.success(res);
    } catch (e) {
      print('Error in accept order restaurnat : $e');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
  Future<ApiResult<UpdateAgentOrderStatusResponse>>
  updateAgentOrderStatus({required String orderId , required Map<String,dynamic> body}) async {
    try {
      final res = await apiServices.updateAgentOrderStatus(orderId,body);
      return ApiResult.success(res);
    } catch (e) {
      print('Error in update status : $e');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<UpdateLocationResponse>>
  updateAgentLocation({required double latitude, required double longitude}) async {
    try {
      final body = {
        'latitude': latitude,
        'longitude': longitude,
      };
      final res = await apiServices.updateAgentLocation(body);
      return ApiResult.success(res);
    } catch (e) {
      print('Error in update location : $e');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
