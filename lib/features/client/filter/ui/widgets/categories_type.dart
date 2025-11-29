import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/super_categories_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesType extends StatelessWidget {
  final List<SubCategory> subCategories;
  final String? selectedSubCategoryName;
  final ValueChanged<String> onSubCategoryChanged;

  const CategoriesType({
    super.key,
    required this.subCategories,
    required this.selectedSubCategoryName,
    required this.onSubCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: subCategories.length,
        itemBuilder: (context, index) {
          final subCategory = subCategories[index];
          final String subCategoryName = context.locale.languageCode == "en"
              ? subCategory.nameEn
              : subCategory.nameAr;
          final bool isSelected = subCategoryName == selectedSubCategoryName;
          return GestureDetector(
            onTap: () => onSubCategoryChanged(subCategoryName),
            child: Container(
              width: 105.w,
              height: 24.h,
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.pinkLight : AppColors.lightGrey,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Center(
                child: Text(
                  subCategoryName,
                  style: TextStyles.bimini13W400Grey.copyWith(
                    color: isSelected ? AppColors.primary : AppColors.grey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
