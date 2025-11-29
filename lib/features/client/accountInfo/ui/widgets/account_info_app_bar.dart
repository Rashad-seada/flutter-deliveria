import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountInfoAppBar extends StatelessWidget {
  const AccountInfoAppBar({
    super.key,
    required this.themeState,
    required this.canPop,
    this.showArrow,
  });
  final ThemeState themeState;
  final bool canPop;
  final bool? showArrow;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading:
          showArrow == true
              ? IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color:
              themeState.themeMode == ThemeMode.dark
                  ? Colors.white
                  : AppColors.primary,
          size: 20.sp,
        ),
        onPressed: () {
          if (canPop) {
            context.pop();
          } else {
            SystemNavigator.pop();
          }
        },
              )
              : SizedBox(),
      title: Text(
        AppStrings.accountInfo.tr(),
        style: TextStyles.bimini20W700.copyWith(
          color:
              themeState.themeMode == ThemeMode.dark
                  ? Colors.white
                  : AppColors.primaryDeafult,
        ),
      ),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: () {
            context.pushNamed(Routes.editAccountInfoScreen);
          },
          child: Text(
            AppStrings.edit.tr(),
            style: TextStyles.bimini16W400Body.copyWith(
              color:
                  themeState.themeMode == ThemeMode.dark
                      ? Colors.white
                      : AppColors.primaryDeafult,
              decoration: TextDecoration.underline,
              decorationColor:
                  themeState.themeMode == ThemeMode.dark
                      ? Colors.white
                      : AppColors.primaryDeafult,
              decorationThickness: 5,
              height: 2,
            ),
          ),
        ),
      ],
    );
  }
}
