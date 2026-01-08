import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopResturantText extends StatelessWidget {
  const TopResturantText({
    super.key,
    this.themeState,
    this.title,
    this.withoutPadding,
    this.onTap,
    this.showSeeAll,
  });
  final ThemeState? themeState;
  final String? title;
  final bool? withoutPadding;
  final bool? showSeeAll;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = themeState?.themeMode == ThemeMode.dark;

    return Padding(
      padding: (withoutPadding == true)
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title with accent decoration
          Row(
            children: [
              Container(
                width: 4.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryDeafult,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                title ?? AppStrings.top.tr(),
                style: TextStyles.bimini20W700.copyWith(
                  fontSize: 19.sp,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          // Enhanced "See All" button
          if (showSeeAll != false)
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.primaryDeafultDarkMode.withOpacity(0.15)
                      : AppColors.primaryDeafult.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppStrings.seeAll.tr(),
                      style: TextStyles.bimini14W400White.copyWith(
                        color: isDark
                            ? AppColors.primaryDeafultDarkMode
                            : AppColors.primaryDeafult,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12.sp,
                      color: isDark
                          ? AppColors.primaryDeafultDarkMode
                          : AppColors.primaryDeafult,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
