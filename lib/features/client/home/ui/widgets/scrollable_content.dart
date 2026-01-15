import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/animations.dart';
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
  String? _selectedCategory; // [NEW]

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
                    final SlidersCubit cubit = context.read<SlidersCubit>(); // Get SlidersCubit instance
                    final showSliderSection = cubit.sliders.isNotEmpty; // Fixed: Check sliders, not restaurants
                    final AllresturantsadminCubit allResturantsCubit = context.read<AllresturantsadminCubit>(); // Get AllresturantsadminCubit instance
                    final superCategoriesCubit = context.read<AllresturantsadminCubit>(); // Assuming this is the cubit for super categories

                    return Column(
                      children: [
                        StaggeredSlideFade(
                          index: 0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: SearchBarSection(
                              themeState: widget.themeState,
                              lat: widget.lat,
                              long: widget.long,
                              onChanged: (value) async {
                                setState(() {
                                  query = value;
                                });
                                await context.read<SlidersCubit>().searchResturantUserSide(
                                  query: query,
                                  lat: widget.lat,
                                  long: widget.long,
                                );
                              },
                            ),
                          ),
                        ),
                        verticalSpace(15),
                        BlocBuilder<GetOrdersCubit, GetOrdersState>(
                          builder: (context, state) {
                            final orders = context.read<GetOrdersCubit>().orders;
                            final activeOrder = _findOngoingOrder(orders);
                            
                            if (activeOrder == null) return SizedBox.shrink();

                            return StaggeredSlideFade(
                              index: 1,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 15.h),
                                child: ActiveOrderTrackingBar(
                                  order: activeOrder,
                                  themeState: widget.themeState,
                                ),
                              ),
                            );
                          },
                        ),
                        if (showSliderSection) // Only show slider if there are sliders
                          StaggeredSlideFade(
                            index: 2,
                            child: SliderSection(
                              state: carouselState,
                              resId: restaurantsList.map((e) => e.id).toString(),
                              resturantAdmin: restaurantsList.cast(),
                            ),
                          ),
                        verticalSpace(10),
                        if (showSliderSection) // Only show dots if slider is shown
                          StaggeredSlideFade(
                            index: 3,
                            child: ReactiveDots(
                              state: carouselState,
                              themeState: widget.themeState,
                              cubit: context.read<SlidersCubit>(),
                            ),
                          ),
                        verticalSpace(20),
                        StaggeredSlideFade(
                          index: 4,
                          child: HomeCategoriesSection(
                            lat: widget.lat,
                            long: widget.long,
                            selectedCategoryName: _selectedCategory ?? "All",
                          ),
                        ),
                        verticalSpace(15),
                        if (query.isEmpty &&
                            (_selectedCategory == "All" || _selectedCategory == null) &&
                            cubit.restaurantsWithOffers.isNotEmpty)
                          StaggeredSlideFade(
                            index: 7,
                            child: HomeOffersSection(
                              themeState: widget.themeState,
                              isSearching: query.isNotEmpty,
                              lat: widget.lat,
                              long: widget.long,
                              onPageChanged: (index) => setState(() => _offersIndex = index),
                            ),
                          ),
                        if (query.isEmpty && (_selectedCategory == "All" || _selectedCategory == null))
                          verticalSpace(15),
                        StaggeredSlideFade(
                          index: 5,
                          child: HomeTopRestaurantsSection(
                            themeState: widget.themeState,
                            lat: widget.lat,
                            long: widget.long,
                            searchQuery: query,
                            onPageChanged: (index) => setState(() => _topRestIndex = index),
                          ),
                        ),
                        if (query.isEmpty && (_selectedCategory == "All" || _selectedCategory == null))
                          StaggeredSlideFade(
                            index: 6,
                            child: HomeNearbySection(
                              themeState: widget.themeState,
                              lat: widget.lat,
                              long: widget.long,
                              isSearching: query.isNotEmpty,
                              onPageChanged: (index) => setState(() => _nearbyRestIndex = index),
                            ),
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
