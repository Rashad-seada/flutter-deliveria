import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/features/client/orders/data/models/get_orders_model.dart';
import 'package:delveria/features/client/orders/data/repo/orders_repo.dart';
import 'package:delveria/features/client/orders/logic/cubit/get_orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetOrdersCubit extends Cubit<GetOrdersState> {
  final OrdersRepo ordersRepo;
  List<OrderModel> orders = [];
  String orderStatus = "";
  GetOrdersCubit(this.ordersRepo) : super(GetOrdersState.initial());

  void getOrdersUser() async {
    emit(GetOrdersState.loading());
    try {
      final response = await ordersRepo.getOrders();
      response.when(
        success: (getOrdersRes) {
          orders = getOrdersRes.orders ?? [];
          orderStatus = getOrdersRes.orders?.first.status ?? "";
          emit(GetOrdersState.success(getOrdersRes));
        },
        failure: (error) => emit(GetOrdersState.fail(error)),
      );
    } catch (e) {
      emit(GetOrdersState.fail(ApiErrorHandler.handle(e)));
    }
  }

  void reorder({required String orderId}) async {
    emit(GetOrdersState.reorderLoading());
    try {
      final response = await ordersRepo.reorder(orderId: orderId);
      response.when(
        success: (getOrdersRes) {
          emit(GetOrdersState.reorderSuccess(getOrdersRes));
        },
        failure: (error) => emit(GetOrdersState.reorderFail(error)),
      );
    } catch (e) {
      emit(GetOrdersState.reorderFail(ApiErrorHandler.handle(e)));
    }
  }
}
