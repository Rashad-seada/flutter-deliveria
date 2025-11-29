import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RateAndDeliveryCostRow extends StatelessWidget {
  const RateAndDeliveryCostRow({super.key,  this.themeState, this.rate, this.deliveryCost, this.estimatedTime});
  final ThemeState? themeState;
final String ? rate,deliveryCost,estimatedTime;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          spacing: 5,
          children: [
            Icon(
              Icons.star_border,
              color:
                  themeState?.themeMode == ThemeMode.dark
                      ? AppColors.primaryDeafult
                      : AppColors.primary,
              size: 20,
            ),
            Text(
              rate?.substring(0, 1) ?? '4.7',
              style: TextStyles.bimini16W700,
            ),
          ],
        ),
        Row(
          spacing: 10,
          children: [
            Image.asset(AppImages.deliveryRed, width: 23.w, height: 16.h),
            Text(
              "15 min " ?? 'Free',
              style: TextStyles.bimini14W400White.copyWith(
                color:
                    themeState?.themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
              ),
            ),
          ],
        ),
        Row(
          spacing: 2,
          children: [
            Icon(
              Icons.access_time,
              color:
                  themeState?.themeMode == ThemeMode.dark
                      ? AppColors.primaryDeafult
                      : AppColors.primary,
              size: 20,
            ),
            const SizedBox(width: 4),
            Text(
              "$estimatedTime ${AppStrings.min.tr()}" ?? '20 min',
              style: TextStyles.bimini14W400White.copyWith(
                color:
                    themeState?.themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
