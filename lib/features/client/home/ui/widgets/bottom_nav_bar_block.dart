import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_state.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBarBloc extends StatelessWidget {
  const BottomNavBarBloc({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselCubit, CarouselState>(
      builder: (context, state) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themestate) {
            return CurvedNavigationBar(
              index: selectedIndex,
              height: 70,
              backgroundColor:
                  themestate.themeMode == ThemeMode.dark
                      ? Colors.black12
                      : AppColors.lightGrey,
              color:
                  themestate.themeMode == ThemeMode.dark
                      ? AppColors.primaryDarkMode
                      : Colors.white,

              buttonBackgroundColor:
                  themestate.themeMode == ThemeMode.dark
                      ? AppColors.primaryDeafultDarkMode
                      : const Color(0xFFB71C1C),
              animationDuration: const Duration(milliseconds: 300),
              items: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    selectedIndex == 0
                        ? AppImages.homeWhite
                        : AppImages.homeGrey,
                    width: 30.w,
                    height: selectedIndex == 0 ? 25.h : 20.h,
                    fit: BoxFit.scaleDown,
                    color:
                        themestate.themeMode == ThemeMode.dark
                            ? Colors.white
                            : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    selectedIndex == 1
                        ? AppImages.cartWhite
                        : AppImages.cartGrey,
                    width: 20.w,
                    height: 20.h,
                    fit: BoxFit.scaleDown,
                    color:
                        themestate.themeMode == ThemeMode.dark
                            ? Colors.white
                            : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    selectedIndex == 2
                        ? AppImages.notificationWhite
                        : AppImages.notificationGrey,
                    width: 30.w,
                    height: 20.h,
                    fit: BoxFit.scaleDown,
                    color:
                        themestate.themeMode == ThemeMode.dark
                            ? Colors.white
                            : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    selectedIndex == 3
                        ? AppImages.personWhite
                        : AppImages.personGrey,
                    width: 30.w,
                    height: 20.h,
                    fit: BoxFit.scaleDown,
                    color:
                        themestate.themeMode == ThemeMode.dark
                            ? Colors.white
                            : null,
                  ),
                ),
              ],
              onTap: (index) {
                context.read<CarouselCubit>().updateSelectedIndex(index);
              },
            );
          },
        );
      },
    );
  }
}
