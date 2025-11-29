import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/ResturantOwner/bottomNavBarResturant.dart/logic/cubit/resturant_bottom_nav_bar_cubit.dart';
import 'package:delveria/features/ResturantOwner/bottomNavBarResturant.dart/logic/cubit/resturant_bottom_nav_bar_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResturantBottomNavBarBloc extends StatelessWidget {
  const ResturantBottomNavBarBloc({super.key, required this.state});
  final ResturantBottomNavBarState state;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      elevation: 5,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryDeafult,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyles.bimini13W400Grey.copyWith(
        color: AppColors.primary,
      ),
      unselectedLabelStyle: TextStyles.bimini13W400Grey,
      currentIndex: state.selectedIndex,
      onTap: (value) {
        context.read<ResturantBottomNavBarCubit>().updateSelectedIndex(value);
      },
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            state.selectedIndex == 0
                ? AppImages.homeRedRes
                : AppImages.homeGreyRes,
            width: 24.w,
            height: 24.h,
          ),
          label:AppStrings.home.tr(),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AppImages.ordersGreyRes,
            width: 24.w,
            height: 24.h,
            color: state.selectedIndex == 1 ? AppColors.primary : Colors.grey,
          ),
          label:AppStrings.orders.tr(),
        ),
        BottomNavigationBarItem(
          icon: Container(
            width: 57.w,
            height: 57.h,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryDeafult),
            ),
            child: Icon(Icons.add, color: AppColors.primaryDeafult),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AppImages.menuGreyRes,
            width: 24.w,
            height: 24.h,
            color: state.selectedIndex == 3 ? AppColors.primary : Colors.grey,
          ),
          label: AppStrings.menu.tr(),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AppImages.profileGreyRes,
            width: 24.w,
            height: 24.h,
            color: state.selectedIndex == 4 ? AppColors.primary : Colors.grey,
          ),
          label:AppStrings.profile.tr(),
        ),
      ],
    );
  }
}
