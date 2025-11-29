import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SoundSettings extends StatelessWidget {
  const SoundSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.soundSettings.tr(), style: TextStyles.bimini16W700),
            Container(
              width: 95.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: AppColors.lightGreySecond,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(AppStrings.manage.tr(), style: TextStyles.bimini16W400Body),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Adjust the sound settings for incoming\norders',
          style: TextStyles.bimini16W400Body.copyWith(
            fontStyle: FontStyle.italic,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
