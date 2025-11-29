import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.onPressed,
    this.stateOfTheme,
  });
  final String title;
  final VoidCallback? onPressed;
  final ThemeState? stateOfTheme;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 4,
        disabledBackgroundColor:
            stateOfTheme?.themeMode == ThemeMode.dark
                ? AppColors.primaryDarkMode
                : AppColors.primary,
        backgroundColor:
            stateOfTheme?.themeMode == ThemeMode.dark
                ? AppColors.primaryDarkMode
                : AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
        minimumSize: Size(266.w, 44.h),
      ),
      child: Text(title, style: TextStyles.bimini16W700BoldWhite),
    );
  }
}
