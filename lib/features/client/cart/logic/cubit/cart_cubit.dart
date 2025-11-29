import 'package:delveria/features/client/cart/logic/cubit/cart_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit()
    : super(
        CartState(
          quantity: 1,
          itemPrice: 320,
          applyCupone: false,
          couponeController: TextEditingController(),
        ),
      );

  void toggleApplyCupon() {
    if (state.applyCupone) {
      state.couponeController.clear();
    }
    emit(state.copyWith(applyCupone: !state.applyCupone));
  }

  void increaseQuantity() {
    emit(state.copyWith(quantity: state.quantity + 1));
  }
  void decreaseQuantity() {
    if (state.quantity>1) {
          emit(state.copyWith(quantity: state.quantity - 1));

    }
  }

  @override
  Future<void> close() {
    state.couponeController.dispose();
    return super.close();
  }
}
