import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/filter_by_offers.dart';
import 'package:delveria/features/client/filter/data/models/sort_by_price.dart';
import 'package:delveria/features/client/home/ui/widgets/close_icon.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_state.dart';
import 'package:delveria/features/client/resturant/ui/restaurant_filteration_screen.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterResturantDialog extends StatelessWidget {
  const FilterResturantDialog({
    super.key,
    required this.themeState,
    this.showOffers = false,
    required this.resId,
    this.sortedPriceItems,
  });
  final ThemeState themeState;
  final bool? showOffers;
  final String resId;
  final List<SortByPriceItem>? sortedPriceItems;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResturantMenuCubit, ResturantMenuState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                int tempSelectedVal = state.selectedVal;
                return BlocProvider.value(
                  value: context.read<ResturantMenuCubit>(),
                  child: StatefulBuilder(
                    builder: (context, setStateDialog) {
                      return AlertDialog(
                        backgroundColor:
                            themeState.themeMode == ThemeMode.dark
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
                                    themeState.themeMode == ThemeMode.dark
                                        ? AppColors.primaryDeafult
                                        : AppColors.primary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            verticalSpace(10),
                            RadioListTile(
                              activeColor: AppColors.primaryDeafult,
                              title: Text(
                                AppStrings.price.tr() + AppStrings.priceFrom.tr(),
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

                            // RadioListTile(
                            //   activeColor: AppColors.primaryDeafult,

                            //   title: Text(
                            //     AppStrings.bestSelling,
                            //     style: TextStyles.bimini16W700,
                            //   ),
                            //   value: 1,
                            //   groupValue: tempSelectedVal,
                            //   onChanged: (p) {
                            //     setStateDialog(() {
                            //       tempSelectedVal = p!;
                            //     });
                            //   },
                            // ),
                            showOffers == true
                                ? RadioListTile(
                                  activeColor: AppColors.primaryDeafult,

                                  title: Text(
                                    "Offers",
                                    style: TextStyles.bimini16W700,
                                  ),
                                  value: 2,
                                  groupValue: tempSelectedVal,
                                  onChanged: (p) {
                                    setStateDialog(() {
                                      tempSelectedVal = p!;
                                    });
                                  },
                                )
                                : SizedBox(),
                            AppButton(
                              title: AppStrings.applyChanges.tr(),
                              onPressed: () {
                                context
                                    .read<ResturantMenuCubit>()
                                    .updateSelectedVal(newVal: tempSelectedVal);
                                Navigator.of(context).pop();

                                if (tempSelectedVal == 0) {
                                  Navigator.push(
                                    context,

                                    MaterialPageRoute(
                                      builder:
                                          (_) => RestaurantFilterationScreen(
                                            title: AppStrings.price.tr(),
                                            sortType: "price",
                                            edit:
                                                showOffers == true
                                                    ? true
                                                    : false,
                                            sortedPriceItems:
                                                sortedPriceItems ?? [],
                                          ),
                                    ),
                                  );
                                } else if (tempSelectedVal == 1) {
                                  context.pushNamed(
                                    Routes.bestPrice,
                                    arguments: [
                                      AppStrings.bestSelling.tr(),
                                      "selling",
                                      showOffers == true ? true : false,
                                    ],
                                  );
                                } else if (tempSelectedVal == 2) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => BlocProvider(
                                            create:
                                                (context) =>
                                                    getIt<ItemCubit>()
                                                      ..getAllItems(
                                                        resId: resId,
                                                      ),
                                            child: FilterByOffers(resId: resId),
                                          ),
                                    ),
                                  );
                                } else {
                                  debugPrint(
                                    "Unknown filter selection: $tempSelectedVal. Please check your logic or ask for help on StackOverflow.",
                                  );
                                }
                              },
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
