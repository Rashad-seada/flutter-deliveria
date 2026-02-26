import 'package:carousel_slider/carousel_slider.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/animations.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_state.dart';
import 'package:delveria/features/client/home/ui/widgets/cards/offer_restaurant_card.dart';
import 'package:delveria/features/client/home/ui/widgets/shared/empty_restaurants_widget.dart';
import 'package:delveria/features/client/filter/ui/generic_see_all_screen.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Offers section with header and carousel
class HomeOffersSection extends StatelessWidget {
  final ThemeState themeState;
  final bool isSearching;
  final double lat;
  final double long;
  final ValueChanged<int>? onPageChanged;

  const HomeOffersSection({
    super.key,
    required this.themeState,
    this.isSearching = false,
    this.lat = 0.0,
    this.long = 0.0,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (isSearching) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        _buildHeader(context),
        const SizedBox(height: 16),
        _buildCarousel(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isDark = themeState.themeMode == ThemeMode.dark;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title with accent decoration
          Row(
            children: [
              Container(
                width: 4.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 10.w),
              Icon(Icons.local_offer_rounded, color: Colors.red, size: 20.sp),
              SizedBox(width: 6.w),
              Text(
                AppStrings.discount.tr(),
                style: TextStyles.bimini20W700.copyWith(
                  fontSize: 19.sp,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          // See All button
          GestureDetector(
            onTap: () => _navigateToSeeAll(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.red.withOpacity(0.15)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.seeAll.tr(),
                    style: TextStyles.bimini14W400White.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12.sp,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToSeeAll(BuildContext context) {
    final sliderCubit = context.read<SlidersCubit>();
    final offersList = sliderCubit.restaurantsWithOffers;
    
    // Convert to ResturantAdmin list for generic screen
    final restaurants = offersList.map((offer) => offer.toResturantAdmin()).toList();
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GenericSeeAllScreen(
          title: AppStrings.discount.tr(),
          restaurants: restaurants,
          titleIcon: Icons.local_offer_rounded,
          titleIconColor: Colors.red,
        ),
      ),
    );
  }

  Widget _buildCarousel(BuildContext context) {
    return BlocBuilder<SlidersCubit, SlidersState>(
      builder: (context, state) {
        // Show shimmer during loading
        if (state is Loading) {
          return _buildShimmerCarousel();
        }
        
        final sliderCubit = context.read<SlidersCubit>();
        final offersList = sliderCubit.restaurantsWithOffers;

        if (offersList.isEmpty) {
          return const EmptyRestaurantsWidget();
        }

        return CarouselSlider.builder(
          itemCount: offersList.length,
          itemBuilder: (context, index, realIdx) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: OfferRestaurantCard(
                offer: offersList[index],
                themeState: themeState,
              ),
            );
          },
          options: CarouselOptions(
            height: 280,
            enableInfiniteScroll: false,
            enlargeCenterPage: false,
            viewportFraction: 0.85,
            onPageChanged: (index, reason) => onPageChanged?.call(index),
          ),
        );
      },
    );
  }

  Widget _buildShimmerCarousel() {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 3,
        itemBuilder: (context, index) => const ShimmerRestaurantCard(),
      ),
    );
  }
}
