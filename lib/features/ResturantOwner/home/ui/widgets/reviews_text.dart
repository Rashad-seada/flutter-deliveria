import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ReviewsText extends StatelessWidget {
  const ReviewsText({super.key, required this.reviews, required this.resId});
  final List<Review> reviews;
  final String resId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(AppStrings.reviews.tr(), style: TextStyles.bimini20W700),
        Row(
          spacing: 4,
          children: [
            GestureDetector(
              onTap: () {
                context.pushNamed(
                  Routes.resturantReviewScreen,
                  arguments: [reviews, resId, true],
                );
              },
              child: Text(
                AppStrings.seeAll.tr(),
                style: TextStyles.bimini14W400White.copyWith(
                  color: AppColors.grey,
                ),
              ),
            ),
            Icon(Icons.chevron_right, size: 16),
          ],
        ),
      ],
    );
  }
}
