import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/client/orders/logic/cubit/order_state.dart';
import 'package:delveria/features/client/orders/ui/widgets/dashed_line_painter.dart';
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
    return AnimatedBuilder(
      animation: state.animationController,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(2, 70),
          painter: DashedLinePainter(
            color:
                isCompleted
                    ? Colors.green
                    : isCurrent
                    ? AppColors.stepsGrey
                    : Colors.grey[300]!,
            animationValue: state.animationController.value,
          ),
        );
      },
    );
  }
}
