import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NearbyText extends StatelessWidget {
  const NearbyText({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppStrings.nearby.tr(), style: TextStyles.bimini20W700),
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  AppStrings.seeAll.tr(),
                  style: TextStyles.bimini14W400White.copyWith(
                    color: AppColors.primaryDeafult,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: AppColors.primaryDeafult,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
