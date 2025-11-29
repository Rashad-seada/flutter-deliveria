import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/circle_progress_painter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularChart extends StatelessWidget {
  final int totalNumbers;
  final double? progress; // progress as a value between 0.0 and 1.0
  final bool? isUser;

  const CircularChart({
    super.key,
    required this.totalNumbers,
    this.progress,
    this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    double displayProgress = (progress ?? 1.0).clamp(0.0, 1.0);

    return SizedBox(
      width: isUser == true ? 105 : 120,
      height: isUser == true ? 105 : 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          RotatedBox(
            quarterTurns: -1,
            child: SizedBox(
              width: isUser == true ? 101.w : 110.w,
              height: isUser == true ? 102 : 106.h,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: displayProgress),
                duration: const Duration(milliseconds: 500),
                builder: (context, value, child) {
                  return CustomPaint(
                    painter: TopCircularProgressPainter(
                      progress: value,
                      color: const Color(0xFF8B1538),
                      strokeWidth: 5,
                    ),
                  );
                },
              ),
            ),
          ),
          // Center text
          Container(
            width: isUser == true ? 81.w : 91.w,
            height: isUser == true ? 82.h : 92.h,
            decoration: BoxDecoration(
              color: AppColors.pinkLight,
              shape: BoxShape.circle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${AppStrings.totalNumbers.tr()}: $totalNumbers",
                  style: TextStyles.sen14W400.copyWith(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                Text(
                  "Progress: ${(displayProgress * 100).toStringAsFixed(0)}%",
                  style: TextStyles.sen14W400.copyWith(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
