import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/super_categories_response.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesContainer extends StatelessWidget {
  final List<SuperCategoryInSuper> superCategories;
  final String selectedSuperCategoryName;
  final ValueChanged<String> onSuperCategoryChanged;

  const CategoriesContainer({
    super.key,
    required this.superCategories,
    required this.selectedSuperCategoryName,
    required this.onSuperCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: superCategories.length,
        itemBuilder: (context, index) {
          final category = superCategories[index];
          // Fix: isSelected must be a bool. Compare the correct value.
          final isSelected =
              context.locale.languageCode == "en"
                  ? category.nameEn == selectedSuperCategoryName
                  : category.nameAr == selectedSuperCategoryName;
          return GestureDetector(
            onTap:
                () => onSuperCategoryChanged(
                  context.locale.languageCode == "en"
                      ? category.nameEn
                      : category.nameAr,
                ),
            child: Container(
              margin: EdgeInsets.only(right: 15),
              child: Column(
                children: [
                  Container(
                    width: 49.w,
                    height: 62.h,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.pink : AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(25),
                      border:
                          isSelected
                              ? Border.all(
                                color: AppColors.primaryDeafult,
                                width: 2,
                              )
                              : null,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          category.logo.isNotEmpty
                              ? CachedNetworkImage(
                                imageUrl:
                                    "${ApiConstants.baseUrl}/${category.logo}",
                                width: 30.w,
                                placeholder:
                                    (context, url) =>
                                        Center(child: CustomLoading(size: 80)),
                                errorWidget: (context, url, error) {
                                  return Center(child: CustomLoading(size: 80));
                                },
                              )
                              : Icon(
                                Icons.category,
                                color: AppColors.darkBrown,
                              ),
                    ),
                  ),
                  SizedBox(height: 5),
                  BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, state) {
                      return Text(
                        context.locale.languageCode == "en"
                            ? category.nameEn
                            : category.nameAr,
                        style: TextStyles.bimini13W400Grey.copyWith(
                          color:
                              state.themeMode == ThemeMode.dark
                                  ? AppColors.lightGreySecond
                                  : AppColors.darkBrown,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
