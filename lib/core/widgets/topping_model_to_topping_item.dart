import 'package:delveria/features/ResturantOwner/menu/ui/widgets/toppings_selection_widget.dart';
import 'package:flutter/material.dart';

ToppingItem toppingModelToToppingItem(dynamic e) {
  if (e is ToppingItem) return e;

  String topping = '';
  String price = '';
  if (e is Map) {
    topping = e['topping']?.toString() ?? '';
    price = e['price']?.toString() ?? '';
  } else {
    try {
      topping = e.topping?.toString() ?? '';
      price = e.price?.toString() ?? '';
    } catch (_) {}
  }
  return ToppingItem(
    nameController: TextEditingController(text: topping),
    priceController: TextEditingController(text: price),
  );
}
