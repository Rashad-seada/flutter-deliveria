import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/features/admin/deliveryAgent/data/models/all_orders_model.dart';
import 'package:delveria/features/admin/deliveryAgent/data/models/create_agent_request.dart';
import 'package:delveria/features/admin/deliveryAgent/data/models/each_agent_order_model.dart';
import 'package:delveria/features/admin/deliveryAgent/data/models/get_delivery_agent_response.dart';
import 'package:delveria/features/admin/deliveryAgent/data/models/order_details_model.dart';
import 'package:delveria/features/admin/deliveryAgent/data/repo/delivery_agent_admin_repo.dart';
import 'package:delveria/features/admin/deliveryAgent/logic/cubit/agents_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgentsCubit extends Cubit<AgentsState> {
  final DeliveryAgentAdminRepo agentAdminRepo;
  AgentsCubit(this.agentAdminRepo) : super(AgentsState.initial());
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();
  List<AgentModel> allAgents = [];
  List<OrderModel> acceptedOrders = [];
  List<OrderModel> notAcceptedOrders = [];
  List<EachAgentOrderModel> agentOrders = [];
  OrderDetailsModel? orderDetailsModel;
  List<String?>? deliveryIds= [];

  void getAllAgents() async {
    emit(AgentsState.loading());
    try {
      final response = await agentAdminRepo.getAllAgents();
      response.when(
        success: (agentRes) {
          allAgents = agentRes.agents;
          emit(AgentsState.success(agentRes));
        },
        failure: (error) => emit(AgentsState.fail(error)),
      );
    } catch (e) {
      emit(AgentsState.fail(ApiErrorHandler.handle(e)));
    }
  }

  void createAgent() async {
    emit(AgentsState.createLoading());
    try {
      final response = await agentAdminRepo.createAgents(
        createAgentReq: CreateAgentRequest(
          name: nameController.text,
          phone: phoneController.text,
          password: passwordContoller.text,
        ),
      );
      response.when(
        success: (agentRes) {
          emit(AgentsState.createSuccess(agentRes));
        },
        failure: (error) => emit(AgentsState.createFail(error)),
      );
    } catch (e) {
      emit(AgentsState.createFail(ApiErrorHandler.handle(e)));
    }
  }

  void banAgent({required String agentId}) async {
    emit(AgentsState.banAgentLoading());
    try {
      final response = await agentAdminRepo.banAgent(agentId: agentId);
      response.when(
        success: (banRes) {
          emit(AgentsState.banAgentSuccess(banRes));
        },
        failure: (error) => emit(AgentsState.banAgentFail(error)),
      );
    } catch (e) {
      emit(AgentsState.banAgentFail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> getAllOrders({
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
    emit(AgentsState.getAllOrdersLoading());
    try {
      final response = await agentAdminRepo.getAllOrders(
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
      response.when(
        success: (data) {
          deliveryIds = data.orders?.map((e) => e.deliveryId).toList();

          acceptedOrders =
              data.orders
                  ?.where(
                    (e) =>
                        e.deliveryId != null &&
                        e.deliveryId.toString().trim().isNotEmpty,
                  )
                  .toList() ??
              [];
          // Not accepted: no deliveryId and not canceled
          notAcceptedOrders =
              data.orders
                  ?.where(
                    (e) =>
                        (e.deliveryId == null ||
                            e.deliveryId.toString().trim().isEmpty) &&
                        e.status != "Canceled",
                  )
                  .toList() ??
              [];
          emit(AgentsState.getAllOrdersSuccess(data));
        },
        failure: (error) => emit(AgentsState.getAllOrdersFail(error)),
      );
    } catch (e) {
      emit(AgentsState.getAllOrdersFail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> getAllOrdersEachAgent(String id, {String? status}) async {
    emit(AgentsState.getAllOrdersEachAgentLoading());
    try {
      final response = await agentAdminRepo.getAllOrdersForEachAgent(id: id, status: status);
      response.when(
        success: (data) {
          agentOrders = data.orders;
          emit(AgentsState.getAllOrdersEachAgentSuccess(data));
        },
        failure: (error) => emit(AgentsState.getAllOrdersEachAgentFail(error)),
      );
    } catch (e) {
      emit(AgentsState.getAllOrdersEachAgentFail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> getEachOrderDeatils(String id) async {
    emit(AgentsState.getEachOrderDetailsLoading());

    try {
      final response = await agentAdminRepo.getEachOrderDetails(id: id);
      response.when(
        success: (data) {
          orderDetailsModel = data.order;
          emit(AgentsState.getEachOrderDetailsSuccess(data));
        },
        failure: (error) => emit(AgentsState.getEachOrderDetailsFail(error)),
      );
    } catch (e) {
      emit(AgentsState.getEachOrderDetailsFail(ApiErrorHandler.handle(e)));
    }
  }
}
