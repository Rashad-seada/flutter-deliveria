import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestPicksTextRow extends StatelessWidget {
  const BestPicksTextRow({super.key,  this.themeState});
  final ThemeState? themeState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppStrings.bestPicks.tr(), style: TextStyles.bimini20W700),
          Row(
            children: [
              Text(
                "See all",
                style: TextStyles.bimini14W400White.copyWith(
                  color:
                      themeState?.themeMode == ThemeMode.dark
                          ? AppColors.lightGrey
                          : AppColors.darkGrey,
                ),
              ),
              Icon(Icons.chevron_right, color:themeState?.themeMode==ThemeMode.dark?AppColors.lightGrey: Colors.black, size: 20.sp),
            ],
          ),
        ],
      ),
    );
  }
}
