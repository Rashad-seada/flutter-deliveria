import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadPhotoContainer extends StatelessWidget {
  const UploadPhotoContainer({
    super.key,
    this.onTap,
    required this.isLogo,
    this.itemCubit,
    this.itemImage,
    this.itemImageUrl,
  });
  final void Function()? onTap;
  final bool isLogo;
  final ItemCubit? itemCubit;
  final bool? itemImage;
  final String? itemImageUrl;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllresturantsadminCubit, AllresturantsadminState>(
      builder: (context, state) {
        final cubit = context.read<AllresturantsadminCubit>();

        String? imagePath;
        if (isLogo) {
          if (cubit.selectedLogo != null &&
              cubit.selectedLogo!.path.isNotEmpty) {
            imagePath = cubit.selectedLogo!.path;
          }
        } else {
          if (itemCubit?.selectedPhoto != null &&
              !(itemCubit?.selectedPhoto?.path.isNullOrEmpty() ?? true)) {
            imagePath = itemCubit!.selectedPhoto!.path;
          } else if (cubit.selectedPhoto != null &&
              cubit.selectedPhoto!.path.isNotEmpty) {
            imagePath = cubit.selectedPhoto!.path;
          }
        }

        return GestureDetector(
          onTap: onTap,
          child: DottedBorder(
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
                color: AppColors.lightGrey.withValues(alpha: .2),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child:
                  itemImage == true
                      ? CachedNetworkImage(
                        imageUrl: itemImageUrl ?? "",
                       placeholder:
                            (context, url) => Center(child: CustomLoading()),
                        errorWidget: (context, url, error) {
                          return Center(child: CustomLoading());
                        },
                      )
                      : imagePath != null
                      ? Image.asset(imagePath)
                      : Column(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.uploadPhoto,
                            width: 40.w,
                            height: 45.h,
                          ),
                          Text(
                            AppStrings.add.tr(),
                            style: TextStyles.bimini13W400Grey,
                          ),
                        ],
                      ),
            ),
          ),
        );
      },
    );
  }
}
