import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/features/deliveryAgent/data/models/get_accepted_orders.dart';
import 'package:delveria/features/deliveryAgent/data/models/get_not_accepted_order_agent.dart';
import 'package:delveria/features/deliveryAgent/data/repo/agent_ordrs_repo.dart';
import 'package:delveria/features/deliveryAgent/logic/cubit/agent_orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgentOrdersCubit extends Cubit<AgentOrdersState> {
  final AgentOrdrsRepo agentOrdrsRepo;
  AgentOrdersCubit(this.agentOrdrsRepo) : super(AgentOrdersState.initial());
  List<AgentOrder> agentOrders = [];
  List<AcceptedOrder> acceptedOrders = [];
  void getCurrentOrdersAgent({
    String? date,
    String? startDate,
    String? endDate,
    String? paymentType,
    String? orderType,
  }) async {
    emit(AgentOrdersState.loading());
    try {
      final response = await agentOrdrsRepo.getCurrentOrdersForAgent(
        date: date,
        startDate: startDate,
        endDate: endDate,
        paymentType: paymentType,
        orderType: orderType,
      );
      response.when(
        success: (currentAgentRes) {
          // Filter out orders that have been accepted by any delivery agent
          agentOrders = currentAgentRes.orders.where((order) {
            final isAccepted = order.acceptanceStatus?.acceptedByDeliveryAgents?.isNotEmpty ?? false;
            return !isAccepted;
          }).toList();
          print("ssssssss$agentOrders");
          emit(AgentOrdersState.success(currentAgentRes));
        },
        failure: (error) => emit(AgentOrdersState.fail(error)),
      );
    } catch (e) {
      emit(AgentOrdersState.fail(ApiErrorHandler.handle(e)));
    }
  }

  void getAcceptedOrders({
    String? status,
    String? date,
    String? startDate,
    String? endDate,
    String? paymentType,
  }) async {
    emit(AgentOrdersState.getAcceptOrderLoading());
    try {
      final response = await agentOrdrsRepo.getAcceptedOrders(
        status: status,
        date: date,
        startDate: startDate,
        endDate: endDate,
        paymentType: paymentType,
      );
      response.when(
        success: (getAcceptedOrdersRes) {
          acceptedOrders = getAcceptedOrdersRes.orders;
          print("ssssssss$acceptedOrders");
          emit(AgentOrdersState.getAcceptOrderSuccess(acceptedOrders));
        },
        failure: (error) => emit(AgentOrdersState.getAcceptOrderFail(error)),
      );
    } catch (e) {
      emit(AgentOrdersState.getAcceptOrderFail(ApiErrorHandler.handle(e)));
    }
  }

  void acceptOrder({required String orderId}) async {
    emit(AgentOrdersState.acceptOrderLoading());
    try {
      final response = await agentOrdrsRepo.acceptOrder(orderId: orderId);
      response.when(
        success: (acceptOrderRes) {
          emit(AgentOrdersState.acceptOrderSuccess(acceptOrderRes));
        },
        failure: (error) => emit(AgentOrdersState.acceptOrderFail(error)),
      );
    } catch (e) {
      emit(AgentOrdersState.acceptOrderFail(ApiErrorHandler.handle(e)));
    }
  }
  void acceptOrderRestuarnt({required String orderId,required String subOrderId}) async {
    emit(AgentOrdersState.acceptOrderResLoading());
    try {
      final response = await agentOrdrsRepo.acceptOrderRestaurant(orderId: orderId, subOrderId: subOrderId);
      response.when(
        success: (acceptOrderRes) {
          emit(AgentOrdersState.acceptOrderResSuccess(acceptOrderRes));
        },
        failure: (error) => emit(AgentOrdersState.acceptOrderResFail(error)),
      );
    } catch (e) {
      emit(AgentOrdersState.acceptOrderResFail(ApiErrorHandler.handle(e)));
    }
  }
  void readyForPickUp({required String orderId, required String subOrderId}) async {
    emit(AgentOrdersState.readyForPickUpLoading());
    try {
      final response = await agentOrdrsRepo.readyForPickup(orderId: orderId, subOrderId: subOrderId);
      response.when(
        success: (acceptOrderRes) {
          emit(AgentOrdersState.readyForPickUpSuccess(acceptOrderRes));
        },
        failure: (error) => emit(AgentOrdersState.readyForPickUpFail(error)),
      );
    } catch (e) {
      emit(AgentOrdersState.readyForPickUpFail(ApiErrorHandler.handle(e)));
    }
  }

  void updateOrderStatusAgent({
    required String orderId,
    required Map<String, dynamic> body,
  }) async {
    emit(AgentOrdersState.updateOrderStatusAgentLoading());
    try {
      final response = await agentOrdrsRepo.updateAgentOrderStatus(
        orderId: orderId,
        body: body,
      );
      response.when(
        success: (updateStatusOrderAgentRes) {
          emit(
            AgentOrdersState.updateOrderStatusAgentSuccess(
              updateStatusOrderAgentRes,
            ),
          );
        },
        failure:
            (error) => emit(AgentOrdersState.updateOrderStatusAgentFail(error)),
      );
    } catch (e) {
      emit(
        AgentOrdersState.updateOrderStatusAgentFail(ApiErrorHandler.handle(e)),
      );
    }
  }

  void updateAgentLocation({
    required double latitude,
    required double longitude,
  }) async {
    // No loading state for location updates (silent background operation)
    try {
      final response = await agentOrdrsRepo.updateAgentLocation(
        latitude: latitude,
        longitude: longitude,
      );
      response.when(
        success: (locationRes) {
          // Location updated successfully (silent)
          print('Location updated: $latitude, $longitude');
        },
        failure: (error) {
          // Log error but don't emit state (silent failure)
          print('Error updating location: ${error.message}');
        },
      );
    } catch (e) {
      // Log error but don't emit state (silent failure)
      print('Error updating location: $e');
    }
  }
}
