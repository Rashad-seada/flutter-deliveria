import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/ResturantOwner/resturantReviews/ui/widgets/review_item.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:flutter/material.dart';

class ResturantReviewsScreen extends StatelessWidget {
  const ResturantReviewsScreen({
    super.key,
    required this.reviews,
    required this.resId, required this.isResturant,
  });
  final List<Review> reviews;
  final String resId;
  final bool isResturant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: "Reviews",
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return ReviewItem(
                  date: review.id ?? '',
                  title: review.message ?? '',
                  rating: review.rate.toInt() ?? 0,
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 16),
            ),
          ),
          isResturant
              ? SizedBox()
              : Padding(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: AppButton(
                    title: "Add your reviews ",
                    onPressed: () {
                      context.pushNamed(
                        Routes.addReviewScreen,
                        arguments: resId,
                      );
                    },
                  ),
                ),
              ),
          verticalSpace(20),
        ],
      ),
    );
  }
}
