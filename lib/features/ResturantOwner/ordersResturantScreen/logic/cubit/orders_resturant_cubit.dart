import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/data/models/get_orders_resturant_response.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/data/repo/get_orders_repo.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/logic/cubit/orders_resturant_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersResturantCubit extends Cubit<OrdersResturantState> {
  final GetOrdersRepo getOrdersRepo;
  OrdersResturantCubit(this.getOrdersRepo)
    : super(OrdersResturantState.initial());

  List<OrderResturantModel> ordersResturant = [];

  Future <void> getOrdersRestaurant() async {
    if (!isClosed) emit(OrdersResturantState.loading());
    try {
      final response = await getOrdersRepo.getOrdersResturant();
      if (isClosed) return; 
      response.when(
        success: (ordersRes) {
          ordersResturant = ordersRes.orders ?? [];
          if (!isClosed) emit(OrdersResturantState.success(ordersRes));
        },
        failure: (error) {
          if (!isClosed) emit(OrdersResturantState.fail(error));
        },
      );
    } catch (e) {
      if (!isClosed) emit(OrdersResturantState.fail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> acceptOrder({required String orderId, required String subOrderId}) async {
    if (!isClosed) emit(OrdersResturantState.acceptOrderLoading());
    try {
      final response = await getOrdersRepo.acceptOrder(orderId: orderId, subOrderId: subOrderId);
      if (isClosed) return;
      response.when(
        success: (acceptRes) {
          if (!isClosed) emit(OrdersResturantState.acceptOrderSuccess(acceptRes));
          // Refresh orders list after accepting
          getOrdersRestaurant();
        },
        failure: (error) {
          if (!isClosed) emit(OrdersResturantState.acceptOrderFail(error));
        },
      );
    } catch (e) {
      if (!isClosed) emit(OrdersResturantState.acceptOrderFail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> markReady({required String orderId, required String subOrderId}) async {
    if (!isClosed) emit(OrdersResturantState.markReadyLoading());
    try {
      final response = await getOrdersRepo.markReady(orderId: orderId, subOrderId: subOrderId);
      if (isClosed) return;
      response.when(
        success: (readyRes) {
          if (!isClosed) emit(OrdersResturantState.markReadySuccess(readyRes));
          // Refresh orders list after marking ready
          getOrdersRestaurant();
        },
        failure: (error) {
          if (!isClosed) emit(OrdersResturantState.markReadyFail(error));
        },
      );
    } catch (e) {
      if (!isClosed) emit(OrdersResturantState.markReadyFail(ApiErrorHandler.handle(e)));
    }
  }
}
