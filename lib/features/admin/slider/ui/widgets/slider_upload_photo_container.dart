import 'dart:io';

import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderUploadPhotoContainer extends StatelessWidget {
  const SliderUploadPhotoContainer({
    super.key,
    required this.cubit,
    required this.index,
  });

  final SlidersCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        dashPattern: [9, 7],
        color: AppColors.grey,
        strokeWidth: .3,
        padding: EdgeInsets.zero,
        radius: Radius.circular(10.r),
      ),
      child: Container(
        width: 111.w,
        height: 101.h,
        decoration: BoxDecoration(
          color: AppColors.lightGrey.withOpacity(.2),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child:
            cubit.selectedPhotos[index]?.path != null
                ? Image.file(
                  File(cubit.selectedPhotos[index]!.path),
                  fit: BoxFit.cover,
                  width: 111.w,
                  height: 101.h,
                )
                : Column(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.uploadPhoto,
                      width: 40.w,
                      height: 45.h,
                    ),
                    Text(AppStrings.add.tr(), style: TextStyles.bimini13W400Grey),
                  ],
                ),
      ),
    );
  }
}
