import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/lists.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/client/filter/ui/widgets/resturant_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FromNotificationResBody extends StatelessWidget {
  const FromNotificationResBody({super.key});

  @override
  Widget build(BuildContext context) {
       return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          canPop: true,
          showTitle: true,
          title:AppStrings.resturantsList.tr(),
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 40, horizontal: 16),
        child: Column(
          children: [
            Container(
              width: 343.w,
              height: 45.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.grey),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText:'searchbyuserphone'.tr(),
                  hintStyle: TextStyles.bimini16W400Body,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      AppImages.searchIcon,
                      width: 13.w,
                      height: 13.h,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
              ),
            ),
            verticalSpace(56),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.sendToAll.tr(), style: TextStyles.bimini16W700),
                Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    border: Border.all(
                      color: Colors.black.withValues(alpha: .3),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            verticalSpace(48),
            RestaurantCard(
              isFromNotification: true,
              isAdmin: true, isUser: false, isTopten: false,
            ),
            verticalSpace(70),
            AppButton(title: AppStrings.confirm.tr()),
          ],
        ),
      ),
    );
  
  }
}
