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
    "Waiting for Approval",
    "Accepted",
    "Approved / Preparing",
    "Ready for Delivery",
    "Pick up",
    "On the way",
    "Delivered",
    "Completed",
  ];

  static const List<String> orderStatesArabic = [
    "في انتظار الموافقة",
    "تم القبول",
    "تمت الموافقة / جاري التحضير",
    "جاهز للتوصيل",
    "استلام",
    "في الطريق",
    "تم التوصيل",
    "مكتمل",
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
                  for (int i = 0; i < orderStates.length; i++)
                    OrderStep(title: orderStates[i], time: "", isCompleted: false),
                ],
            orderStepsArabic: orderStepsArabic ??
                [
                  for (int i = 0; i < orderStatesArabic.length; i++)
                    OrderStep(title: orderStatesArabic[i], time: "", isCompleted: false),
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

    // Step 0: Waiting for Approval
    if (normalized == "waiting for approval" ||
        normalized == "waiting_for_approval" ||
        normalized == "pending") return 0;

    // Step 1: Accepted
    if (normalized == "accepted") return 1;

    // Step 2: Approved / Preparing
    if (normalized == "approved / preparing" ||
        normalized == "approved/preparing" ||
        normalized == "approved_preparing" ||
        normalized == "preparing" ||
        normalized == "approved") return 2;

    // Step 3: Ready for Delivery
    if (normalized == "ready for delivery" ||
        normalized == "ready_for_delivery" ||
        normalized == "ready for pickup" ||
        normalized == "ready_for_pickup" ||
        normalized == "ready") return 3;

    // Step 4: Pick up
    if (normalized == "pick up" ||
        normalized == "pick_up" ||
        normalized == "pickup" ||
        normalized == "picked up" ||
        normalized == "picked_up") return 4;

    // Step 5: On the way (includes "Out for Delivery" from backend)
    if (normalized == "on the way" ||
        normalized == "on_the_way" ||
        normalized == "out for delivery" ||
        normalized == "out_for_delivery" ||
        normalized == "in transit" ||
        normalized == "in_transit" ||
        normalized == "shipped") return 5;

    // Step 6: Delivered
    if (normalized == "delivered") return 6;

    // Step 7: Completed
    if (normalized == "completed") return 7;

    // fallback: try to match by partial
    for (int i = 0; i < orderStates.length; i++) {
      if (orderStates[i].toLowerCase() == normalized) return i;
    }

    // Second fallback: check if status contains any known keyword
    if (normalized.contains("deliver") && !normalized.contains("ready")) return 6;
    if (normalized.contains("way") || normalized.contains("transit") || normalized.contains("out for")) return 5;
    if (normalized.contains("pick")) return 4;
    if (normalized.contains("ready")) return 3;
    if (normalized.contains("prepar")) return 2;
    if (normalized.contains("accept") || normalized.contains("approv")) return 1;
    if (normalized.contains("complet")) return 7;

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
