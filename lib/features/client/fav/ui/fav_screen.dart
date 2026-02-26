import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/continue_as_a_guest.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/continue_as_guest_body.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/client/fav/logic/cubit/favorite_cubit.dart';
import 'package:delveria/features/client/fav/logic/cubit/favorite_state.dart';
import 'package:delveria/features/client/filter/logic/cubit/filter_category_cubit.dart';
import 'package:delveria/features/client/home/data/models/get_nearby_response.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/ui/resturant_screen.dart';
import 'package:delveria/features/client/resturant/ui/widgets/rate_and_delivery_cost_row.dart';
import 'package:delveria/features/client/resturant/ui/widgets/resturant_review_and_name.dart';
import 'package:delveria/features/client/resturant/ui/widgets/resturant_stacked_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

List<NearbyRestaurant>? nearby;
List<ResturantAdmin>? allRated;

class _FavScreenState extends State<FavScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadContinueAsGuest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: AppStrings.favourites.tr(),
          titleStyle: TextStyles.bimini16W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body:
          isContinueAsGuest
              ? ContinueAsGuestBody()
              : BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          final cubit = context.read<FavoriteCubit>();
          if (cubit.favRes.isEmpty) {
            return Center(
              child: Text(
                        AppStrings.noFavorites.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyles.bimini16W700.copyWith(
                          color: AppColors.primaryDeafult,
                        ),
                      ),
                    );
          }
          return ListView.builder(
            itemCount: cubit.favRes.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => CustomLoading(),
                      );

                      try {
                        final allResturantsAdminCubit =
                            getIt<AllresturantsadminCubit>();
                        final itemCubit = getIt<ItemCubit>();
                        final filterCubit = getIt<FilterCategoryCubit>();

                        final lat = cubit.favRes[index].coordinates?.latitude;
                        final lng = cubit.favRes[index].coordinates?.longitude;
                        final resId = cubit.favRes[index].id ?? "";

                        await Future.wait([
                          allResturantsAdminCubit.getAllRatedResturantsForAdmin(
                            lat,
                            lng,
                          ),
                          allResturantsAdminCubit.getNearbyResturants(
                            lat: lat,
                            long: lng,
                          ),
                          itemCubit.getAllItems(resId: resId),
                          filterCubit.sortByPrice(resId: resId),
                        ]);

                        Navigator.pop(context);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (context) => ResturantMenuCubit(),
                                    ),
                                    BlocProvider.value(value: itemCubit),
                                    BlocProvider.value(
                                      value: allResturantsAdminCubit,
                                    ),
                                    BlocProvider.value(value: filterCubit),
                                    BlocProvider(
                                      create:
                                          (context) => getIt<FavoriteCubit>(),
                                    ),
                                  ],
                                  child: ResturantScreen(
                                    resturantAdmin:
                                        allResturantsAdminCubit
                                            .allRatedResturants[index],
                                    nearbyRestaurant:
                                        allResturantsAdminCubit
                                            .allNearbyResturant[index],
                                    isTopTen: false,
                                  ),
                                ),
                          ),
                        );
                              } catch (e) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to load restaurant data: $e'),
                          ),
                        );
                      }
                    },
                    child: ResturantStackedImage(
                      logo: cubit.favRes[index].logo,
                      img: cubit.favRes[index].photo,
                      isOpen: true, // FavouriteRestaurant doesn't have isOpen field
                    ),
                  ),
                  BlocListener<FavoriteCubit, FavoriteState>(
                    listener: (context, state) {
                      state.whenOrNull(
                        deleteFavSuccess: (data) {
                        
                          cubit.getFav();
                        },
                      );
                    },
                    child: ResturantReviewAndName(
                              resId: cubit.favRes[index].id ?? "",
                      reviews: cubit.favRes[index].reviews as List<Review>,
                      resName: cubit.favRes[index].name,
                      showDelete: true,
                      onDeleteTap: () {
                        cubit.deleteFav(resId: cubit.favRes[index].id ?? "");
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  //   child: Text(
                  //     textAlign: TextAlign.start,
                  //     cubit.favRes[index].aboutUs ?? "",
                  //     style: TextStyles.bimini16W400Body.copyWith(
                  //       color: AppColors.grey,
                  //     ),
                  //   ),
                  // ),
                  verticalSpace(10),
                  RateAndDeliveryCostRow(
                    deliveryCost: cubit.favRes[index].deliveryCost.toString(),
                    estimatedTime: cubit.favRes[index].estimatedTime.toString(),
                    rate: cubit.favRes[index].rate.toString(),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
