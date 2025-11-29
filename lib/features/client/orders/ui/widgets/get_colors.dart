import 'package:delveria/core/theme/color.dart';
import 'package:flutter/material.dart';

Color getStepColor({required bool isCompleted, required bool isCurrent}) {
  if (isCompleted) return Colors.green;
  if (isCurrent) return AppColors.grey.withValues(alpha: .5);
  return Colors.grey[400]!;
}

Color getStepBgColor({required bool isCompleted, required bool isCurrent}) {
  if (isCompleted) return AppColors.grediantGreen;
  if (isCurrent) return AppColors.stepsGrey;
  return Colors.white;
}

Color getStepBorderColor({required bool isCompleted, required bool isCurrent}) {
  if (isCompleted) return Colors.green[100]!;
  if (isCurrent) return Colors.orange[100]!;
  return Colors.grey[200]!;
}
