import 'package:delveria/core/helper/lists.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesTypeContainer extends StatelessWidget {
  const CategoriesTypeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppLists.categoriesType.length,
        itemBuilder: (context, index) {
          bool isSelected = index == 0;
          return Container(
            height: 24.h,
            margin: EdgeInsets.only(right: 10),

            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.pinkLight : AppColors.lightGrey,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Center(
              child: Text(
                AppLists.categoriesType[index],
                style: TextStyles.bimini13W400Grey.copyWith(
                  color: isSelected ? AppColors.primary : AppColors.grey,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
