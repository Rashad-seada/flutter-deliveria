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
                itemCount: cubit.allItemsCategoriesUser.length,
                itemBuilder: (context, index) {
                  return buildCategoryTab(
                    context.locale.languageCode == "en"
                        ? cubit.allItemsCategoriesUser[index].nameEn
                        : cubit.allItemsCategoriesUser[index].nameAr,
                    cubit.isSelectedFilter == index,
                    () {
                      cubit.filterItemCategoriesUser(
                        cateId: cubit.allItemsCategoriesUser[index].id ?? "",
                        resId: cubit.allItemsCategoriesUser[index].restaurantId,
                      );
                      cubit.updateIsSelectedFilter(index);
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
                child:
                    showHorizontal
                        ? HorizentalBodyForUser(
                          resId:
                              cubit
                                  .allItemsCategoriesUser[cubit
                                      .isSelectedFilter]
                                  .restaurantId,
                          isAdmin: false,
                          searchQuery: widget.searchQuery,
                        )
                        : VerticalMenuBody(
                          isAdmin: false,
                          resId:
                              cubit
                                  .allItemsCategoriesUser[cubit
                                      .isSelectedFilter]
                                  .restaurantId,
                          edit: false,
                          showRow: true,
                          searchQuery: widget.searchQuery,
                        ),
              ),
            ),
          ],
        );
      },
    );
  }
}
