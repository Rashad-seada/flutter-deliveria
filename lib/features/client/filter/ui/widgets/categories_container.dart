import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/theme/animations.dart'; // [NEW]
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/helper/spacing.dart'; // [NEW]
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
      height: 110.h, // Increased slightly for spring effect
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: superCategories.length,
        itemBuilder: (context, index) {
          final category = superCategories[index];
          final isEn = context.locale.languageCode == "en";
          final categoryName = isEn ? category.nameEn : category.nameAr;
          final isSelected = categoryName == selectedSuperCategoryName;

          return Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: ScaleOnTap(
              onTap: () => onSuperCategoryChanged(categoryName),
              enableHaptic: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min, // Fixed: Prevent infinite expansion
                children: [
                  // Icon/Image
                  AnimatedContainer(
                    duration: AppAnimations.modalSpringDuration,
                    curve: Curves.easeOutCubic, // Fixed: Use stable curve instead of elasticOut
                    width: isSelected ? 55.w : 49.w,
                    height: isSelected ? 68.h : 62.h,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: category.logo.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: "${ApiConstants.baseUrl}/${category.logo}",
                              fit: BoxFit.contain,
                              placeholder: (context, url) =>
                                  const Center(child: CustomLoading(size: 20)),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error, size: 20),
                            )
                          : Icon(
                              Icons.category,
                              color: isSelected 
                                  ? AppColors.primaryDeafult 
                                  : AppColors.darkBrown,
                              size: isSelected ? 32.sp : 26.sp,
                            ),
                    ),
                  ),
                  
                  verticalSpace(4),
                  
                  // Text
                  BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, state) {
                      final isDark = state.themeMode == ThemeMode.dark;
                      return AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyles.bimini13W400Grey.copyWith(
                          color: isSelected
                              ? AppColors.primaryDeafult
                              : (isDark ? AppColors.lightGreySecond : AppColors.darkBrown),
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                          fontSize: isSelected ? 14.sp : 13.sp,
                        ),
                        child: Text(categoryName),
                      );
                    },
                  ),
                  
                  verticalSpace(4),
                  
                  // Sliding Underline Indicator - Fixed: No animation of boxShadow list length
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic, // Fixed: Use stable curve
                    height: 3.h,
                    width: isSelected ? 20.w : 0,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryDeafult : Colors.transparent,
                      borderRadius: BorderRadius.circular(10.r),
                      // Fixed: Always have same number of shadows, just toggle opacity
                      boxShadow: [
                        BoxShadow(
                          color: isSelected 
                              ? AppColors.primaryDeafult.withOpacity(0.4)
                              : Colors.transparent,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
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
