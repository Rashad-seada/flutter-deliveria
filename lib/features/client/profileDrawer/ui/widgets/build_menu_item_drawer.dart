import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildMenuItemDrawer({
   String ? img,
  required String title,
  required VoidCallback onTap,
  bool showTrailing = true,
  Widget? leading
}) {
  return BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, state) {
      return ListTile(
        leading: leading ?? Image.asset(
          img??AppImages.myOrder,
          width: 15.w,
          height: 20.h,
          color: state.themeMode == ThemeMode.dark ? Colors.white : null,
        ),
        title: Text(
          title,
          style: TextStyles.bimini16W400Body.copyWith(
            color:
                state.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black87,
          ),
        ),
        trailing:
            showTrailing
                ? Icon(
                  Icons.arrow_forward_ios,
                  color:
                      state.themeMode == ThemeMode.dark
                          ? Colors.white
                          : AppColors.darkGrey,
                  size: 11.sp,
                )
                : null,
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 1.h),
      );
    },
  );
}
