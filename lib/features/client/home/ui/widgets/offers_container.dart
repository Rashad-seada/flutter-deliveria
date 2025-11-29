import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OffersContainer extends StatelessWidget {
  const OffersContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      bottom: 0,
      child: Container(
        width: 170.w,
        height: 200.h,
        decoration: BoxDecoration(
          color: AppColors.pink,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            bottomLeft: Radius.circular(30.r),
            topRight: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r)
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.quickFoodOffers.tr(),
              style: TextStyles.bimini12W400Grey.copyWith(color: Colors.white),
            ),
            Text(AppStrings.get25Offer.tr(), style: TextStyles.bimini32W400White),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              width: 107.w,
              height: 35.h,
              child: Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.grabOffer,
                    style: TextStyles.bimini14W400White.copyWith(
                      color: AppColors.green,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15.sp,
                    color: AppColors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
