import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/theme/animations.dart'; // [NEW]
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/client/fav/logic/cubit/favorite_cubit.dart';
import 'package:delveria/features/client/filter/logic/cubit/filter_category_cubit.dart';
import 'package:delveria/features/client/home/data/models/get_nearby_response.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_state.dart';
import 'package:delveria/features/client/home/ui/widgets/resturant_row_details.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/ui/resturant_screen.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildResturantCard extends StatefulWidget {
  const BuildResturantCard({
    super.key,
    required this.themeState,
    this.resturantAdmin,
    this.nearbyRestaurant,
    this.isTopTen = false,
    this.isSearch = false,
  });

  final ThemeState themeState;
  final ResturantAdmin? resturantAdmin;
  final NearbyRestaurant? nearbyRestaurant;
  final bool isTopTen;
  final bool isSearch;

  @override
  State<BuildResturantCard> createState() => _BuildResturantCardState();
}

class _BuildResturantCardState extends State<BuildResturantCard> {
  // Logic to determine if closed
  bool _isClosed() {
    final bool isOpen;
    if (widget.isSearch || widget.isTopTen) {
      isOpen = widget.resturantAdmin?.isOpen == true &&
          widget.resturantAdmin?.isShow == true;
    } else {
      isOpen = widget.nearbyRestaurant?.isOpen == true &&
          widget.nearbyRestaurant?.isShow == true;
    }
    return !isOpen;
  }

  @override
  Widget build(BuildContext context) {
    // Data Resolution
    final name = widget.isSearch || widget.isTopTen
        ? (widget.resturantAdmin?.name ?? AppStrings.quickFoodResturant.tr())
        : (widget.nearbyRestaurant?.name.isNotEmpty == true
            ? widget.nearbyRestaurant!.name
            : (widget.resturantAdmin?.name ?? AppStrings.quickFoodResturant.tr()));

    final photo = widget.isSearch || widget.isTopTen
        ? widget.resturantAdmin?.photo
        : (widget.nearbyRestaurant?.photo.isNotEmpty == true
            ? widget.nearbyRestaurant!.photo
            : widget.resturantAdmin?.photo);

    final resturantId = widget.isSearch || widget.isTopTen
        ? widget.resturantAdmin?.id
        : (widget.nearbyRestaurant?.id ?? widget.resturantAdmin?.id);

    final rating = widget.isSearch || widget.isTopTen
        ? (widget.resturantAdmin?.rate.toString() ?? "4.5")
        : (widget.nearbyRestaurant?.rate.toString() ?? "4.5");

    final isClosed = _isClosed();
    final isDark = widget.themeState.themeMode == ThemeMode.dark;

    return BlocBuilder<SlidersCubit, SlidersState>(
      builder: (context, state) {
        return ScaleOnTap(
          onTap: () {
            _navigateToDetails(context, resturantId);
          },
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              // 1. Background Content Box
              Container(
                width: double.infinity,
                // Adjust height dynamically or fixed based on usage? 
                // Using a relative height approach for broken grid
                height: 220.h,
                margin: EdgeInsets.only(top: 30.h, left: 10.w, right: 10.w, bottom: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  color: isDark ? AppColors.darkCharcoal : Colors.white, // safe fallback
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 130.h, left: 16.w, right: 16.w, bottom: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name,
                        style: TextStyles.bimini20W700.copyWith(
                          fontSize: 17.sp,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      ResturantDetailsRow(
                        themeState: widget.themeState,
                        resturantAdmin: (widget.isSearch || widget.isTopTen)
                            ? widget.resturantAdmin
                            : null,
                        nearbyRestaurant: (widget.isSearch || widget.isTopTen)
                            ? null
                            : widget.nearbyRestaurant,
                      ),
                    ],
                  ),
                ),
              ),

              // 2. Floating Image (Bleed)
              Positioned(
                top: 0, 
                // Inset logic: if we want it centered and floating
                left: 20.w, 
                right: 20.w,
                height: 150.h, 
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: (photo != null && photo.isNotEmpty)
                            ? CachedNetworkImage(
                                imageUrl: "${ApiConstants.baseUrl}/$photo",
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                errorWidget: (context, url, error) => Image.asset(
                                  AppImages.res,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.asset(AppImages.res, fit: BoxFit.cover),
                      ),
                    ),
                    
                    // Rating Badge - Top Right
                    Positioned(
                      top: 10.h,
                      right: 10.w,
                      child: _buildBadge(
                        child: Row(
                          children: [
                            Icon(Icons.star_rounded, color: Colors.amber, size: 14.sp),
                            SizedBox(width: 4.w),
                            Text(rating, style: TextStyles.bimini13W700Deafult.copyWith(color: Colors.black)), // Fixed style
                          ],
                        ),
                      ),
                    ),
                    
                    // Delivery Time - Top Left
                    Positioned(
                      top: 10.h,
                      left: 10.w,
                      child: _buildBadge(
                        color: AppColors.primaryDeafult,
                        child: Row(
                          children: [
                            Icon(Icons.access_time_rounded, color: Colors.white, size: 12.sp),
                            SizedBox(width: 4.w),
                            Text("20-30 min", style: TextStyles.bimini10W400Grey.copyWith(fontWeight: FontWeight.w500, color: Colors.white)), // Fixed style
                          ],
                        ),
                      ),
                    ),

                    if (isClosed)
                       Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Center(
                          child: Text(
                            "Closed",
                            style: TextStyles.bimini16W700BoldWhite, // Fixed style
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBadge({required Widget child, Color color = Colors.white}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  void _navigateToDetails(BuildContext context, String? resturantId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ResturantMenuCubit()),
            BlocProvider(create: (context) => getIt<ItemCubit>()),
            BlocProvider(create: (context) => getIt<AllresturantsadminCubit>()),
            BlocProvider(
              create: (context) => getIt<FilterCategoryCubit>()
                ..sortByPrice(resId: resturantId ?? ""),
            ),
            BlocProvider(create: (context) => getIt<FavoriteCubit>()),
          ],
          child: ResturantScreen(
            resturantAdmin: widget.resturantAdmin,
            nearbyRestaurant: widget.nearbyRestaurant,
            isTopTen: widget.isTopTen,
          ),
        ),
      ),
    );
  }
}
