import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TopResturantText extends StatelessWidget {
  const TopResturantText({
    super.key,
    this.themeState,
    this.title,
    this.withoutPadding,  this.onTap, this.showSeeAll,
  });
  final ThemeState? themeState;
  final String? title;
  final bool? withoutPadding;
  final bool? showSeeAll;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:
            (withoutPadding == true)
                ? EdgeInsets.zero
                : EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title ?? AppStrings.top.tr(), style: TextStyles.bimini20W700),
            showSeeAll == false
                ? SizedBox()
                : Row(
                  children: [
                    Text(
                      AppStrings.seeAll.tr(),
                      style: TextStyles.bimini14W400White.copyWith(
                        color:
                            themeState?.themeMode == ThemeMode.dark
                                ? AppColors.lightGrey
                                : AppColors.primaryDeafult,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: onTap,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color:
                            themeState?.themeMode == ThemeMode.dark
                                ? AppColors.lightGrey
                                : AppColors.primaryDeafult,
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
