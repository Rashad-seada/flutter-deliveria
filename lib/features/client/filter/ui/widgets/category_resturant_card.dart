import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/client/fav/logic/cubit/favorite_cubit.dart';
import 'package:delveria/features/client/filter/data/models/filter_by_category_response.dart';
import 'package:delveria/features/client/filter/logic/cubit/filter_category_cubit.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/ui/resturant_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryRestaurantCard extends StatelessWidget {
  final RestaurantByCategory restaurant;

  const CategoryRestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
         final bool isOpen = restaurant.isOpen == true && restaurant.isShow == true;
    final bool isClosed = !isOpen;
                      

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => ResturantMenuCubit(),
                          ),
                          BlocProvider(create: (context) => getIt<ItemCubit>()),
                          BlocProvider(
                            create:
                                (context) => getIt<AllresturantsadminCubit>(),
                          ),
                          BlocProvider(
                            create:
                                (context) =>
                                    getIt<FilterCategoryCubit>()
                                      ..sortByPrice(resId: restaurant.id ?? ""),
                          ),
                          BlocProvider(
                            create: (context) => getIt<FavoriteCubit>(),
                          ),
                        ],
                        child: ResturantScreen(
                          restuarntCategory: restaurant,
                          isTopTen: false,
                        ),
                      ),
                ),
              );
            },
            child: Stack(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    width: 150.w,
                    height: 150.h,
                    fit: BoxFit.fill,
                    placeholder:
                        (context, url) => Center(child: CustomLoading()),
                    errorWidget: (context, url, error) {
                      return Center(child: CustomLoading());
                    },
                    imageUrl: "${ApiConstants.baseUrl}/${restaurant.photo}",
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
                        style: TextStyles.bimini16W700.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: TextStyles.bimini16W700,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  restaurant.aboutUs,
                  style: TextStyles.bimini13W400Grey,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  'Serves ${restaurant.superCategory.nameEn}',
                  style: TextStyles.bimini16W700,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
