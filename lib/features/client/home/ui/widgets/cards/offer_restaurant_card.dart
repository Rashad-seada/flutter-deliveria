import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/theme/color.dart';
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
class OfferRestaurantCard extends StatelessWidget {
  final RestaurantWithOffers offer;
  final ThemeState themeState;

  const OfferRestaurantCard({
    super.key,
    required this.offer,
    required this.themeState,
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

    return GestureDetector(
      onTap: () => _navigateToRestaurant(context),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with badges
            _buildImageSection(context, imageUrl, isDark, hasDiscount, hasOffers),
            // Restaurant info
            _buildInfoSection(context, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(
    BuildContext context,
    String imageUrl,
    bool isDark,
    bool hasDiscount,
    bool hasOffers,
  ) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: SizedBox(
            height: 150,
            width: double.infinity,
            child: imageUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: isDark ? Colors.grey[800] : Colors.grey[200],
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primaryDeafult,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => _buildFallbackImage(isDark),
                  )
                : Image.asset(AppImages.sliderOffers, fit: BoxFit.cover),
          ),
        ),

        // Gradient overlay for badge visibility
        if (hasDiscount || hasOffers) _buildGradientOverlay(),

        // Discount badge (Red) - Top Left
        if (hasDiscount) _buildDiscountBadge(),

        // Offers count badge (Primary) - Top Right
        if (hasOffers) _buildOffersCountBadge(),
      ],
    );
  }

  Widget _buildFallbackImage(bool isDark) {
    return Container(
      color: isDark ? Colors.grey[800] : Colors.grey[200],
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppImages.sliderOffers,
            fit: BoxFit.cover,
            opacity: const AlwaysStoppedAnimation(0.5),
          ),
          Center(
            child: Icon(
              Icons.store_rounded,
              size: 40,
              color: isDark ? Colors.white54 : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 60,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.4),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiscountBadge() {
    return Positioned(
      top: 12,
      left: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFE53935),
          borderRadius: BorderRadius.circular(12),
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
            const Icon(Icons.local_offer, color: Colors.white, size: 14),
            const SizedBox(width: 4),
            Text(
              '${offer.maxDiscount?.toInt()}% OFF',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOffersCountBadge() {
    return Positioned(
      top: 12,
      right: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primaryDeafult,
          borderRadius: BorderRadius.circular(12),
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
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, bool isDark) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.locale.languageCode == 'en'
                  ? (offer.name ?? '')
                  : (offer.nameAr ?? offer.name ?? ''),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.star_rounded, size: 18, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '${offer.rating ?? 4.5}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.grey[300] : Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark ? Colors.grey[600] : Colors.grey[400],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  offer.isOpen == true ? AppStrings.open.tr() : 'Closed',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: offer.isOpen == true ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
              loacationMap: "",
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
