import 'package:flutter/widgets.dart';

class CartState {
  final bool applyCupone;
  final TextEditingController couponeController;
  final  int quantity;
 final double itemPrice;

  CartState( {required this.applyCupone, required this.couponeController, required this.quantity,
    required this.itemPrice,
  });
  CartState copyWith({
    bool? applyCupone,
    TextEditingController? couponeController,
    int ? quantity, 
    double? itemPrice
  }) {
    return CartState(
      quantity: quantity??this.quantity,
      itemPrice: itemPrice??this.itemPrice,
      applyCupone: applyCupone ?? this.applyCupone,
      couponeController: couponeController ?? this.couponeController,
    );
  }
}
