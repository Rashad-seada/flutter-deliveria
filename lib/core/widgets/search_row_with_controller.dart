import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchRowWithController extends StatelessWidget {
  const SearchRowWithController({
    super.key,
    required this.controller,
    this.showButton = true,
    this.showOffers = false,
    this.resId,
    this.sortedPriceItems,
  });

  final TextEditingController controller;
  final bool showButton;
  final bool showOffers;
  final String? resId;
  final List? sortedPriceItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.w,
      height: 45.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grey),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: AppStrings.searchItem.tr(),
          hintStyle: TextStyles.bimini16W400Body,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AppImages.searchIcon, width: 20.w, height: 20.h),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }
}
