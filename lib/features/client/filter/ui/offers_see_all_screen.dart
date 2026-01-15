import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/home/data/models/offers_response.dart';
import 'package:delveria/features/client/home/ui/widgets/cards/offer_restaurant_card.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Screen to display all restaurants with active offers in a grid
class OffersSeeAllScreen extends StatelessWidget {
  final ThemeState themeState;
  final List<RestaurantWithOffers> offersList;

  const OffersSeeAllScreen({
    super.key,
    required this.themeState,
    required this.offersList,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = themeState.themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkCharcoal : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkCharcoal : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.local_offer_rounded, color: Colors.red, size: 22.sp),
            SizedBox(width: 8.w),
            Text(
              AppStrings.discount.tr(),
              style: TextStyles.bimini20W700.copyWith(
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: offersList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_offer_outlined,
                    size: 80.sp,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No offers available',
                    style: TextStyles.bimini16W700.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: EdgeInsets.all(16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: 0.75, // Adjust for card height
              ),
              itemCount: offersList.length,
              itemBuilder: (context, index) {
                return OfferRestaurantCard(
                  offer: offersList[index],
                  themeState: themeState,
                  isGridItem: true,
                );
              },
            ),
    );
  }
}
