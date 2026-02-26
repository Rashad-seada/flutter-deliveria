import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/loyalty/data/models/loyalty_dashboard_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NextTierCard extends StatelessWidget {
  final NextTier nextTier;

  const NextTierCard({super.key, required this.nextTier});

  @override
  Widget build(BuildContext context) {
    final progress = (nextTier.progress ?? 0) / 100;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primaryDeafult.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryDeafult.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.trending_up_rounded,
                  color: AppColors.primaryDeafult,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${AppStrings.next.tr()}: ${nextTier.name ?? ''}",
                      style: TextStyles.bimini16W700.copyWith(
                        color: AppColors.primaryDeafult,
                      ),
                    ),
                    Text(
                      "${nextTier.pointsNeeded ?? 0} ${AppStrings.morePointsNeeded.tr()}",
                      style: TextStyles.bimini12W500.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Text(
                "${nextTier.progress ?? 0}%",
                style: TextStyles.bimini18W700.copyWith(
                  color: AppColors.primaryDeafult,
                ),
              ),
            ],
          ),
          verticalSpace(16),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryDeafult),
              minHeight: 8.h,
            ),
          ),
        ],
      ),
    );
  }
}
