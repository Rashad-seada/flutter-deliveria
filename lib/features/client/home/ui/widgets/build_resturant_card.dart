import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/client/fav/logic/cubit/favorite_cubit.dart';
import 'package:delveria/features/client/filter/logic/cubit/filter_category_cubit.dart';
import 'package:delveria/features/client/home/data/models/get_nearby_response.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_state.dart';
import 'package:delveria/features/client/home/ui/widgets/resturant_row_details.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/ui/resturant_screen.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildResturantCard extends StatelessWidget {
  const BuildResturantCard({
    super.key,
    required this.themeState,
    this.resturantAdmin,
    this.nearbyRestaurant,
    this.isTopTen = false,
    this.isSearch = false,
  });

  final ThemeState themeState;
  final ResturantAdmin? resturantAdmin;
  final NearbyRestaurant? nearbyRestaurant;
  final bool isTopTen;
  final bool isSearch;

  bool _isClosed() {
    // Use the same logic as in @file_context_0
    final bool isOpen;
    if (isSearch || isTopTen) {
      isOpen = resturantAdmin?.isOpen == true && resturantAdmin?.isShow == true;
    } else {
      isOpen =
          nearbyRestaurant?.isOpen == true && nearbyRestaurant?.isShow == true;
    }
    return !isOpen;
  }

  @override
  Widget build(BuildContext context) {
    final String name = isSearch
        ? (resturantAdmin?.name ?? AppStrings.quickFoodResturant.tr())
        : isTopTen
            ? (resturantAdmin?.name ?? AppStrings.quickFoodResturant.tr())
            : (nearbyRestaurant?.name.isNotEmpty == true
                ? nearbyRestaurant!.name
                : (resturantAdmin?.name ?? AppStrings.quickFoodResturant.tr()));

    final String aboutUs = isSearch
        ? (resturantAdmin?.aboutUs ?? AppStrings.quickDetails.tr())
        : isTopTen
            ? (resturantAdmin?.aboutUs ?? AppStrings.quickDetails.tr())
            : (nearbyRestaurant?.aboutUs.isNotEmpty == true
                ? nearbyRestaurant!.aboutUs
                : (resturantAdmin?.aboutUs ?? AppStrings.quickDetails.tr()));

    final String? photo = isSearch
        ? resturantAdmin?.photo
        : isTopTen
            ? resturantAdmin?.photo
            : (nearbyRestaurant?.photo.isNotEmpty == true
                ? nearbyRestaurant!.photo
                : resturantAdmin?.photo);

    final String? resturantId = isSearch
        ? resturantAdmin?.id
        : isTopTen
            ? resturantAdmin?.id
            : (nearbyRestaurant?.id != null
                ? nearbyRestaurant!.id
                : resturantAdmin?.id);

    final bool isClosed = _isClosed();

    return BlocBuilder<SlidersCubit, SlidersState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (isClosed) return; // Prevent navigation if closed
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => ResturantMenuCubit()),
                    BlocProvider(create: (context) => getIt<ItemCubit>()),
                    BlocProvider(
                      create: (context) => getIt<AllresturantsadminCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => getIt<FilterCategoryCubit>()..sortByPrice(resId: resturantId ?? ""),
                    ),
                    BlocProvider(
                      create: (context) => getIt<FavoriteCubit>(),
                    ),
                  ],
                  child: ResturantScreen(
                    resturantAdmin: resturantAdmin,
                    nearbyRestaurant: nearbyRestaurant,
                    isTopTen: isTopTen,
                  ),
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: SizedBox(
                          height: 120,
                          width: MediaQuery.of(context).size.width - 32,
                          child:
                              (photo != null && photo.isNotEmpty)
                              ? CachedNetworkImage(
                                    imageUrl: "${ApiConstants.baseUrl}/$photo",
                                    fit: BoxFit.cover,
                                    errorWidget:
                                        (context, url, error) => Image.asset(
                                          AppImages.sliderOffers,
                                          fit: BoxFit.cover,
                                        ),
                                  )
                              : Image.asset(AppImages.res, fit: BoxFit.cover),
                        ),
                      ),
                      if (isClosed)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryDeafult,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "Closed",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 250.w,
                              child: Text(name, style: TextStyles.bimini20W700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // SizedBox(
                        //   width: 350.w,
                        //   child: Text(
                        //     aboutUs,
                        //     style: TextStyles.bimini16W400Body.copyWith(
                        //       color: AppColors.grey,
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 8),
                        ResturantDetailsRow(
                          themeState: themeState,
                          resturantAdmin:
                              isSearch
                                  ? resturantAdmin
                                  : isTopTen
                                  ? resturantAdmin
                                  : null,
                          nearbyRestaurant:
                              isSearch
                                  ? null
                                  : isTopTen
                                  ? null
                                  : nearbyRestaurant,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
