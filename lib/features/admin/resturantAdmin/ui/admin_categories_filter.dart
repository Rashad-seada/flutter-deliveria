import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/lists.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/search_row.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/categories_type_container.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/restaurant_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminCategoriesFilter extends StatelessWidget {
  const AdminCategoriesFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            verticalSpace(24),
            SearchRow(showButton: true, isAdmin: true),
            verticalSpace(35),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AppImages.sqaureIcon,
                          width: 24.w,
                          height: 24.h,
                        ),
                        SizedBox(width: 8),
                        Text(
                          AppStrings.resturantsCategories.tr(),
                          style: TextStyles.bimini20W700,
                        ),
                      ],
                    ),

                    verticalSpace(32),
                    CategoriesTypeContainer(),
                    verticalSpace(24),
                    ...AppLists.restaurantsAdmin.asMap().entries.map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: RestaurantCard(index: entry.key),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
