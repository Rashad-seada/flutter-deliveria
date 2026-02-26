import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResturantStackedImage extends StatelessWidget {
  const ResturantStackedImage({super.key, this.img, this.logo, this.isOpen = true});
  final String? img;
  final String? logo;
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.h),
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(20.r),
            child:
                img != null
                    ? CachedNetworkImage(
                      imageUrl: "${ApiConstants.baseUrl}/$img",
                      placeholder:
                          (context, url) => Center(child: CustomLoading()),
                      errorWidget: (context, url, error) {
                        return Center(child: CustomLoading());
                      },
                    )
                    : Image.asset(AppImages.resturantImage),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 30.w,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            width: 50.w,
            height: 50.h,
            child:
                logo != null
                    ? CachedNetworkImage(
                       placeholder:
                          (context, url) => Center(child: CustomLoading()),
                      errorWidget: (context, url, error) {
                        return Center(child: CustomLoading());
                      },
                      imageUrl: "${ApiConstants.baseUrl}/$logo",
                    )
                    : null,
          ),
        ),
        Positioned(
          bottom: 2,
          left: 85.w,
          child: Row(
            spacing: 2,
            children: [
              Icon(
                Icons.circle, 
                color: isOpen ? AppColors.green : Colors.red, 
                size: 8.sp,
              ),
              Text(
                isOpen ? AppStrings.open.tr() : AppStrings.close.tr(),
                style: TextStyles.bimini10W400Grey.copyWith(
                  color: isOpen ? AppColors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
