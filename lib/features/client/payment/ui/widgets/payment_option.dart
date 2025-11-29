import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentOption extends StatelessWidget {
  final String imgRed;
  final String imgGrey;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentOption({
    super.key,
    required this.imgGrey,
    required this.imgRed,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: 343.w,
            height: 44.h,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    isSelected ? AppColors.primaryDeafult : Colors.grey[300]!,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                isSelected
                    ? Image.asset(imgRed, width: 24.w, height: 24.h)
                    : Image.asset(
                      imgGrey,
                      width: 24.w,
                      height: 24.h,
                      color:
                          state.themeMode == ThemeMode.dark
                              ? Colors.white
                              : null,
                    ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyles.bimini16W400Body.copyWith(
                      color:
                          isSelected
                              ? AppColors.primaryDeafult
                              : state.themeMode == ThemeMode.dark
                              ? Colors.white
                              : AppColors.darkGrey,
                    ),
                  ),
                ),
                isSelected
                    ? Icon(
                      Icons.radio_button_checked_rounded,
                      color: AppColors.primaryDeafult,
                    )
                    : Icon(Icons.radio_button_off_outlined),
              ],
            ),
          ),
        );
      },
    );
  }
}
