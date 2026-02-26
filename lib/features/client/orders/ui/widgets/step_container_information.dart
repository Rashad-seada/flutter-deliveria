import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/orders/data/models/order_step.dart';
import 'package:delveria/features/client/orders/ui/widgets/get_colors.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepContainerInformation extends StatelessWidget {
  const StepContainerInformation({
    super.key,
    required this.isCompleted,
    required this.isCurrent,
    required this.step,
    required this.themeState,
    required this.time,
  });

  final bool isCompleted;
  final bool isCurrent;
  final OrderStep step;
  final ThemeState themeState;
  final String time;

  @override
  Widget build(BuildContext context) {
    final textColor = getStepTextColor(
      isCompleted: isCompleted,
      isCurrent: isCurrent,
    );
    final timeColor = getStepTimeColor(
      isCompleted: isCompleted,
      isCurrent: isCurrent,
    );

    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: getStepBgColor(isCompleted: isCompleted, isCurrent: isCurrent),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: getStepBorderColor(
              isCompleted: isCompleted,
              isCurrent: isCurrent,
            ),
            width: isCurrent ? 1.5 : 1,
          ),
          boxShadow: isCurrent
              ? [
                  BoxShadow(
                    color: const Color(0xFFFF9800).withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : isCompleted
                  ? [
                      BoxShadow(
                        color: const Color(0xFF2ECC71).withOpacity(0.06),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ]
                  : [],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                step.title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight:
                      isCurrent ? FontWeight.w700 : FontWeight.w500,
                  color: textColor,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            if (isCompleted || isCurrent)
              Text(
                time,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: timeColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
