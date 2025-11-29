import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/client/home/data/models/get_nearby_response.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResturantDetailsRow extends StatelessWidget {
  const ResturantDetailsRow({
    super.key,
    required this.themeState,
    this.resturantAdmin,
    this.nearbyRestaurant,
  });

  final ThemeState themeState;
  final ResturantAdmin? resturantAdmin;
  final NearbyRestaurant? nearbyRestaurant;

  @override
  Widget build(BuildContext context) {
    final isNearby = nearbyRestaurant != null;
    final rate =
        isNearby
            ? (nearbyRestaurant?.rate.toString() ?? '4.7')
            : (resturantAdmin?.rate.toString() ?? '4.7');
    final deliveryCost =
        isNearby
            ? (nearbyRestaurant?.deliveryCost.toString() ?? AppStrings.free.tr())
            : (resturantAdmin?.deliveryCost.toString() ?? AppStrings.free.tr());

    return Row(
      children: [
        Icon(
          Icons.star_border,
          color:
              themeState.themeMode == ThemeMode.dark
                  ? AppColors.primaryDeafultDarkMode
                  : AppColors.primaryDeafult,
          size: 20,
        ),
        Text(rate.substring(0, 1), style: TextStyles.bimini16W700),
        horizontalSpace(20),
        Image.asset(
          AppImages.deliveryRed,
          width: 23.w,
          height: 16.h,
          color:
              themeState.themeMode == ThemeMode.dark
                  ? AppColors.primaryDeafultDarkMode
                  : null,
        ),
        horizontalSpace(5),
        Text(
          "15 min ",
          style: TextStyles.bimini14W400White.copyWith(
            color:
                themeState.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
          ),
        ),
        horizontalSpace(20),
        Icon(
          Icons.access_time,
          color:
              themeState.themeMode == ThemeMode.dark
                  ? AppColors.primaryDeafultDarkMode
                  : AppColors.primaryDeafult,
          size: 20,
        ),
        const SizedBox(width: 4),

        Text(
          "15",
          style: TextStyles.bimini14W400White.copyWith(
            color:
                themeState.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
          ),
        ),
        const SizedBox(width: 4),

        Text(
          AppStrings.min.tr(),
          style: TextStyles.bimini14W400White.copyWith(
            color:
                themeState.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
          ),
        ),
      ],
    );
  }
}
