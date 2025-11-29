import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/search_row.dart';
import 'package:delveria/features/client/filter/ui/widgets/resturants_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RatingFilterScreen extends StatelessWidget {
  const RatingFilterScreen({super.key, this.showTitle,  this.isTopTen});
  final bool? showTitle;
  final bool? isTopTen;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            verticalSpace(20),
            SearchRow(
              showButton: false,
              showIosArrow: true,
              showSearchContainer: false,
              title: AppStrings.topRated.tr(),
            ),

            verticalSpace(30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showTitle == true
                      ? Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: AppStrings.ratedResturants.tr(),
                              style: TextStyles.bimini20W700,
                            ),
                            TextSpan(
                              text: AppStrings.heighstRating.tr(),
                              style: TextStyles.bimini18W700,
                            ),
                          ],
                        ),
                      )
                      : SizedBox(),
                ],
              ),
            ),

            SizedBox(height: 20),

            ResturantsList(isTopTen: isTopTen??false),
          ],
        ),
      ),
    );
  }
}
