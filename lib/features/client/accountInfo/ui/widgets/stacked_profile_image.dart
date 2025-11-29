import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';

class StackedProfileImage extends StatelessWidget {
  const StackedProfileImage({
    super.key,
    this.themeState,
    this.isResturant,
    this.img,
  });
  final ThemeState? themeState;
  final bool? isResturant;
  final String? img;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: CircleAvatar(
            radius: 60,
            backgroundColor:
                themeState?.themeMode == ThemeMode.dark
                    ? AppColors.darkGrey
                    : Colors.grey[200],
            backgroundImage:
                (img != null && img!.isNotEmpty)
                    ? CachedNetworkImageProvider("${ApiConstants.baseUrl}/$img")
                    : isResturant == true
                    ? AssetImage(AppImages.logo) as ImageProvider
                    : AssetImage(AppImages.person) as ImageProvider,
          ),
        ),
        // isResturant == true
        //     ? SizedBox()
        //     : Positioned(
        //       bottom: 0,
        //       right: 0,
        //       child: Container(
        //         width: 36,
        //         height: 36,
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: AppColors.primaryDeafult,
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Image.asset(
        //             AppImages.editPenwhite,
        //             color: Colors.white,
        //             width: 16.w,
        //             height: 16.h,
        //           ),
        //         ),
        //       ),
        //     ),
      ],
    );
  }
}
