import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackOrderButtonRow extends StatelessWidget {
  const TrackOrderButtonRow({
    super.key,
    this.fHeight,
    this.fWidth,
    this.sHeight,
    this.sWidth,
    this.ftitle,
    this.sTitle,
    this.fOnPressed,
    this.sOnPressed,
    this.themeState,
    this.showSecond = true, this.fColor, this.sColor, this.sTitleColor,
  });
  final double? fHeight, fWidth, sHeight, sWidth;
  final String? ftitle, sTitle;
  final void Function()? fOnPressed;
  final void Function()? sOnPressed;
  final ThemeState? themeState;
  final bool? showSecond;
 final Color? fColor, sColor , sTitleColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          showSecond == true
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
      children: [
        SizedBox(
          height: fHeight ?? 44.h,
          width: fWidth ?? 156.w,
          child: ElevatedButton(
            onPressed: fOnPressed ?? () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: fColor ?? AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              elevation: 0,
            ),
            child: Text(
              ftitle ?? 'Track Order',
              style: TextStyles.bimini16W700.copyWith(color: Colors.white),
            ),
          ),
        ),
        showSecond == true
            ? SizedBox(
              height: sHeight ?? 44.h,
              width: sWidth ?? 156.w,
              child: OutlinedButton(
                onPressed:
                    sOnPressed ??
                    () {
                      context.pushNamedAndRemoveUntil(
                        Routes.bottomBarScreen,
                        arguments: 0,
                        predicate:
                            (route) => route.settings.name == Routes.onBoarding,
                      );
                    },
                style: OutlinedButton.styleFrom(
                  backgroundColor:
                      themeState?.themeMode == ThemeMode.dark
                          ? Colors.white.withValues(alpha: .7)
                          : sColor ?? AppColors.lightGrey,
                  side: BorderSide(
                    color: AppColors.primaryDeafult.withValues(alpha: .6),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
                child: Text(
                  sTitle ?? AppStrings.home.tr(),
                  style: TextStyles.bimini16W700.copyWith(
                    color:sTitleColor?? AppColors.primary,
                  ),
                ),
              ),
            )
            : SizedBox(),
      ],
    );
  }
}
