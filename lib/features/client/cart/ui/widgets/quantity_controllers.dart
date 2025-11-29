import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/cart/logic/cubit/cart_state.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuantityControllers extends StatelessWidget {
  const QuantityControllers({
    super.key,
    required this.state,
    required this.themeState,
    required this.showTrach,
    this.onDecreaseTap,
    this.onIncreaseTap, required this.quantity,
  });
  final CartState state;
  final ThemeState themeState;
  final bool showTrach;
  final void Function()? onDecreaseTap;
  final void Function()? onIncreaseTap;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: showTrach ? 30.h : 0,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        showTrach
            ? Image.asset(
              AppImages.trach,
              width: 24.w,
              height: 24.h,
              color:
                  themeState.themeMode == ThemeMode.dark
                      ? AppColors.primaryDeafultDarkMode
                      : null,
            )
            : SizedBox(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onDecreaseTap,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color:
                      themeState.themeMode == ThemeMode.dark
                          ? AppColors.primaryDeafultDarkMode
                          : AppColors.primaryDeafult,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.remove, color: Colors.white, size: 16),
              ),
            ),
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              child: Text(
                '$quantity',
                style: TextStyles.bimini16W700BoldWhite.copyWith(
                  color:
                      themeState.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                ),
              ),
            ),
            GestureDetector(
              onTap: onIncreaseTap,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color:
                      themeState.themeMode == ThemeMode.dark
                          ? AppColors.primaryDeafultDarkMode
                          : AppColors.primaryDeafult,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, color: Colors.white, size: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
