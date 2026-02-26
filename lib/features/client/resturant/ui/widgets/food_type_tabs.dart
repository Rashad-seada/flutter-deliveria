import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_state.dart';
import 'package:delveria/features/client/resturant/ui/widgets/build_category_tab.dart';
import 'package:delveria/features/client/resturant/ui/widgets/horizental_body.dart';
import 'package:delveria/features/client/resturant/ui/widgets/vertical_menu_body.dart';
import 'package:delveria/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';

class FoodTypeTaps extends StatefulWidget {
  const FoodTypeTaps({
    super.key,
    this.searchQuery,
  });

  final String? searchQuery;

  @override
  State<FoodTypeTaps> createState() => _FoodTypeTapsState();
}

class _FoodTypeTapsState extends State<FoodTypeTaps> {
  bool showHorizontal = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ItemCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cubit.allItemsCategoriesUser.isNotEmpty) {
        cubit.filterItemCategoriesUser(
          cateId: cubit.allItemsCategoriesUser[0].id ?? "",
          resId: cubit.allItemsCategoriesUser[0].restaurantId,
        );
        cubit.updateIsSelectedFilter(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<ItemCubit, ItemState>(
          builder: (context, state) {
            final cubit = context.read<ItemCubit>();

        if (cubit.allItemsCategoriesUser.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 1.h, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showHorizontal = !showHorizontal;
                      });
                    },
                    child: Image.asset(
                      showHorizontal
                          ? AppImages.horizentalIcon
                          : AppImages.sqaureIcon,
                      width: 16.w,
                      color:
                          themeState.themeMode == ThemeMode.dark
                              ? Colors.white
                              : null,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    AppStrings.foodMenu.tr(),
                    style: TextStyles.bimini20W700,
                  ),
                ],
              ),
            ),
            verticalSpace(15),
            SizedBox(
              height: 33.h,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                // +1 for the "Offers" tab at the beginning
                itemCount: cubit.allItemsCategoriesUser.length + 1,
                itemBuilder: (context, index) {
                  // First item is always "Offers" tab
                  if (index == 0) {
                    return buildCategoryTab(
                      AppStrings.discount.tr(), // "Offers" / "العروض"
                      cubit.isSelectedFilter == -1, // -1 indicates Offers tab
                      () {
                        cubit.getOffersOnly(
                          resId: cubit.allItemsCategoriesUser.isNotEmpty
                              ? cubit.allItemsCategoriesUser[0].restaurantId
                              : cubit.resturant?.id ?? "",
                        );
                        cubit.updateIsSelectedFilter(-1); // -1 for Offers
                      },
                    );
                  }
                  // Adjust index for regular categories (index - 1)
                  final categoryIndex = index - 1;
                  return buildCategoryTab(
                    context.locale.languageCode == "en"
                        ? cubit.allItemsCategoriesUser[categoryIndex].nameEn
                        : cubit.allItemsCategoriesUser[categoryIndex].nameAr,
                    cubit.isSelectedFilter == categoryIndex,
                    () {
                      cubit.filterItemCategoriesUser(
                        cateId: cubit.allItemsCategoriesUser[categoryIndex].id ?? "",
                        resId: cubit.allItemsCategoriesUser[categoryIndex].restaurantId,
                      );
                      cubit.updateIsSelectedFilter(categoryIndex);
                    },
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            verticalSpace(15),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Builder(
                  builder: (context) {
                    // When Offers tab is selected (index -1), use first category's restaurant ID
                    // Otherwise use the selected category's restaurant ID
                    final resId = cubit.isSelectedFilter == -1
                        ? (cubit.allItemsCategoriesUser.isNotEmpty
                            ? cubit.allItemsCategoriesUser[0].restaurantId
                            : cubit.resturant?.id ?? "")
                        : cubit.allItemsCategoriesUser[cubit.isSelectedFilter].restaurantId;

                    return showHorizontal
                        ? HorizentalBodyForUser(
                            resId: resId,
                            isAdmin: false,
                            searchQuery: widget.searchQuery,
                          )
                        : VerticalMenuBody(
                            isAdmin: false,
                            resId: resId,
                            edit: false,
                            showRow: true,
                            searchQuery: widget.searchQuery,
                          );
                  },
                ),
              ),
            ),
          ],
        );
      },
        );
      },
    );
  }
}
