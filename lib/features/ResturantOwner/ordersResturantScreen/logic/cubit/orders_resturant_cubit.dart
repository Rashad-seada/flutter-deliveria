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

 Future <void> getOrdersRestuant() async {
    emit(OrdersResturantState.loading());
    try {
      final response = await getOrdersRepo.getOrdersResturant();
      response.when(
        success: (ordersRes) {
          ordersResturant = ordersRes.orders ?? [];
          emit(OrdersResturantState.success(ordersRes));
        },
        failure: (error) => emit(OrdersResturantState.fail(error)),
      );
    } catch (e) {
      emit(OrdersResturantState.fail(ApiErrorHandler.handle(e)));
    }
  }
}
