import 'package:carousel_slider/carousel_slider.dart';

import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/client/home/data/models/best_sellers_response.dart' hide Coordinates;
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/home/ui/widgets/build_resturant_card.dart';
import 'package:delveria/features/client/home/ui/widgets/top_resturants_text.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Best Sellers section for home page
/// Displays top restaurants by completed orders in a carousel
/// Designed to match Top 10 Stores visual style
class HomeBestSellersSection extends StatelessWidget {
  final ThemeState themeState;
  final double lat;
  final double long;

  const HomeBestSellersSection({
    super.key,
    required this.themeState,
    required this.lat,
    required this.long,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SlidersCubit>();
    final bestSellers = cubit.bestSellers;

    if (bestSellers.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        SizedBox(height: 16.h),
        _buildCarousel(context, bestSellers),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return TopResturantText(
      showSeeAll: false, // Hide see all for now as irrelevant
      title: "Best Sellers".tr(),
      themeState: themeState,
    );
  }

  Widget _buildCarousel(
    BuildContext context,
    List<BestSellerRestaurant> bestSellers,
  ) {
    // Limit to top 10 if not already limited by API
    final showCount = bestSellers.length > 10 ? 10 : bestSellers.length;

    return CarouselSlider.builder(
      itemCount: showCount,
      itemBuilder: (context, index, realIdx) {
        final restaurant = bestSellers[index];
        final resturantAdmin = _mapToResturantAdmin(restaurant);

        return BuildResturantCard(
          isSearch: false,
          themeState: themeState, // Pass themeState
          isTopTen: true, // Use Top 10 styling
          resturantAdmin: resturantAdmin,
        );
      },
      options: CarouselOptions(
        height: 280.h,
        enableInfiniteScroll: false,
        enlargeCenterPage: false,
        viewportFraction: 0.85,
      ),
    );
  }

  ResturantAdmin _mapToResturantAdmin(BestSellerRestaurant restaurant) {
    // Import the Coordinates from the correct package
    final coords = Coordinates(
      latitude: restaurant.coordinates?.latitude ?? 0.0,
      longitude: restaurant.coordinates?.longitude ?? 0.0,
    );
    
    return ResturantAdmin(
      coordinates: coords,
      id: restaurant.id ?? "",
      photo: restaurant.photo ?? "",
      logo: restaurant.logo ?? "",
      superCategory: [],
      subCategory: [],
      name: restaurant.name ?? "",
      phone: "",
      aboutUs: restaurant.aboutUs ?? "",
      rate: restaurant.effectiveRating,
      reviews: [],
      deliveryCost: (restaurant.deliveryCost ?? 0).toDouble(),
      locationMap: "",
      openHour: restaurant.openHour ?? "",
      closeHour: restaurant.closeHour ?? "",
      haveDelivery: restaurant.haveDelivery ?? false,
      isShow: true,
      isShowInHome: true,
      estimatedTime: restaurant.estimatedTime ?? 30,
      createdAt: "",
      updatedAt: "",
      v: 0,
      isOpen: restaurant.isOpen ?? false,
    );
  }
}
