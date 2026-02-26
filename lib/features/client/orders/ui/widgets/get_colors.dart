import 'package:delveria/core/theme/color.dart';
import 'package:flutter/material.dart';

Color getStepColor({required bool isCompleted, required bool isCurrent}) {
  if (isCompleted) return const Color(0xFF2ECC71);
  if (isCurrent) return const Color(0xFFFF9800);
  return const Color(0xFFE0E0E0);
}

Color getStepBgColor({required bool isCompleted, required bool isCurrent}) {
  if (isCompleted) return const Color(0xFFE8F8E8);
  if (isCurrent) return const Color(0xFFFFF3E0);
  return const Color(0xFFF5F5F5);
}

Color getStepBorderColor({required bool isCompleted, required bool isCurrent}) {
  if (isCompleted) return const Color(0xFF2ECC71).withOpacity(0.3);
  if (isCurrent) return const Color(0xFFFF9800).withOpacity(0.3);
  return const Color(0xFFE0E0E0);
}

Color getStepTextColor({required bool isCompleted, required bool isCurrent}) {
  if (isCompleted) return const Color(0xFF1B5E20);
  if (isCurrent) return const Color(0xFFE65100);
  return const Color(0xFF9E9E9E);
}

Color getStepTimeColor({required bool isCompleted, required bool isCurrent}) {
  if (isCompleted) return const Color(0xFF66BB6A);
  if (isCurrent) return const Color(0xFFFFB74D);
  return const Color(0xFFBDBDBD);
}

/// Returns a status-specific icon for each step index
IconData getStepIconData(int index) {
  switch (index) {
    case 0:
      return Icons.hourglass_top_rounded;     // Waiting for Approval
    case 1:
      return Icons.thumb_up_alt_rounded;       // Accepted
    case 2:
      return Icons.restaurant_rounded;         // Approved / Preparing
    case 3:
      return Icons.inventory_2_rounded;        // Ready for Delivery
    case 4:
      return Icons.front_hand_rounded;         // Pick up
    case 5:
      return Icons.delivery_dining_rounded;    // On the way
    case 6:
      return Icons.home_rounded;               // Delivered
    case 7:
      return Icons.star_rounded;               // Completed
    default:
      return Icons.circle;
  }
}
