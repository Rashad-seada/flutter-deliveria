import 'package:delveria/features/client/orders/ui/widgets/get_colors.dart';
import 'package:flutter/material.dart';

class StepIcon extends StatelessWidget {
  const StepIcon({
    super.key,
    required this.isCompleted,
    required this.isCurrent,
    required this.stepIndex,
  });

  final bool isCompleted;
  final bool isCurrent;
  final int stepIndex;

  @override
  Widget build(BuildContext context) {
    final color = getStepColor(isCompleted: isCompleted, isCurrent: isCurrent);
    final iconData = getStepIconData(stepIndex);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isCurrent ? 44 : 36,
      height: isCurrent ? 44 : 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted || isCurrent ? color : Colors.white,
        border: Border.all(
          color: color,
          width: isCurrent ? 3 : 2,
        ),
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ]
            : isCompleted
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.2),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
      ),
      child: Icon(
        isCompleted ? Icons.check_rounded : iconData,
        color: isCompleted || isCurrent ? Colors.white : const Color(0xFFBDBDBD),
        size: isCurrent ? 22 : 18,
      ),
    );
  }
}
