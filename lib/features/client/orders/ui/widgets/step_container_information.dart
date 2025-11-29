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
    required this.time
  });

  final bool isCompleted;
  final bool isCurrent;
  final OrderStep step;
  final ThemeState themeState;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 319.w,
        height: 76.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: getStepBgColor(isCompleted: isCompleted, isCurrent: isCurrent),
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(
            color: getStepBorderColor(
              isCompleted: isCompleted,
              isCurrent: isCurrent,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              step.title,
              style: TextStyles.bimini20W400.copyWith(
                color:
                    themeState.themeMode == ThemeMode.dark
                        ? Colors.black
                        : null,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyles.bimini16W400Body.copyWith(
                fontStyle: FontStyle.italic,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
