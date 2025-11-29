import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/admin/adminBottomBar/logic/cubit/admin_bottom_bar_cubit.dart';
import 'package:delveria/features/admin/adminBottomBar/logic/cubit/admin_bottom_bar_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminBottomBarBloc extends StatelessWidget {
  const AdminBottomBarBloc({super.key, required this.state});
  final AdminBottomBarState state;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.adminBottomBarColor,
      type: BottomNavigationBarType.fixed,
      currentIndex: state.selectedIndex,
      selectedItemColor: AppColors.primaryDeafult,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyles.bimini13W700Deafult.copyWith(
        color: AppColors.primary,
      ),
      unselectedLabelStyle: TextStyles.bimini13W400Grey,
      onTap: (value) {
        context.read<AdminBottomBarCubit>().updateSelectedIndex(value);
      },
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            state.selectedIndex == 0
                ? AppImages.homeRedRes
                : AppImages.homeGreyRes,
            width: 24.w,
            height: 32.h,
          ),
          label: AppStrings.home.tr(),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AppImages.users,
            width: 24.w,
            height: 32.h,
            color:
                state.selectedIndex == 1
                    ? AppColors.primaryDeafult
                    : AppColors.grey,
          ),
          label: AppStrings.users.tr(),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AppImages.res,
            width: 24.w,
            height: 32.h,
            color:
                state.selectedIndex == 2
                    ? AppColors.primaryDeafult
                    : AppColors.grey,
          ),
          label: AppStrings.resturants.tr(),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AppImages.notificationAdmin,
            width: 24.w,
            height: 32.h,
            color:
                state.selectedIndex == 3
                    ? AppColors.primaryDeafult
                    : AppColors.grey,
          ),
          label:AppStrings.notifications.tr() ,
        ),
      ],
    );
  }
}
