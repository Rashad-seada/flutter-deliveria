import 'package:delveria/core/helper/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CouponImage extends StatelessWidget {
  const CouponImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 119.w,
      height: 154.h,
      margin: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Image.asset(AppImages.couponeImg),
    );
  }
}
