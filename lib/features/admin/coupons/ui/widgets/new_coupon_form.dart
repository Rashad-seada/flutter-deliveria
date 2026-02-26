import 'package:custom_form_w/custom_form_w.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewCouponForm extends StatelessWidget {
  const NewCouponForm({
    super.key, 
    required this.expDateController,  
    required this.onTap, 
    required this.couponeCodeController, 
    required this.discountController, 
    required this.validNumberController,
    required this.usagePerUserController,
    required this.minOrderValueController,
    required this.descriptionController,
    required this.onDiscountTypeChanged,
    required this.onCouponTypeChanged,
    required this.currentDiscountType,
    required this.currentCouponType,
  });

  final TextEditingController expDateController;
  final TextEditingController couponeCodeController;
  final TextEditingController discountController;
  final TextEditingController validNumberController;
  final TextEditingController usagePerUserController;
  final TextEditingController minOrderValueController;
  final TextEditingController descriptionController;
  final Function() onTap;
  final Function(String?) onDiscountTypeChanged;
  final Function(String?) onCouponTypeChanged;
  final String currentDiscountType;
  final String currentCouponType;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: couponeCodeController,
            headerText: AppStrings.couponCode.tr(),
            hint: AppStrings.enterCouponCode.tr(),
            hintStyle: TextStyles.bimini13W400Grey,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            headerTextStyle: TextStyles.bimini16W400Body,
          ),
          SizedBox(height: 24.h),
          
          // Coupon Type Dropdown
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.couponType.tr(), style: TextStyles.bimini16W400Body),
              SizedBox(height: 8.h),
              DropdownButtonFormField<String>(
                value: currentCouponType,
                items: ['promotional', 'points_reward', 'loyalty', 'seasonal']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type.tr()), // Ensure these keys exist or fallback to generic
                        ))
                    .toList(),
                onChanged: onCouponTypeChanged,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Discount Type and Value Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.discountType.tr(), style: TextStyles.bimini16W400Body),
                    SizedBox(height: 8.h),
                    DropdownButtonFormField<String>(
                      value: currentDiscountType,
                      items: ['bill', 'delivery']
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(type == 'bill' ? AppStrings.percentage.tr() : AppStrings.freeDelivery.tr()),
                              ))
                          .toList(),
                      onChanged: onDiscountTypeChanged,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ),
              if (currentDiscountType == 'bill') ...[
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: discountController,
                        headerText: AppStrings.discountValue.tr(),
                        hint: "%",
                        hintStyle: TextStyles.bimini13W400Grey,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                        headerTextStyle: TextStyles.bimini16W400Body,
                      ),
                       SizedBox(height: 4.h),
                       Text(AppStrings.valueHelper.tr(), style: TextStyles.bimini13W400Grey.copyWith(fontSize: 10.sp)),
                    ],
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 24.h),

          CustomTextField(
            controller: expDateController,
            readOnly: true,
            headerText: AppStrings.expDate.tr(),
            hint: AppStrings.selectExpDate.tr(),
            suffixIcon: GestureDetector(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Image.asset(AppImages.calender, width: 20.w, height: 20.h),
              ),
            ),
            hintStyle: TextStyles.bimini13W400Grey,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            headerTextStyle: TextStyles.bimini16W400Body,
          ),
          SizedBox(height: 24.h),

          // Usage Limits Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: validNumberController,
                      headerText: AppStrings.usageLimit.tr(),
                      hint: "Default: Unlimited",
                      hintStyle: TextStyles.bimini13W400Grey,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      headerTextStyle: TextStyles.bimini16W400Body,
                    ),
                    SizedBox(height: 4.h),
                    Text(AppStrings.usageLimitHelper.tr(), style: TextStyles.bimini13W400Grey.copyWith(fontSize: 10.sp)),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: usagePerUserController,
                      headerText: AppStrings.usagePerUserLimit.tr(),
                      hint: "Default: 1",
                      hintStyle: TextStyles.bimini13W400Grey,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      headerTextStyle: TextStyles.bimini16W400Body,
                    ),
                    SizedBox(height: 4.h),
                    Text(AppStrings.usagePerUserLimitHelper.tr(), style: TextStyles.bimini13W400Grey.copyWith(fontSize: 10.sp)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: minOrderValueController,
                headerText: AppStrings.minimumOrderValue.tr(),
                hint: "0",
                hintStyle: TextStyles.bimini13W400Grey,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                headerTextStyle: TextStyles.bimini16W400Body,
              ),
              SizedBox(height: 4.h),
              Text(AppStrings.minOrderValueHelper.tr(), style: TextStyles.bimini13W400Grey.copyWith(fontSize: 10.sp)),
            ],
          ),
          SizedBox(height: 24.h),

          CustomTextField(
            controller: descriptionController,
            maxLines: 3,
            headerText: AppStrings.description.tr(),
            hint: "Optional description",
            hintStyle: TextStyles.bimini13W400Grey,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            headerTextStyle: TextStyles.bimini16W400Body,
          ),
        ],
      ),
    );
  }
}
