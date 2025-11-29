import 'package:flutter/material.dart';

class PickDateState {
  final TextEditingController couponCodeController;
  final TextEditingController discountController;
  final TextEditingController minPurchaseController;

  DateTime? selectedExpDate;
  final TextEditingController expDateController;
  List<String>? couponeState;

  String? selectedStatus;
  List<bool>? isValid;

  PickDateState({
    this.couponeState,
    this.selectedExpDate,
    this.selectedStatus,
    required this.couponCodeController,
    required this.discountController,
    required this.minPurchaseController,
    required this.expDateController,
    this.isValid,
  });

  PickDateState copyWith({
    TextEditingController? couponCodeController,
    TextEditingController? discountController,
    TextEditingController? minPurchaseController,

    DateTime? selectedExpDate,
    TextEditingController? expDateController,
    List<bool>? isValid,
    List<String>? couponeState,
    String? selectedStatus,
  }) {
    return PickDateState(
      couponeState: couponeState??this.couponeState,
      isValid: isValid ?? this.isValid,
      couponCodeController: couponCodeController ?? this.couponCodeController,
      discountController: discountController ?? this.discountController,
      minPurchaseController:
          minPurchaseController ?? this.minPurchaseController,
      expDateController: expDateController ?? this.expDateController,
      selectedExpDate: selectedExpDate ?? this.selectedExpDate,
      selectedStatus: selectedStatus ?? this.selectedStatus,
    );
  }
}
