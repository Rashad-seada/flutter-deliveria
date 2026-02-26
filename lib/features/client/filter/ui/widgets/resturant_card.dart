import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/resturant_admin_details.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/from_notification_res_card.dart';
import 'package:delveria/features/client/fav/logic/cubit/favorite_cubit.dart';
import 'package:delveria/features/client/filter/logic/cubit/filter_category_cubit.dart';
import 'package:delveria/features/client/home/data/models/get_nearby_response.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/ui/resturant_screen.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantCard extends StatelessWidget {
  final ResturantAdmin? restaurant;
  final ResturantAdmin? resturantUser;
  final NearbyRestaurant? nearby;
  final bool? isAdmin;
  final bool? isFromNotification;
  final bool isUser, isTopten;
  final bool allowClosedNavigation;

  const RestaurantCard({
    super.key,
    this.restaurant,
    this.resturantUser,
    this.isAdmin,
    this.nearby,
    this.isFromNotification,
    required this.isUser,
    required this.isTopten,
    this.allowClosedNavigation = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isOpen = false;
    if (resturantUser != null) {
      isOpen = resturantUser?.isOpen == true && resturantUser?.isShow == true;
    } else if (restaurant != null) {
      isOpen = restaurant?.isOpen == true && restaurant?.isShow == true;
    } else if (nearby != null) {
      isOpen = nearby?.isOpen == true && nearby?.isShow == true;
    }
    final bool isClosed = !isOpen;

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child:
          isFromNotification == true
              ? FromNotificationResCard()
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap:
                        isUser && (isClosed == false || allowClosedNavigation)
                            ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider(
                                            create:
                                                (context) =>
                                                    ResturantMenuCubit(),
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
                                                        resId:
                                                            resturantUser?.id ??
                                                            "",
                                                      ),
                                          ),
                                          BlocProvider(
                                            create:
                                                (context) =>
                                                    getIt<FavoriteCubit>(),
                                          ),
                                        ],
                                        child: ResturantScreen(
                                          resturantAdmin: restaurant,
                                          nearbyRestaurant: nearby,
                                          isTopTen: isTopten,
                                        ),
                                      ),
                                ),
                              );
                            }
                            : isClosed && !allowClosedNavigation
                            ? () {}
                            : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                            create:
                                                (context) =>
                                                    getIt<ResturantMenuCubit>(),
                                  ),
                                  BlocProvider(
                                    create: (context) => getIt<ItemCubit>(),
                                  ),
                                ],
                                child: ResturantAdminDetails(
                                  resturantAdmin: restaurant ?? resturantUser!,
                                ),
                              ),
                                ),
                              );
                            },
                    child: Stack(
                      children: [
                        Container(
                          height: 137.h,
                          width: 170.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          child:
                              restaurant?.photo.isNullOrEmpty() == true
                                  ? null
                                  : CachedNetworkImage(
                            imageUrl:     "${ApiConstants.baseUrl}/${restaurant?.photo}",
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
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resturantUser?.name ?? restaurant?.name ?? "",
                          style: TextStyles.bimini16W700,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          resturantUser?.aboutUs ?? restaurant?.aboutUs ?? "",
                          style: TextStyles.bimini13W400Grey,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        BlocBuilder<ThemeCubit, ThemeState>(
                          builder: (context, state) {
                            return Row(
                              mainAxisAlignment:
                                  isAdmin == true
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star_border,
                                  color:
                                      state.themeMode == ThemeMode.dark
                                          ? AppColors.primaryDeafultDarkMode
                                          : AppColors.primary,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  resturantUser?.rate.toString() ??
                                      restaurant?.rate.toString() ??
                                      "",
                                  style: TextStyles.bimini16W700BoldWhite
                                      .copyWith(
                                        color:
                                            state.themeMode == ThemeMode.dark
                                                ? AppColors.lightGrey
                                                : Color(0xff212121),
                                      ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
