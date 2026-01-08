import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/network/api_constants.dart';
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
  bool _isPressed = false;

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
    final String name = widget.isSearch
        ? (widget.resturantAdmin?.name ?? AppStrings.quickFoodResturant.tr())
        : widget.isTopTen
            ? (widget.resturantAdmin?.name ?? AppStrings.quickFoodResturant.tr())
            : (widget.nearbyRestaurant?.name.isNotEmpty == true
                ? widget.nearbyRestaurant!.name
                : (widget.resturantAdmin?.name ?? AppStrings.quickFoodResturant.tr()));

    final String? photo = widget.isSearch
        ? widget.resturantAdmin?.photo
        : widget.isTopTen
            ? widget.resturantAdmin?.photo
            : (widget.nearbyRestaurant?.photo.isNotEmpty == true
                ? widget.nearbyRestaurant!.photo
                : widget.resturantAdmin?.photo);

    final String? resturantId = widget.isSearch
        ? widget.resturantAdmin?.id
        : widget.isTopTen
            ? widget.resturantAdmin?.id
            : (widget.nearbyRestaurant?.id != null
                ? widget.nearbyRestaurant!.id
                : widget.resturantAdmin?.id);

    final bool isClosed = _isClosed();
    final String rating = widget.isSearch
        ? (widget.resturantAdmin?.rate.toString() ?? "4.5")
        : widget.isTopTen
            ? (widget.resturantAdmin?.rate.toString() ?? "4.5")
            : (widget.nearbyRestaurant?.rate.toString() ?? "4.5");

    final isDark = widget.themeState.themeMode == ThemeMode.dark;

    return BlocBuilder<SlidersCubit, SlidersState>(
      builder: (context, state) {
        return GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          onTap: () {
            if (isClosed) return;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => ResturantMenuCubit()),
                    BlocProvider(create: (context) => getIt<ItemCubit>()),
                    BlocProvider(
                      create: (context) => getIt<AllresturantsadminCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => getIt<FilterCategoryCubit>()
                        ..sortByPrice(resId: resturantId ?? ""),
                    ),
                    BlocProvider(
                      create: (context) => getIt<FavoriteCubit>(),
                    ),
                  ],
                  child: ResturantScreen(
                    resturantAdmin: widget.resturantAdmin,
                    nearbyRestaurant: widget.nearbyRestaurant,
                    isTopTen: widget.isTopTen,
                  ),
                ),
              ),
            );
          },
          child: AnimatedScale(
            scale: _isPressed ? 0.97 : 1.0,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOutCubic,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r),
                color: isDark ? AppColors.darkGrey : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.2 : 0.08),
                    spreadRadius: 0,
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Section
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.r),
                          topRight: Radius.circular(18.r),
                        ),
                        child: SizedBox(
                          height: 145.h,
                          width: double.infinity,
                          child: (photo != null && photo.isNotEmpty)
                              ? CachedNetworkImage(
                                  imageUrl: "${ApiConstants.baseUrl}/$photo",
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    AppImages.sliderOffers,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.asset(AppImages.res, fit: BoxFit.cover),
                        ),
                      ),

                      // Rating Badge with enhanced styling
                      Positioned(
                        top: 12.h,
                        right: 12.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 16.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                rating,
                                style: TextStyles.bimini13W700Deafult.copyWith(
                                  color: Colors.black87,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Delivery Time Badge
                      Positioned(
                        top: 12.h,
                        left: 12.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryDeafult,
                            borderRadius: BorderRadius.circular(14.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryDeafult.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                color: Colors.white,
                                size: 14.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "20-30 min",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Closed Overlay with enhanced styling
                      if (isClosed)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.3),
                                  Colors.black.withOpacity(0.5),
                                ],
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18.r),
                                topRight: Radius.circular(18.r),
                              ),
                            ),
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryDeafult,
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  "Closed",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  // Details Section
                  Padding(
                    padding: EdgeInsets.all(14.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyles.bimini20W700.copyWith(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.h),
                        ResturantDetailsRow(
                          themeState: widget.themeState,
                          resturantAdmin: widget.isSearch
                              ? widget.resturantAdmin
                              : widget.isTopTen
                                  ? widget.resturantAdmin
                                  : null,
                          nearbyRestaurant: widget.isSearch
                              ? null
                              : widget.isTopTen
                                  ? null
                                  : widget.nearbyRestaurant,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
