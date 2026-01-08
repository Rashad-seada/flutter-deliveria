import 'package:carousel_slider/carousel_slider.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/home/ui/widgets/cards/offer_restaurant_card.dart';
import 'package:delveria/features/client/home/ui/widgets/shared/empty_restaurants_widget.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Offers section with header and carousel
class HomeOffersSection extends StatelessWidget {
  final ThemeState themeState;
  final bool isSearching;
  final ValueChanged<int>? onPageChanged;

  const HomeOffersSection({
    super.key,
    required this.themeState,
    this.isSearching = false,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (isSearching) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        _buildHeader(),
        const SizedBox(height: 16),
        _buildCarousel(context),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
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
    );
  }

  Widget _buildCarousel(BuildContext context) {
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
  }
}
