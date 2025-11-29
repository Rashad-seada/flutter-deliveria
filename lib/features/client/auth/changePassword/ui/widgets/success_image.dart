import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SuccessImage extends StatelessWidget {
  const SuccessImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        "assets/images/sucess.svg",
        width: 269.w,
        height: 240.h,
      ),
    );
  }
}
