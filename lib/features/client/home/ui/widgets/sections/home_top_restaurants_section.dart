import 'package:carousel_slider/carousel_slider.dart';
import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/animations.dart'; // [NEW] For Shimmer
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:delveria/features/client/filter/ui/rating_filter_screen.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/home/ui/widgets/build_resturant_card.dart';
import 'package:delveria/features/client/home/ui/widgets/shared/empty_restaurants_widget.dart';
import 'package:delveria/features/client/home/ui/widgets/top_resturants_text.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Top restaurants section with header and carousel
/// Also handles search results display when searching
class HomeTopRestaurantsSection extends StatelessWidget {
  final ThemeState themeState;
  final double lat;
  final double long;
  final String searchQuery;
  final ValueChanged<int>? onPageChanged;

  const HomeTopRestaurantsSection({
    super.key,
    required this.themeState,
    required this.lat,
    required this.long,
    this.searchQuery = "",
    this.onPageChanged,
  });

  bool get _isSearching => searchQuery.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        const SizedBox(height: 16),
        _isSearching ? _buildSearchResults(context) : _buildTopRatedCarousel(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return TopResturantText(
      showSeeAll: !_isSearching,
      title: _isSearching ? AppStrings.searchResults.tr() : AppStrings.top.tr(),
      themeState: themeState,
      onTap: () => _navigateToSeeAll(context),
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    final sliderCubit = context.read<SlidersCubit>();
    final searchResults = sliderCubit.searchResturant;

    if (searchResults.isEmpty) {
      return const EmptyRestaurantsWidget();
    }

    return CarouselSlider.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index, realIdx) {
        return BuildResturantCard(
          isSearch: true,
          themeState: themeState,
          isTopTen: true,
          resturantAdmin: searchResults[index],
        );
      },
      options: CarouselOptions(
        height: 280,
        enableInfiniteScroll: false,
        enlargeCenterPage: false,
        viewportFraction: 0.85,
      ),
    );
  }

  Widget _buildTopRatedCarousel(BuildContext context) {
    return BlocBuilder<AllresturantsadminCubit, AllresturantsadminState>(
      builder: (context, state) {
        // Show shimmer during loading
        if (state is RatedLoading) {
          return _buildShimmerCarousel();
        }
        
        final cubit = context.read<AllresturantsadminCubit>();
        final allRes = cubit.allRatedResturants;
        final showCount = allRes.length > 10 ? 10 : allRes.length;

        if (showCount == 0) {
          return const EmptyRestaurantsWidget();
        }

        return CarouselSlider.builder(
          itemCount: showCount,
          itemBuilder: (context, index, realIdx) {
            return BuildResturantCard(
              isSearch: false,
              themeState: themeState,
              isTopTen: true,
              resturantAdmin: allRes[index],
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

  void _navigateToSeeAll(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt<AllresturantsadminCubit>()
            ..getAllRatedResturantsForAdmin(lat, long),
          child: RatingFilterScreen(
            showTitle: false,
            isTopTen: true,
          ),
        ),
      ),
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
