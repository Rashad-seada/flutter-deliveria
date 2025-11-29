import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildCategoryTab(String title, bool isSelected , void Function() onTap) {
  return BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, state) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(right: 16),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? AppColors.pinkLight
                    : state.themeMode == ThemeMode.dark
                    ? null
                    : AppColors.lightGrey,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color:
                  isSelected
                      ? AppColors.pinkLight
                      : AppColors.grey.withValues(alpha: .6),
            ),
          ),
          child: Text(
            title,
            style: TextStyles.bimini13W400Grey.copyWith(
              color:
                  isSelected
                      ? AppColors.darkBrown
                      : state.themeMode == ThemeMode.dark
                      ? Colors.white
                      : AppColors.grey,
            ),
          ),
        ),
      );
    },
  );
}
