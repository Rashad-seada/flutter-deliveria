import 'package:carousel_slider/carousel_slider.dart';
import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:delveria/features/client/filter/ui/nearby_see_all_screen.dart';
import 'package:delveria/features/client/home/ui/widgets/build_resturant_card.dart';
import 'package:delveria/features/client/home/ui/widgets/nearby_text.dart';
import 'package:delveria/features/client/home/ui/widgets/shared/empty_restaurants_widget.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Nearby restaurants section with header and carousel
class HomeNearbySection extends StatelessWidget {
  final ThemeState themeState;
  final double lat;
  final double long;
  final bool isSearching;
  final ValueChanged<int>? onPageChanged;

  const HomeNearbySection({
    super.key,
    required this.themeState,
    required this.lat,
    required this.long,
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
        _buildHeader(context),
        const SizedBox(height: 16),
        _buildCarousel(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return NearbyText(
      onTap: () => _navigateToSeeAll(context),
    );
  }

  Widget _buildCarousel(BuildContext context) {
    return BlocBuilder<AllresturantsadminCubit, AllresturantsadminState>(
      builder: (context, state) {
        final cubit = context.read<AllresturantsadminCubit>();
        final nearbyList = cubit.allNearbyResturant;

        if (nearbyList.isEmpty) {
          return const EmptyRestaurantsWidget();
        }

        return CarouselSlider.builder(
          itemCount: nearbyList.length,
          itemBuilder: (context, index, realIdx) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: BuildResturantCard(
                isTopTen: false,
                themeState: themeState,
                nearbyRestaurant: nearbyList[index],
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

  void _navigateToSeeAll(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt<AllresturantsadminCubit>()
            ..getNearbyResturants(lat: lat, long: long),
          child: NearbySeeAllScreen(),
        ),
      ),
    );
  }
}
