import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizeOrderTextField extends StatelessWidget {
  const CustomizeOrderTextField({
    super.key,
    required this.state,
    required this.controller, this.hint,
  });
  final dynamic state;
  final TextEditingController controller;
  final String? hint;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 123.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grey.withValues(alpha: .5)),
      ),
      child: TextField(
        controller: controller,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: hint ?? AppStrings.customize.tr(),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
          hintStyle: TextStyles.bimini13W400Grey,
        ),
      ),
    );
  }
}
