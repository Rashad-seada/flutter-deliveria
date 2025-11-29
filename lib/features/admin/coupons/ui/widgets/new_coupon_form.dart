import 'package:custom_form_w/custom_form_w.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewCouponForm extends StatelessWidget {
  const NewCouponForm({super.key, required this.expDateController,  required this.onTap, required this.couponeCodeController, required this.discountController, required this.validNumberController});
  final TextEditingController expDateController;
  final TextEditingController couponeCodeController;
  final TextEditingController discountController;
  final TextEditingController validNumberController;
  final   Function() onTap ;

  @override
  Widget build(BuildContext context) {
    return CustomFormW(
      showButton: false,
      spaceHeaders: 8.h,
      spacing: 32.h,
      padding: EdgeInsetsGeometry.zero,
      children: [
        CustomTextField(
          controller: couponeCodeController,
          headerText: AppStrings.couponCode.tr(),
          hint: AppStrings.enterCouponCode,
          hintStyle: TextStyles.bimini13W400Grey,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          headerTextStyle: TextStyles.bimini16W400Body,
        ),
        CustomTextField(
          controller: discountController,
          headerText: AppStrings.discountPercent.tr(),
          hint: AppStrings.enterPercent.tr(),
          hintStyle: TextStyles.bimini13W400Grey,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          headerTextStyle: TextStyles.bimini16W400Body,
        ),
        CustomTextField(
          controller: expDateController,
          readOnly: true,
          headerText: AppStrings.expDate.tr(),
          hint: AppStrings.selectExpDate.tr(),

          suffixIcon: GestureDetector(
            onTap:onTap,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Image.asset(AppImages.calender, width: 20.w, height: 20.h),
            ),
          ),
          hintStyle: TextStyles.bimini13W400Grey,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          headerTextStyle: TextStyles.bimini16W400Body,
        ),
        CustomTextField(
          controller: validNumberController,
          headerText: "Number of valid for users",
          hint: "Enter Number of valid for users",
          hintStyle: TextStyles.bimini13W400Grey,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          headerTextStyle: TextStyles.bimini16W400Body,
        ),
      ],
    );
  }
}
