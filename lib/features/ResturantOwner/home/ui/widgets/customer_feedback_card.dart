import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerFeedBackCard extends StatelessWidget {
  const CustomerFeedBackCard({super.key, required this.customerRate});
  final String customerRate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 136.h,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.customerFeedback.tr(), style: TextStyles.bimini20W400),
          SizedBox(height: 4),
          Text(
            '$customerRate/5',
            style: TextStyles.bimini20W700.copyWith(color: AppColors.primary),
          ),
          verticalSpace(10),
          Text(
            '+5%',
            style: TextStyles.bimini16W400Body.copyWith(color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
