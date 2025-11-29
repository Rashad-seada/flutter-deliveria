import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key, required this.theme});
  final ThemeState theme;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      right: 10,
      child: TextButton(
        onPressed: ()async {
          // context.pushNamed(
          //   Routes.adminBottomBarScreen,
          //   arguments: [0, false, false],
          // );
          // context.pushNamed(Routes.resturantBottomBar);
            await SharedPrefHelper.setData(
              SharedPrefKeys.finishOnBoarding,
              true,
            );

           context.pushNamed(Routes.loginScreen);
        },
        child: Row(
          children: [
            Text(
              "تخطي",
              style: TextStyles.bimini16W400Body.copyWith(
                color:
                    theme.themeMode == ThemeMode.dark
                        ? Colors.white
                        : AppColors.primary,
              ),
            ),
            horizontalSpace(10),
            SvgPicture.asset(
              AppImages.arrowRight,
              color: theme.themeMode == ThemeMode.dark ? Colors.white : null,
            ),
          ],
        ),
      ),
    );
  }
}
