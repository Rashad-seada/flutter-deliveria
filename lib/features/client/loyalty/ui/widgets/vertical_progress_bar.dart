import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/loyalty/data/models/loyalty_dashboard_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalProgressBar extends StatelessWidget {
  final List<RewardTier> tiers;
  final int currentPoints;

  const VerticalProgressBar({
    super.key,
    required this.tiers,
    required this.currentPoints,
  });

  @override
  Widget build(BuildContext context) {
    // Sort tiers by points required (ascending)
    final sortedTiers = List<RewardTier>.from(tiers)
      ..sort((a, b) => (a.pointsRequired ?? 0).compareTo(b.pointsRequired ?? 0));

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          for (int i = sortedTiers.length - 1; i >= 0; i--) ...[
            _buildTierNode(sortedTiers[i], i == sortedTiers.length - 1),
            if (i > 0) _buildConnector(sortedTiers[i], sortedTiers[i - 1]),
          ],
          // Start node at bottom
          _buildStartNode(),
        ],
      ),
    );
  }

  Widget _buildTierNode(RewardTier tier, bool isTop) {
    final bool isAchieved = tier.achieved == true;
    final bool isNext = !isAchieved &&
        currentPoints < (tier.pointsRequired ?? 0) &&
        (tiers
            .where((t) =>
                (t.pointsRequired ?? 0) < (tier.pointsRequired ?? 0) &&
                t.achieved != true)
            .isEmpty);

    final Color nodeColor = isAchieved
        ? Colors.green
        : isNext
            ? AppColors.primaryDeafult
            : Colors.grey.shade300;

    final IconData nodeIcon = isAchieved
        ? Icons.check_circle
        : isNext
            ? Icons.star_rounded
            : Icons.circle_outlined;

    return Row(
      children: [
        // Node
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: nodeColor.withOpacity(isAchieved ? 0.15 : 0.1),
            border: Border.all(color: nodeColor, width: 3),
          ),
          child: Icon(
            nodeIcon,
            color: nodeColor,
            size: 24.sp,
          ),
        ),
        SizedBox(width: 16.w),
        // Tier info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    tier.name ?? '',
                    style: TextStyles.bimini16W700.copyWith(
                      color: isAchieved
                          ? Colors.green
                          : isNext
                              ? AppColors.primaryDeafult
                              : Colors.grey,
                    ),
                  ),
                  if (isNext)
                    Container(
                      margin: EdgeInsets.only(left: 8.w),
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.primaryDeafult.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        AppStrings.next.tr().toUpperCase(),
                        style: TextStyles.bimini10W700.copyWith(
                          color: AppColors.primaryDeafult,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                "${tier.pointsRequired ?? 0} ${AppStrings.points.tr()}",
                style: TextStyles.bimini12W500.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
        // Discount badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: isAchieved
                ? Colors.green.withOpacity(0.1)
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            tier.discountType == 'percentage'
                ? "${tier.discountValue?.toInt() ?? 0}${AppStrings.percentOff.tr()}"
                : "${tier.discountValue?.toInt() ?? 0} ${AppStrings.egpOff.tr()}",
            style: TextStyles.bimini12W700.copyWith(
              color: isAchieved ? Colors.green : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConnector(RewardTier upperTier, RewardTier lowerTier) {
    final bool lowerAchieved = lowerTier.achieved == true;
    final bool upperAchieved = upperTier.achieved == true;

    double fillPercent = 0;
    if (upperAchieved) {
      fillPercent = 1;
    } else if (lowerAchieved) {
      final lowerPts = lowerTier.pointsRequired ?? 0;
      final upperPts = upperTier.pointsRequired ?? 0;
      final range = upperPts - lowerPts;
      if (range > 0) {
        fillPercent = ((currentPoints - lowerPts) / range).clamp(0, 1);
      }
    }

    return Container(
      margin: EdgeInsets.only(left: 22.w),
      height: 40.h,
      width: 4.w,
      child: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          // Fill
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: fillPercent,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartNode() {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green.withOpacity(0.15),
              border: Border.all(color: Colors.green, width: 3),
            ),
            child: Icon(
              Icons.flag_rounded,
              color: Colors.green,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            AppStrings.start.tr(),
            style: TextStyles.bimini14W700.copyWith(color: Colors.green),
          ),
        ],
      ),
    );
  }
}
