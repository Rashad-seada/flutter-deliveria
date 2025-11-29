import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickFoodResturantAppBar extends StatelessWidget {
  const QuickFoodResturantAppBar({
    super.key,
    required this.themeState,
    this.onFavTap,
    required this.title,
  });
  final ThemeState themeState;
  final void Function()? onFavTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          themeState.themeMode == ThemeMode.dark
              ? Colors.black12
              : Colors.white,
      surfaceTintColor:
          themeState.themeMode == ThemeMode.dark
              ? Colors.black12
              : Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(Icons.arrow_back_ios_new, size: 20),
          ),
          Text(
            title,
            style: TextStyles.bimini20W700.copyWith(
              color: AppColors.primaryDeafult,
            ),
          ),
          GestureDetector(
            onTap: onFavTap,
            child: Image.asset(AppImages.favIcon, width: 24.w),
          ),
        ],
      ),
    );
  }
}
