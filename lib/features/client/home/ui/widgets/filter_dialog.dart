import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_state.dart';
import 'package:delveria/features/client/home/ui/widgets/apply_changes_filter_button.dart';
import 'package:delveria/features/client/home/ui/widgets/close_icon.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({
    super.key,
    required this.theme,
    required this.lat,
    required this.long,
  });
  final ThemeState theme;
  final double lat, long;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselCubit, CarouselState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                int tempSelectedVal = state.selectedval;
                return BlocProvider.value(
                  value: context.read<CarouselCubit>(),
                  child: StatefulBuilder(
                    builder: (context, setStateDialog) {
                      return AlertDialog(
                        backgroundColor:
                            theme.themeMode == ThemeMode.dark
                                ? null
                                : Colors.white,
                        icon: CloseIcon(),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppStrings.selectYourFilter.tr(),
                              style: TextStyles.bimini20W700.copyWith(
                                color:
                                    theme.themeMode == ThemeMode.dark
                                        ? AppColors.primaryDeafult
                                        : AppColors.primary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            RadioListTile(
                              activeColor: AppColors.primaryDeafult,

                              title: Text(
                                AppStrings.rating.tr(),
                                style: TextStyles.bimini16W700,
                              ),
                              value: 0,
                              groupValue: tempSelectedVal,
                              onChanged: (p) {
                                setStateDialog(() {
                                  tempSelectedVal = p!;
                                });
                              },
                            ),
                            RadioListTile(
                              activeColor: AppColors.primaryDeafult,
                              title: Text(
                                AppStrings.categories.tr(),
                                style: TextStyles.bimini16W700,
                              ),
                              value: 1,
                              groupValue: tempSelectedVal,
                              onChanged: (p) {
                                setStateDialog(() {
                                  tempSelectedVal = p!;
                                });
                              },
                            ),
                            ApplyChangesFilterButton(
                              lat: lat,
                              long: long,
                              tempSelectedVal: tempSelectedVal,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
          child: Column(
            children: [
              Image.asset(AppImages.filter, width: 32.w, height: 32.h),
              Text(
                AppStrings.filter.tr(),
                style: TextStyles.bimini14W500.copyWith(color: Colors.black),
              ),
            ],
          ),
        );
      },
    );
  }
}
