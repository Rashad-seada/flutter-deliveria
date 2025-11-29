import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/search_row.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:delveria/features/client/fav/logic/cubit/favorite_cubit.dart';
import 'package:delveria/features/client/filter/logic/cubit/filter_category_cubit.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/ui/resturant_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NearbySeeAllScreen extends StatelessWidget {
  const NearbySeeAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            verticalSpace(20),
            SearchRow(
              showButton: false,
              showIosArrow: true,
              showSearchContainer: false,
              title: AppStrings.nearby.tr(),
            ),

            verticalSpace(30),

            SizedBox(height: 20),
            BlocBuilder<AllresturantsadminCubit, AllresturantsadminState>(
              builder: (context, state) {
                final cubit = context.read<AllresturantsadminCubit>();
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 5,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: cubit.allNearbyResturant.length,
                      itemBuilder: (context, index) {
                        final resturant = cubit.allNearbyResturant[index];
                        final bool isOpen = resturant.isOpen == true && resturant.isShow == true;
                        final bool isClosed = !isOpen;
                        return GestureDetector(
                          onTap: () {
                            if (isClosed)
                              return; // Prevent navigation if closed
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create:
                                              (context) => ResturantMenuCubit(),
                                        ),
                                        BlocProvider(
                                          create:
                                              (context) => getIt<ItemCubit>(),
                                        ),
                                        BlocProvider(
                                          create:
                                              (context) =>
                                                  getIt<
                                                    AllresturantsadminCubit
                                                  >(),
                                        ),
                                        BlocProvider(
                                          create:
                                              (context) =>
                                                  getIt<FilterCategoryCubit>()
                                                    ..sortByPrice(
                                                      resId: resturant.id ?? "",
                                                    ),
                                        ),
                                        BlocProvider(
                                          create:
                                              (context) =>
                                                  getIt<FavoriteCubit>(),
                                        ),
                                      ],
                                      child: ResturantScreen(
                                        nearbyRestaurant: resturant,
                                        isTopTen: false,
                                      ),
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 137.h,
                                      width: 170.w,
                                      decoration: BoxDecoration(
                                        color:
                                            resturant.photo.isNullOrEmpty() ==
                                                    true
                                                ? AppColors.pinkLight
                                                : Colors.white,
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(12),
                                        ),
                                      ),
                                      child:
                                          resturant.photo.isNullOrEmpty() ==
                                                  true
                                              ? null
                                              : CachedNetworkImage(
                                             imageUrl:    "${ApiConstants.baseUrl}/${resturant.photo}",
                                                height: 137.h,
                                                width: 170.w,
                                                fit: BoxFit.cover,
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
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
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
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        resturant.name ?? "",
                                        style: TextStyles.bimini16W700,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        resturant.aboutUs ?? "",
                                        style: TextStyles.bimini13W400Grey,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star_border,
                                            color: AppColors.primary,
                                            size: 20.sp,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            resturant.rate.toString() ?? "",
                                            style: TextStyles
                                                .bimini16W700BoldWhite
                                                .copyWith(
                                                  color: Color(0xff212121),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
