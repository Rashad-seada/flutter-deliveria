import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/menu_resturant_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/menu_resturant_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodMenuTextResturant extends StatelessWidget {
  const FoodMenuTextResturant({super.key, required this.state});
  final MenuResturantState state;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          state.toggleToHorizental
              ? GestureDetector(
                onTap: () {
                  context.read<MenuResturantCubit>().makeHorizental();
                },
                child: Image.asset(AppImages.horizentalIcon, width: 16.w),
              )
              : GestureDetector(
                onTap: () {
                  context.read<MenuResturantCubit>().makeHorizental();
                },
                child: Image.asset(AppImages.sqaureIcon, width: 16.w),
              ),

          SizedBox(width: 8),
          Text(AppStrings.foodMenu.tr(), style: TextStyles.bimini20W700),
        ],
      ),
    );
  }
}
