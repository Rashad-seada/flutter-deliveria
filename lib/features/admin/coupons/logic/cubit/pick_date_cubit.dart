import 'package:delveria/core/helper/lists.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/pick_date_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PickDateCubit extends Cubit<PickDateState> {
  PickDateCubit()
    : super(
        PickDateState(
          couponCodeController: TextEditingController(),
          discountController: TextEditingController(),
          minPurchaseController: TextEditingController(),
          expDateController: TextEditingController(),
          isValid: List.generate(AppLists.coupons.length, (index) => true),
          couponeState: List.generate(AppLists.coupons.length, (index) => AppLists.coupons[index].isActive ? 'Active' : 'Expired'),
        ),
      );

  // Fix: Accept index to update the correct coupon's validity
  void expireTheCoupon({
    required int index,
    required bool newVal,
    required String newState,
  }) {
    final List<bool> valid = List<bool>.from(state.isValid ?? []);
    final List<String> couponState = List<String>.from(
      state.couponeState ?? [],
    );
    if (index >= 0 && index < valid.length) {
      valid[index] = newVal;
      couponState[index] = newState;
      emit(state.copyWith(isValid: valid , couponeState: couponState));
    }
  }

  Future<void> pickExpDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: state.selectedExpDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      state.expDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      emit(state.copyWith(selectedExpDate: picked));
    }
  }

  void setInitialDate(DateTime date) {
    state.expDateController.text = DateFormat('yyyy-MM-dd').format(date);
    emit(state.copyWith(selectedExpDate: date));
  }
  
  void resetDate() {
    state.expDateController.clear();
    emit(state.copyWith(selectedExpDate: null));
  }

  @override
  Future<void> close() {
    state.couponCodeController.dispose();
    state.discountController.dispose();
    state.minPurchaseController.dispose();
    state.expDateController.dispose();
    return super.close();
  }
}
