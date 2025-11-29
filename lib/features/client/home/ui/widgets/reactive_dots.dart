import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_state.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';

class ReactiveDots extends StatelessWidget {
  const ReactiveDots({
    super.key,
    required this.state,
    required this.themeState, required this.cubit,
  });
  final CarouselState state;
  final ThemeState themeState;
  final SlidersCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(cubit.sliders.length, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.only(right: 5),
          height: 8,
          width: state.currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color:
                state.currentPage == index
                    ? themeState.themeMode == ThemeMode.dark
                        ? AppColors.primaryDeafultDarkMode
                        : AppColors.primaryDeafult
                    : themeState.themeMode == ThemeMode.dark
                    ? AppColors.grey
                    : AppColors.grey.withValues(alpha: .3),
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }
}
