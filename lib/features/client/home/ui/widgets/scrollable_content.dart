import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_state.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_state.dart';
import 'package:delveria/features/client/home/ui/widgets/active_order_tracking_bar.dart';
import 'package:delveria/features/client/home/ui/widgets/reactive_dots.dart';
import 'package:delveria/features/client/home/ui/widgets/search_bar.dart';
import 'package:delveria/features/client/home/ui/widgets/sections/home_categories_section.dart';
import 'package:delveria/features/client/home/ui/widgets/sections/home_nearby_section.dart';
import 'package:delveria/features/client/home/ui/widgets/sections/home_offers_section.dart';
import 'package:delveria/features/client/home/ui/widgets/sections/home_top_restaurants_section.dart';
import 'package:delveria/features/client/home/ui/widgets/slider_section.dart';
import 'package:delveria/features/client/orders/logic/cubit/get_orders_cubit.dart';
import 'package:delveria/features/client/orders/logic/cubit/get_orders_state.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Main scrollable content for the home page
/// Composes multiple section widgets for a clean, modular structure
class ScrollableContent extends StatefulWidget {
  final ThemeState themeState;
  final double lat;
  final double long;
  final SlidersCubit cubit;

  const ScrollableContent({
    super.key,
    required this.themeState,
    required this.lat,
    required this.long,
    required this.cubit,
  });

  @override
  State<ScrollableContent> createState() => _ScrollableContentState();
}

class _ScrollableContentState extends State<ScrollableContent> {
  String query = "";
  int _topRestIndex = 0;
  int _nearbyRestIndex = 0;
  int _offersIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<SlidersCubit>().getRestaurantsWithOffers(
      lat: widget.lat,
      long: widget.long,
    );
  }

  String? _getValidSuperCategoryName(BuildContext context, String? prefName) {
    final cubit = context.read<AllresturantsadminCubit>();
    final superCategories = cubit.allSuperCategories;
    if (prefName == null || prefName.isEmpty) return null;
    final exists = superCategories.any(
      (cat) => cat.nameEn == prefName || cat.nameAr == prefName,
    );
    return exists ? prefName : null;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: BlocBuilder<CarouselCubit, CarouselState>(
          builder: (context, carouselState) {
            return BlocBuilder<SlidersCubit, SlidersState>(
              builder: (context, sliderState) {
                return BlocBuilder<AllresturantsadminCubit, AllresturantsadminState>(
                  builder: (context, adminState) {
                    final admin = context.read<AllresturantsadminCubit>();
                    final restaurantsList = admin.allResturants;
                    final showSliderSection = restaurantsList.isNotEmpty;

                    return Column(
                      children: [
                        // Search Bar
                        _buildSearchBar(),
                        verticalSpace(20),

                        // Active Order Tracking
                        _buildActiveOrderSection(),

                        // Hero Slider
                        _buildSliderSection(carouselState, restaurantsList, showSliderSection),
                        verticalSpace(20),

                        // Carousel Dots
                        ReactiveDots(
                          state: carouselState,
                          themeState: widget.themeState,
                          cubit: context.read<SlidersCubit>(),
                        ),
                        verticalSpace(20),

                        // Categories
                        _buildCategoriesSection(),
                        verticalSpace(20),

                        // Top Restaurants / Search Results
                        HomeTopRestaurantsSection(
                          themeState: widget.themeState,
                          lat: widget.lat,
                          long: widget.long,
                          searchQuery: query,
                          onPageChanged: (index) => setState(() => _topRestIndex = index),
                        ),

                        // Nearby Restaurants
                        HomeNearbySection(
                          themeState: widget.themeState,
                          lat: widget.lat,
                          long: widget.long,
                          isSearching: query.isNotEmpty,
                          onPageChanged: (index) => setState(() => _nearbyRestIndex = index),
                        ),

                        // Offers Section
                        HomeOffersSection(
                          themeState: widget.themeState,
                          isSearching: query.isNotEmpty,
                          onPageChanged: (index) => setState(() => _offersIndex = index),
                        ),

                        verticalSpace(80),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: SearchBarSection(
        themeState: widget.themeState,
        lat: widget.lat,
        long: widget.long,
        onChanged: (value) async {
          setState(() => query = value);
          await context.read<SlidersCubit>().searchResturantUserSide(
            query: query,
            lat: widget.lat,
            long: widget.long,
          );
        },
      ),
    );
  }

  Widget _buildActiveOrderSection() {
    return BlocBuilder<GetOrdersCubit, GetOrdersState>(
      builder: (context, orderState) {
        final ordersCubit = context.read<GetOrdersCubit>();
        final orders = ordersCubit.orders;
        
        final ongoingOrder = _findOngoingOrder(orders);
        
        if (ongoingOrder != null && _isOrderActive(ongoingOrder.status)) {
          return ActiveOrderTrackingBar(
            order: ongoingOrder,
            themeState: widget.themeState,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  dynamic _findOngoingOrder(List<dynamic> orders) {
    if (orders.isEmpty) return null;
    try {
      return orders.firstWhere(
        (o) => o.status != null && _isOrderActive(o.status),
      );
    } catch (e) {
      // No ongoing order found
      return null;
    }
  }

  bool _isOrderActive(String? status) {
    if (status == null) return false;
    final lowered = status.toLowerCase();
    return lowered != 'delivered' &&
           lowered != 'completed' &&
           lowered != 'done' &&
           lowered != 'canceled';
  }

  Widget _buildSliderSection(
    CarouselState state,
    List<dynamic> restaurantsList,
    bool showSliderSection,
  ) {
    if (showSliderSection) {
      return SliderSection(
        state: state,
        resId: restaurantsList.map((e) => e.id).toString(),
        resturantAdmin: restaurantsList.cast(),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildCategoriesSection() {
    return FutureBuilder<dynamic>(
      future: SharedPrefHelper.getString("name"),
      builder: (context, snapshot) {
        final selectedName = _getValidSuperCategoryName(
          context,
          snapshot.data as String?,
        );
        return HomeCategoriesSection(
          lat: widget.lat,
          long: widget.long,
          selectedCategoryName: selectedName,
        );
      },
    );
  }
}
