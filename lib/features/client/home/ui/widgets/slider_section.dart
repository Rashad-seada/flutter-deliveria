import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/theme/animations.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/client/fav/logic/cubit/favorite_cubit.dart';
import 'package:delveria/features/client/filter/logic/cubit/filter_category_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_state.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_state.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/ui/resturant_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Optimized slider/banner section following Flutter best practices:
/// - Uses const constructors where possible
/// - Extracts item builder into separate widget to prevent rebuilds
/// - Uses RepaintBoundary for isolation
/// - Caches decorations as static constants
/// - Uses buildWhen to prevent unnecessary rebuilds
class SliderSection extends StatelessWidget {
  const SliderSection({
    super.key,
    required this.state,
    required this.resId,
    required this.resturantAdmin,
  });

  final CarouselState state;
  final String resId;
  final List<ResturantAdmin> resturantAdmin;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SlidersCubit, SlidersState>(
      // Only rebuild when loading state changes, not on every state update
      buildWhen: (previous, current) =>
          (previous is Loading) != (current is Loading),
      builder: (context, sliderState) {
        if (sliderState is Loading) {
          return const ShimmerBanner();
        }

        final cubit = context.read<SlidersCubit>();
        final sliders = cubit.sliders;

        if (sliders.isEmpty) {
          return const SizedBox.shrink();
        }

        return RepaintBoundary(
          child: CarouselSlider.builder(
            carouselController: state.carouselSliderController,
            itemCount: sliders.length,
            itemBuilder: (context, index, realIdx) {
              return _SliderItem(
                key: ValueKey(sliders[index].id ?? index),
                slider: sliders[index],
                isActive: state.currentPage == index,
                resId: resId,
                resturantAdmin: resturantAdmin,
              );
            },
            options: CarouselOptions(
              height: 165.h,
              viewportFraction: 0.92,
              enableInfiniteScroll: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.12,
              onPageChanged: (index, reason) {
                context.read<CarouselCubit>().updateCurrentPage(index);
              },
              initialPage: state.currentPage,
              scrollPhysics: const BouncingScrollPhysics(),
            ),
          ),
        );
      },
    );
  }
}

/// Extracted slider item widget for better performance
/// - Prevents full carousel rebuild when only one item changes
/// - Uses const constructors for static decorations
/// - Implements RepaintBoundary for paint isolation
class _SliderItem extends StatelessWidget {
  const _SliderItem({
    super.key,
    required this.slider,
    required this.isActive,
    required this.resId,
    required this.resturantAdmin,
  });

  final dynamic slider;
  final bool isActive;
  final String resId;
  final List<ResturantAdmin> resturantAdmin;

  // Cached static decorations to avoid recreation
  static final _borderRadius = BorderRadius.circular(20);
  static final _boxShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 12,
      offset: const Offset(0, 6),
    ),
  ];
  static const _gradientColors = [
    Colors.transparent,
    Colors.transparent,
    Color(0x4D000000), // Colors.black.withOpacity(0.3) pre-computed
  ];
  static const _gradientStops = [0.0, 0.6, 1.0];

  void _navigateToRestaurant(BuildContext context) {
    final restaurant = resturantAdmin.firstWhere(
      (e) => e.id == slider.restaurantId,
      orElse: () => resturantAdmin.first,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ResturantMenuCubit()),
            BlocProvider(create: (_) => getIt<ItemCubit>()),
            BlocProvider(create: (_) => getIt<AllresturantsadminCubit>()),
            BlocProvider(
              create: (_) => getIt<FilterCategoryCubit>()
                ..sortByPrice(resId: resId),
            ),
            BlocProvider(create: (_) => getIt<FavoriteCubit>()),
          ],
          child: ResturantScreen(resturantAdmin: restaurant),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: () => _navigateToRestaurant(context),
        child: AnimatedScale(
          scale: isActive ? 1.0 : 0.95,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            decoration: BoxDecoration(
              borderRadius: _borderRadius,
              boxShadow: _boxShadow,
            ),
            child: ClipRRect(
              borderRadius: _borderRadius,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Main Image - using memCacheWidth for memory optimization
                  CachedNetworkImage(
                    imageUrl: "${ApiConstants.baseUrl}/${slider.image}",
                    fit: BoxFit.cover,
                    memCacheWidth: 800, // Limit cache size for memory
                    fadeInDuration: const Duration(milliseconds: 200),
                    fadeOutDuration: const Duration(milliseconds: 200),
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, size: 40),
                    ),
                  ),
                  // Gradient Overlay - using const decoration
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: _gradientColors,
                        stops: _gradientStops,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
