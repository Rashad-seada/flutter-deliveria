import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_state.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReactiveDots extends StatelessWidget {
  const ReactiveDots({
    super.key,
    required this.state,
    required this.themeState,
    required this.cubit,
  });
  final CarouselState state;
  final ThemeState themeState;
  final SlidersCubit cubit;

  @override
  Widget build(BuildContext context) {
    final isDark = themeState.themeMode == ThemeMode.dark;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(cubit.sliders.length, (index) {
        final isActive = state.currentPage == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOutCubic,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: 8.h,
          width: isActive ? 28.w : 8.w,
          decoration: BoxDecoration(
            color: isActive
                ? (isDark ? AppColors.primaryDeafultDarkMode : AppColors.primaryDeafult)
                : (isDark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.25)),
            borderRadius: BorderRadius.circular(4.r),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: (isDark 
                          ? AppColors.primaryDeafultDarkMode 
                          : AppColors.primaryDeafult).withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }
}
