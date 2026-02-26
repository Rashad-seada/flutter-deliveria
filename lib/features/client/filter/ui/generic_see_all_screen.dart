import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/client/filter/ui/widgets/resturant_card.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A generic, reusable "See All" screen for displaying a list of restaurants in a grid.
/// Can be used for Discounts, Top Stores, Nearby, Best Sellers, etc.
class GenericSeeAllScreen extends StatelessWidget {
  final String title;
  final List<ResturantAdmin> restaurants;
  final IconData? titleIcon;
  final Color? titleIconColor;
  final bool isTopTen;

  const GenericSeeAllScreen({
    super.key,
    required this.title,
    required this.restaurants,
    this.titleIcon,
    this.titleIconColor,
    this.isTopTen = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
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
                if (titleIcon != null) ...[
                  Icon(titleIcon, color: titleIconColor ?? AppColors.primaryDeafult, size: 22.sp),
                  SizedBox(width: 8.w),
                ],
                Text(
                  title,
                  style: TextStyles.bimini20W700.copyWith(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            centerTitle: true,
          ),
          body: restaurants.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.store_mall_directory_outlined,
                        size: 80.sp,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No restaurants available',
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
                    childAspectRatio: 0.65,
                  ),
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = restaurants[index];
                    return RestaurantCard(
                      isUser: true,
                      isTopten: isTopTen,
                      resturantUser: restaurant,
                      restaurant: restaurant,
                      allowClosedNavigation: true,
                    );
                  },
                ),
        );
      },
    );
  }
}
