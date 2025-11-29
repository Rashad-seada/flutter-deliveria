import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_state.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodMenuText extends StatelessWidget {
  const FoodMenuText({super.key, required this.themeState});
  final ThemeState themeState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResturantMenuCubit, ResturantMenuState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              state.toggleToHorizental
                  ? GestureDetector(
                    onTap: () {
                      context.read<ResturantMenuCubit>().makeMenuHorizental();
                    },
                    child: Image.asset(
                      AppImages.horizentalIcon,
                      width: 16.w,
                      color:
                          themeState.themeMode == ThemeMode.dark
                              ? Colors.white
                              : null,
                    ),
                  )
                  : GestureDetector(
                    onTap: () {
                      context.read<ResturantMenuCubit>().makeMenuHorizental();
                    },
                    child: Image.asset(
                      AppImages.sqaureIcon,
                      width: 16.w,
                      color:
                          themeState.themeMode == ThemeMode.dark
                              ? Colors.white
                              : null,
                    ),
                  ),

              SizedBox(width: 8),
              Text(AppStrings.foodMenu.tr(), style: TextStyles.bimini20W700),
            ],
          ),
        );
      },
    );
  }
}
