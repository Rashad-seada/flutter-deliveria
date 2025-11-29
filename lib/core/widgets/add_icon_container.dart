import 'package:delveria/core/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddIconContainer extends StatelessWidget {
  const AddIconContainer({super.key, this.edit,});
  final bool? edit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 24.w,
        height: 24.h,
        decoration: BoxDecoration(
          color: AppColors.primaryDeafult,
          shape: BoxShape.circle,
        ),
        child: Icon(
          edit == true ? Icons.edit : Icons.add,
          color: Colors.white,
          size: 16.sp,
        ),
      ),
    );
  }
}
