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
import 'package:delveria/features/client/home/data/models/offers_response.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/ui/resturant_screen.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Restaurant card specifically designed for the Offers carousel
/// "Broken Grid" Design: Image bleeds outside the top of the card
class OfferRestaurantCard extends StatelessWidget {
  final RestaurantWithOffers offer;
  final ThemeState themeState;
  final bool isGridItem;

  const OfferRestaurantCard({
    super.key,
    required this.offer,
    required this.themeState,
    this.isGridItem = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = themeState.themeMode == ThemeMode.dark;

    // Resolve image URL
    final String? photoPath = offer.cover ?? offer.logo;
    final String imageUrl = (photoPath != null && photoPath.isNotEmpty)
        ? "${ApiConstants.baseUrl}/$photoPath"
        : "";

    final bool hasDiscount = (offer.maxDiscount ?? 0) > 0;
    final bool hasOffers = (offer.offersCount ?? 0) > 0;

    // Responsive sizes for grid vs carousel
    final cardHeight = isGridItem ? 160.h : 220.h;
    final topMargin = isGridItem ? 30.h : 40.h;
    final imageHeight = isGridItem ? 110.h : 160.h;
    final contentPaddingTop = isGridItem ? 90.h : 130.h;

    return ScaleOnTap(
      onTap: () => _navigateToRestaurant(context),
      child: Stack(
        clipBehavior: Clip.none, // Allow image bleed
        alignment: Alignment.bottomCenter,
        children: [
          // 1. Main Background Card (Offset from top)
          Container(
            height: cardHeight,
            width: double.infinity,
            margin: EdgeInsets.only(top: topMargin), 
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.circular(isGridItem ? 16.r : 24.r),
              boxShadow: [
                // Dual Logic Shadows
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                  blurRadius: isGridItem ? 12 : 20,
                  offset: Offset(0, isGridItem ? 6 : 10),
                ),
                BoxShadow(
                  color: (isDark ? Colors.white : Colors.black).withOpacity(0.02),
                  blurRadius: 5,
                  offset: const Offset(0, -2), // Subtle top light
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: contentPaddingTop, 
                left: isGridItem ? 10.w : 16.w, 
                right: isGridItem ? 10.w : 16.w, 
                bottom: isGridItem ? 8.h : 12.h,
              ),
              child: _buildInfoSection(context, isDark),
            ),
          ),

          // 2. Floating Image (Bleeds top)
          Positioned(
            top: 0,
            left: isGridItem ? 8.w : 12.w,
            right: isGridItem ? 8.w : 12.w,
            height: imageHeight,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(isGridItem ? 14.r : 20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: isGridItem ? 10 : 15,
                        offset: Offset(0, isGridItem ? 5 : 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: imageUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: (context, url) => Container(
                              color: isDark ? Colors.grey[800] : Colors.grey[200],
                            ), // Could use Shimmer here
                            errorWidget: (context, url, error) =>
                                _buildFallbackImage(isDark),
                          )
                        : Image.asset(AppImages.sliderOffers, fit: BoxFit.cover),
                  ),
                ),
                // Gradient for text readability if badges are here
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Badges
                if (hasDiscount) _buildDiscountBadge(),
                if (hasOffers) _buildOffersCountBadge(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackImage(bool isDark) {
    return Container(
      color: isDark ? Colors.grey[800] : Colors.grey[200],
      child: Center(
        child: Icon(
          Icons.store_rounded,
          size: 40.sp,
          color: isDark ? Colors.white54 : Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildDiscountBadge() {
    return Positioned(
      top: 12.h,
      left: 12.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: const Color(0xFFE53935),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.local_offer, color: Colors.white, size: 12.sp),
            SizedBox(width: 4.w),
            Text(
              '${offer.maxDiscount?.toInt()}% OFF',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOffersCountBadge() {
    return Positioned(
      top: 12.h,
      right: 12.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.primaryDeafult,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          '${offer.offersCount} ${AppStrings.items.tr()}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Name
        Text(
          context.locale.languageCode == 'en'
              ? (offer.name ?? '')
              : (offer.nameAr ?? offer.name ?? ''),
          style: TextStyles.bimini16W700.copyWith( // Fixed style
            fontSize: 17.sp,
            color: isDark ? Colors.white : Colors.black,
            height: 1.2,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8.h),
        
        // Rating & Status Row
        Row(
          children: [
            Icon(Icons.star_rounded, size: 18.sp, color: Colors.amber),
            SizedBox(width: 4.w),
            Text(
              '${offer.rating?.toStringAsFixed(1) ?? 4.5}',
              style: TextStyles.bimini14W500.copyWith(fontWeight: FontWeight.w600), // Fixed style
            ),
            SizedBox(width: 12.w),
            Container(
              width: 4.w,
              height: 4.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? Colors.grey[600] : Colors.grey[400],
              ),
            ),
            SizedBox(width: 12.w),
            // Status with "Pulse" dot if Open?
            if (offer.isOpen == true) ...[
               Container(
                width: 6.w,
                height: 6.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green, // "Neon" green equivalent
                  boxShadow: [
                    BoxShadow(color: Colors.green, blurRadius: 4, spreadRadius: 1),
                  ],
                ),
              ),
              SizedBox(width: 6.w),
            ],
            Text(
              offer.isOpen == true ? AppStrings.open.tr() : 'Closed',
              style: TextStyles.bimini12W400Grey.copyWith( // Fixed style
                color: offer.isOpen == true ? Colors.green : Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _navigateToRestaurant(BuildContext context) {
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
                ..sortByPrice(resId: offer.id ?? ""),
            ),
            BlocProvider(create: (context) => getIt<FavoriteCubit>()),
          ],
          child: ResturantScreen(
            resturantAdmin: ResturantAdmin(
              id: offer.id ?? "",
              name: offer.name ?? "",
              phone: "",
              aboutUs: "",
              rate: offer.rating ?? 4.5,
              deliveryCost: 0,
              locationMap: "",
              openHour: "",
              closeHour: "",
              haveDelivery: true,
              isShow: true,
              isShowInHome: true,
              createdAt: "",
              updatedAt: "",
              v: 0,
              isOpen: offer.isOpen ?? true,
              photo: offer.cover ?? offer.logo ?? "",
              logo: offer.logo ?? "",
              coordinates: Coordinates(latitude: 0.0, longitude: 0.0),
              superCategory: [],
              subCategory: [],
              reviews: [],
            ),
          ),
        ),
      ),
    );
  }
}
