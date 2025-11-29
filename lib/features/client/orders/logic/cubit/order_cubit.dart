import 'dart:async';

import 'package:delveria/features/client/orders/data/models/order_step.dart';
import 'package:delveria/features/client/orders/logic/cubit/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Order status states:
/// - Preparing
/// - Accepted
/// - Ready for Pickup
/// - On the Way
/// - Delivered
class OrderCubit extends Cubit<OrderState> {
  static const List<String> orderStates = [
    "Preparing",
    "Accepted",
    "Ready for pickup",
    "On the Way",
    "DELIVERED",
  ];

  static const List<String> orderStatesArabic = [
    "جاري التحضير",
    "تم القبول",
    "جاهز للاستلام",
    "في الطريق",
    "تم التوصيل",
  ];

  OrderCubit({
    required AnimationController animationController,
    Timer? timer,
    int currentStep = 0,
    List<OrderStep>? orderSteps,
    List<OrderStep>? orderStepsArabic,
  }) : super(
          OrderState(
            animationController: animationController,
            timer: timer,
            currentStep: currentStep,
            orderSteps: orderSteps ??
                [
                  OrderStep(title: orderStates[0], time: "", isCompleted: false),
                  OrderStep(title: orderStates[1], time: "", isCompleted: false),
                  OrderStep(title: orderStates[2], time: "", isCompleted: false),
                  OrderStep(title: orderStates[3], time: "", isCompleted: false),
                  OrderStep(title: orderStates[4], time: "", isCompleted: false),
                ],
            orderStepsArabic: orderStepsArabic ??
                [
                  OrderStep(title: orderStatesArabic[0], time: "", isCompleted: false),
                  OrderStep(title: orderStatesArabic[1], time: "", isCompleted: false),
                  OrderStep(title: orderStatesArabic[2], time: "", isCompleted: false),
                  OrderStep(title: orderStatesArabic[3], time: "", isCompleted: false),
                  OrderStep(title: orderStatesArabic[4], time: "", isCompleted: false),
                ],
          ),
        );

  /// Update the order status by status string (e.g. "Preparing", "Accepted", "On the Way", "Delivered")
  void updateOrderStatus(String status) {
    int stepIndex = _getStepIndexFromStatus(status);
    _updateToStep(stepIndex);
  }

  int _getStepIndexFromStatus(String status) {
    final normalized = status.trim().toLowerCase();
    if (normalized == "preparing") return 0;
    if (normalized == "accepted") return 1;
    if (normalized == "ready for pickup" || normalized == "ready for pick up" || normalized == "ready_for_pickup") return 2;
    if (normalized == "on the way" || normalized == "on_the_way") return 3;
    if (normalized == "delivered") return 4;
    // fallback: try to match by partial
    for (int i = 0; i < orderStates.length; i++) {
      if (orderStates[i].toLowerCase() == normalized) return i;
    }
    return 0;
  }

  /// Update all steps up to [targetStep] as completed, others as not completed
  void _updateToStep(int targetStep) {
    List<OrderStep> updatedSteps = List.from(state.orderSteps);
    List<OrderStep> updatedStepsArabic = List.from(state.orderStepsArabic);

    for (int i = 0; i < updatedSteps.length; i++) {
      if (i <= targetStep) {
        updatedSteps[i] = updatedSteps[i].copyWith(
          isCompleted: true,
          time: _getCurrentTimestamp(),
        );
        updatedStepsArabic[i] = updatedStepsArabic[i].copyWith(
          isCompleted: true,
          time: _getCurrentTimestamp(),
        );
      } else {
        updatedSteps[i] = updatedSteps[i].copyWith(
          isCompleted: false,
          time: "",
        );
        updatedStepsArabic[i] = updatedStepsArabic[i].copyWith(
          isCompleted: false,
          time: "",
        );
      }
    }

    emit(state.copyWith(
      currentStep: targetStep,
      orderSteps: updatedSteps,
      orderStepsArabic: updatedStepsArabic,
    ));
  }

  String _getCurrentTimestamp() {
    final now = DateTime.now();
    return "${now.day} ${_getMonthName(now.month)} ${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}";
  }

  String _getMonthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month];
  }

  /// Placeholder for checking order status from backend
  Future<void> checkOrderStatus(String orderId) async {
    try {} catch (e) {
      print("Error checking order status: $e");
    }
  }

  /// Move to the next step if possible
  void nextStep() {
    if (state.currentStep < state.orderSteps.length - 1) {
      _updateToStep(state.currentStep + 1);
    }
  }

  /// Move to the previous step if possible
  void previousStep() {
    if (state.currentStep > 0) {
      _updateToStep(state.currentStep - 1);
    }
  }

  /// Reset to the first step ("Preparing")
  void resetSteps() {
    _updateToStep(0);
  }

  /// Set custom order steps (overrides default states)
  void setOrderSteps(List<OrderStep> steps, {List<OrderStep>? stepsArabic}) {
    emit(state.copyWith(
      orderSteps: steps,
      orderStepsArabic: stepsArabic ?? state.orderStepsArabic,
      currentStep: 0,
    ));
  }

  void setAnimationController(AnimationController controller) {
    emit(state.copyWith(animationController: controller));
  }

  void setTimer(Timer? timer) {
    emit(state.copyWith(timer: timer));
  }
}
