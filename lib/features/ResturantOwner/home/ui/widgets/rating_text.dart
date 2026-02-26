import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingText extends StatelessWidget {
  const RatingText({super.key, required this.totalText, required this.rating});
  final String totalText;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: AppColors.primaryDeafult, size: 25.sp),
        SizedBox(width: 4),
        Text(
          rating,
          style: TextStyles.bimini16W700BoldWhite.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
        horizontalSpace(10),
        Text(
          totalText,
          style: TextStyles.bimini16W700BoldWhite.copyWith(
            color: AppColors.darkGrey,
          ),
        ),
      ],
    );
  }
}
