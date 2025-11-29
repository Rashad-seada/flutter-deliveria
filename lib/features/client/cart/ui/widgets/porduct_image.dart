import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, this.img});
  final String? img;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 101.w,
      height: 109.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child:
          img != null
              ? CachedNetworkImage(imageUrl: "${ApiConstants.baseUrl}/$img" ,  placeholder: (context, url) => Center(child: CustomLoading()),
                errorWidget: (context, url, error) {
                  return Center(child: CustomLoading());
                },
              )
              : Image.asset(AppImages.burger),
    );
  }
}
