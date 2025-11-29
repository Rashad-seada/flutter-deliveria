import 'package:delveria/core/helper/lists.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/onboarding/ui/widgets/build_dots.dart';
import 'package:delveria/features/client/onboarding/ui/widgets/next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final int index;
  final int currentPage; 

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.index,
    required this.currentPage
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = index == currentPage;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 213.w,
            height: 346.h,
            margin: EdgeInsets.only(top: 70.h, bottom: 20.h),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColorContainer),
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: Image.asset(image, width: 213.w, height: 346.h),
            ),
          ),
          verticalSpace(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              AppLists.onboardingData.length,
              (dotIndex) => buildDot(index: dotIndex),
            ),
          ),
          verticalSpace(15),
          AnimatedOpacity(
            opacity:
                isActive
                    ? 1.0
                    : 0.0, 
            duration: const Duration(milliseconds: 300), 
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyles.bimini20W700,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(10),
                Text(
                  description,
                  style: TextStyles.bimini16W400Body,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(30),
                if (index == 2)
                  NextButton(), 
              ],
            ),
          ),
        
        ],
      ),
    );
  }
}
