import 'package:delveria/features/client/orders/logic/cubit/order_state.dart';
import 'package:flutter/material.dart';

class AnimatedBuilderForDashLine extends StatelessWidget {
  const AnimatedBuilderForDashLine({
    super.key,
    required this.isCompleted,
    required this.isCurrent,
    required this.state,
  });

  final bool isCompleted;
  final bool isCurrent;
  final OrderState state;

  @override
  Widget build(BuildContext context) {
    final color = isCompleted
        ? const Color(0xFF2ECC71)
        : isCurrent
            ? const Color(0xFFFF9800)
            : const Color(0xFFE0E0E0);

    return AnimatedBuilder(
      animation: state.animationController,
      builder: (context, child) {
        return Container(
          width: 3,
          margin: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: isCompleted
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF2ECC71),
                      Color(0xFF27AE60),
                    ],
                  )
                : isCurrent
                    ? LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFFFF9800),
                          const Color(0xFFFF9800)
                              .withOpacity(state.animationController.value),
                        ],
                      )
                    : null,
            color: (!isCompleted && !isCurrent) ? color : null,
          ),
        );
      },
    );
  }
}
