import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestPicksBody extends StatelessWidget {
  const BestPicksBody({super.key, this.icon, this.changeIcon});
  final String? icon;
  final bool? changeIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 135.w,
            margin: EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 84.h,
                  width: 135.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(AppImages.burger),
                  ),
                ),
                SizedBox(height: 8),
                Text(AppStrings.classicBurger.tr(), style: TextStyles.bimini16W700),
                SizedBox(height: 4),
                Text(
                  AppStrings.classicBurgerDes,
                  style: TextStyles.bimini16W400Body.copyWith(
                    color: AppColors.grey,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppStrings.le160.tr(), style: TextStyles.bimini16W700),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.primaryDeafult,
                        shape: BoxShape.circle,
                      ),
                      child:
                          changeIcon == true
                              ? Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Image.asset(
                                  icon ?? "",
                                  width: 10.w,
                                  height: 10.h,
                                ),
                              )
                              : Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 16.sp,
                              ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
