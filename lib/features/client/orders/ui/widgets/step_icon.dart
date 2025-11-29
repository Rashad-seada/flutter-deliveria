import 'package:delveria/features/client/orders/ui/widgets/get_colors.dart';
import 'package:flutter/material.dart';

class StepIcon extends StatelessWidget {
  const StepIcon({
    super.key,
    required this.isCompleted,
    required this.isCurrent,
  });

  final bool isCompleted;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: getStepColor(isCompleted: isCompleted, isCurrent: isCurrent),
      ),
      child:
          isCompleted
              ? const Icon(Icons.check, color: Colors.white, size: 16)
              : isCurrent
              ? const Icon(
                Icons.wb_sunny_outlined,
                color: Colors.white,
                size: 16,
              )
              : null,
    );
  }
}
