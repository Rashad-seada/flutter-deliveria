import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResturantReviewAndName extends StatelessWidget {
  const ResturantReviewAndName({
    super.key,
    this.resName,
    this.showDelete,
    this.onDeleteTap,
    required this.reviews, required this.resId,
  });
  final String? resName;
  final bool? showDelete;
  final void Function()? onDeleteTap;
  final List<Review> reviews;
  final String resId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 220.w,
            child: Text(
              resName ?? AppStrings.quickFoodResturant.tr(),
              style: TextStyles.bimini20W700,
            ),
          ),
          showDelete == true
              ? GestureDetector(
                onTap: onDeleteTap,
                child: Image.asset(
                  AppImages.trach,
                  width: 20.w,
                  height: 20.h,
                  color: AppColors.primaryDeafult,
                ),
              )
              : GestureDetector(
                onTap: () {
                  context.pushNamed(
                    Routes.resturantReviewScreen,
                    arguments: [reviews , resId , false],
                  );
                },
                child: Text(
                  AppStrings.reviews.tr(),
                  style: TextStyles.bimini14W400White.copyWith(
                    color: AppColors.darkGrey,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.darkGrey,
                    decorationThickness: 5,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
