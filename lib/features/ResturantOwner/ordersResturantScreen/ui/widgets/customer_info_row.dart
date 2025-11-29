import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerInfoRow extends StatelessWidget {
  const CustomerInfoRow({super.key, this.address, this.name, this.phone});
  final String? address;
  final String? name;
  final String? phone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25.r,
          backgroundColor: AppColors.userBackGroundColor.withValues(alpha: .2),
          child: Image.asset(AppImages.logo, width: 32.w, height: 32.h),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name?? AppStrings.name.tr(), style: TextStyles.bimini16W700),
            const SizedBox(height: 4),
            SizedBox(
              width: 210.w,
              child: Text(
                address ?? AppStrings.address.tr(),
                style: TextStyles.bimini13W400Grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              phone ?? "phone",
              style: TextStyles.bimini13W400Grey,
            ),
          ],
        ),
      ],
    );
  }
}
