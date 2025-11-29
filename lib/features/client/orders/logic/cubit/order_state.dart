import 'dart:async';

import 'package:delveria/features/client/orders/data/models/order_step.dart';
import 'package:flutter/material.dart';

class OrderState {
  late AnimationController animationController;
  final Timer? timer;
  final int currentStep;

  late List<OrderStep> orderSteps;
  late List<OrderStep> orderStepsArabic;
  OrderState({
    required this.animationController,
    required this.timer,
    required this.currentStep,
    required this.orderSteps,
    required this.orderStepsArabic,
  });

  OrderState copyWith({
    AnimationController? animationController,
    Timer? timer,
    int? currentStep,

    List<OrderStep>? orderSteps,
    List<OrderStep>? orderStepsArabic,
  }) {
    return OrderState(
      animationController: animationController ?? this.animationController,
      timer: timer ?? this.timer,
      currentStep: currentStep ?? this.currentStep,
      orderSteps: orderSteps ?? this.orderSteps,
      orderStepsArabic: orderStepsArabic??this.orderStepsArabic
    );
  }
}
