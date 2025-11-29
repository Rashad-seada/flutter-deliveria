import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StateCard extends StatelessWidget {
  const StateCard({super.key, required this.title, required this.value, required this.change, });
  final String title;
  final String value;
  final String change;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 163.w,
      height: 136.h,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyles.bimini20W400),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyles.bimini20W700.copyWith(color: AppColors.primary),
          ),
          verticalSpace(10),
          Text(
            change,
            style: TextStyles.bimini16W400Body.copyWith(color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
