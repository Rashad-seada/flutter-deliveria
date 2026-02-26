import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/loyalty/data/models/loyalty_dashboard_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RewardCodeCard extends StatelessWidget {
  final EarnedReward reward;
  final bool isUsed;

  const RewardCodeCard({
    super.key,
    required this.reward,
    required this.isUsed,
  });

  IconData _getTierIcon() {
    final tierName = reward.tierName?.toLowerCase() ?? '';
    if (tierName.contains('gold')) return Icons.emoji_events;
    if (tierName.contains('silver')) return Icons.workspace_premium;
    if (tierName.contains('platinum')) return Icons.diamond;
    return Icons.military_tech; // Bronze/default
  }

  Color _getTierColor() {
    final tierName = reward.tierName?.toLowerCase() ?? '';
    if (tierName.contains('gold')) return Colors.amber.shade600;
    if (tierName.contains('silver')) return Colors.blueGrey.shade400;
    if (tierName.contains('platinum')) return Colors.purple.shade400;
    return Colors.orange.shade700; // Bronze
  }

  @override
  Widget build(BuildContext context) {
    final tierColor = _getTierColor();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isUsed ? Colors.grey.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isUsed ? Colors.grey.shade300 : tierColor.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: isUsed
            ? null
            : [
                BoxShadow(
                  color: tierColor.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Tier Icon
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: (isUsed ? Colors.grey : tierColor).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  _getTierIcon(),
                  color: isUsed ? Colors.grey : tierColor,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              // Tier name and discount
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reward.tierName ?? AppStrings.reward.tr(),
                      style: TextStyles.bimini16W700.copyWith(
                        color: isUsed ? Colors.grey : Colors.black87,
                      ),
                    ),
                    Text(
                      reward.discountType == 'percentage'
                          ? "${reward.discountValue?.toInt() ?? 0}${AppStrings.percentOff.tr()}"
                          : "${reward.discountValue?.toInt() ?? 0} ${AppStrings.egpOff.tr()}",
                      style: TextStyles.bimini14W500.copyWith(
                        color: isUsed ? Colors.grey : tierColor,
                      ),
                    ),
                  ],
                ),
              ),
              // Status badge
              if (isUsed)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    AppStrings.used.tr(),
                    style: TextStyles.bimini10W700.copyWith(color: Colors.grey.shade600),
                  ),
                ),
            ],
          ),
          verticalSpace(16),
          // Code section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    reward.code ?? '',
                    style: TextStyles.bimini16W700.copyWith(
                      color: isUsed ? Colors.grey : Colors.black87,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                if (!isUsed)
                  InkWell(
                    onTap: () => _copyCode(context),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryDeafult.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Icon(
                        Icons.copy_rounded,
                        color: AppColors.primaryDeafult,
                        size: 18.sp,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Used date
          if (isUsed && reward.usedAt != null) ...[
            verticalSpace(8),
            Text(
              "${AppStrings.usedOn.tr()} ${_formatDate(reward.usedAt!)}",
              style: TextStyles.bimini12W500.copyWith(color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }

  void _copyCode(BuildContext context) {
    Clipboard.setData(ClipboardData(text: reward.code ?? ''));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppStrings.codeCopied.tr()),
        backgroundColor: AppColors.primaryDeafult,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return "${date.day}/${date.month}/${date.year}";
    } catch (_) {
      return isoDate;
    }
  }
}
