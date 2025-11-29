import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/client/fav/logic/cubit/favorite_cubit.dart';
import 'package:delveria/features/client/fav/logic/cubit/favorite_state.dart';
import 'package:delveria/features/client/filter/data/models/filter_by_category_response.dart';
import 'package:delveria/features/client/home/data/models/get_nearby_response.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_state.dart';
import 'package:delveria/features/client/resturant/ui/widgets/food_type_tabs.dart';
import 'package:delveria/features/client/resturant/ui/widgets/quick_food_resturant_appBar.dart';
import 'package:delveria/features/client/resturant/ui/widgets/rate_and_delivery_cost_row.dart';
import 'package:delveria/features/client/resturant/ui/widgets/resturant_review_and_name.dart';
import 'package:delveria/features/client/resturant/ui/widgets/resturant_stacked_image.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResturantScreen extends StatefulWidget {
  const ResturantScreen({
    super.key,
    this.resturantAdmin,
    this.nearbyRestaurant,
    this.isTopTen,
    this.restuarntCategory,
  });
  final ResturantAdmin? resturantAdmin;
  final NearbyRestaurant? nearbyRestaurant;
  final RestaurantByCategory? restuarntCategory;
  final bool? isTopTen;

  @override
  State<ResturantScreen> createState() => _ResturantScreenState();
}

class _ResturantScreenState extends State<ResturantScreen> {
  bool _aboutUsExpanded = false;
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final bool isTopTen = widget.isTopTen == true;
    final resturantAdmin = widget.resturantAdmin;
    final nearbyRestaurant = widget.nearbyRestaurant;
    final restuarntCategory = widget.restuarntCategory;

    // Unified logic for all three types: TopTen, Nearby, Category
    String? logo;
    String? img;
    String? resName;
    String aboutUs;
    String? deliveryCost;
    String? estimatedTime;
    String? rate;
    String? resId;
    List<Review>? reviews;

    if (isTopTen) {
      logo = resturantAdmin?.logo;
      img = resturantAdmin?.photo;
      resName = resturantAdmin?.name;
      aboutUs = resturantAdmin?.aboutUs ?? AppStrings.aboutResturant.tr();
      deliveryCost = resturantAdmin?.deliveryCost.toString();
      estimatedTime = resturantAdmin?.estimatedTime?.toString();
      rate = resturantAdmin?.rate.toString();
      resId = resturantAdmin?.id;
      reviews = resturantAdmin?.reviews.cast<Review>();
    } else if (nearbyRestaurant != null) {
      logo =
          (nearbyRestaurant.logo.isNotEmpty)
              ? nearbyRestaurant.logo
              : resturantAdmin?.logo;
      img =
          (nearbyRestaurant.photo.isNotEmpty)
              ? nearbyRestaurant.photo
              : resturantAdmin?.photo;
      resName =
          (nearbyRestaurant.name.isNotEmpty)
              ? nearbyRestaurant.name
              : resturantAdmin?.name;
      aboutUs =
          (nearbyRestaurant.aboutUs.isNotEmpty)
              ? nearbyRestaurant.aboutUs
              : (resturantAdmin?.aboutUs ?? AppStrings.aboutResturant.tr());
      deliveryCost =
          (nearbyRestaurant.deliveryCost != null)
              ? nearbyRestaurant.deliveryCost.toString()
              : resturantAdmin?.deliveryCost.toString();
      estimatedTime =
          (nearbyRestaurant.estimatedTime != null)
              ? nearbyRestaurant.estimatedTime.toString()
              : resturantAdmin?.estimatedTime?.toString();
      rate =
          (nearbyRestaurant.rate != null)
              ? nearbyRestaurant.rate.toString()
              : resturantAdmin?.rate.toString();
      resId =
          (nearbyRestaurant.id.isNotEmpty)
              ? nearbyRestaurant.id
              : resturantAdmin?.id;
      reviews =
          (nearbyRestaurant.reviews.isNotEmpty)
              ? nearbyRestaurant.reviews.cast<Review>()
              : resturantAdmin?.reviews.cast<Review>();
    } else if (restuarntCategory != null) {
      logo = restuarntCategory.logo;
      img = restuarntCategory.photo;
      resName = restuarntCategory.name;
      aboutUs =
          restuarntCategory.aboutUs.isNotEmpty
              ? restuarntCategory.aboutUs
              : AppStrings.aboutResturant.tr();
      deliveryCost = restuarntCategory.deliveryCost.toString();
      estimatedTime = restuarntCategory.estimatedTime.toString();
      rate = restuarntCategory.rate.toString();
      resId = restuarntCategory.id;
      reviews = restuarntCategory.reviews.cast<Review>();
    } else {
      // fallback to admin if all are null
      logo = resturantAdmin?.logo;
      img = resturantAdmin?.photo;
      resName = resturantAdmin?.name;
      aboutUs = resturantAdmin?.aboutUs ?? AppStrings.aboutResturant.tr();
      deliveryCost = resturantAdmin?.deliveryCost.toString();
      estimatedTime = resturantAdmin?.estimatedTime?.toString();
      rate = resturantAdmin?.rate.toString();
      resId = resturantAdmin?.id;
      reviews = resturantAdmin?.reviews.cast<Review>();
    }

    Widget buildFoodTypeTabs(String? resId) {
      return BlocProvider(
        create:
            (context) =>
                getIt<ItemCubit>()..getItemCategoriesUser(resId: resId ?? ""),
        child: FoodTypeTaps(
          searchQuery: _searchQuery,
        ),
      );
    }

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Scaffold(
          body: SafeArea(
            child: BlocBuilder<ResturantMenuCubit, ResturantMenuState>(
              builder: (resContext, state) {
                return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      // App Bar
                      SliverAppBar(
                        elevation: 0,
                        backgroundColor:
                            themeState.themeMode == ThemeMode.dark
                                ? Colors.black
                                : Colors.white,
                        floating: false,
                        pinned: false,
                        snap: false,
                        automaticallyImplyLeading: false,
                        toolbarHeight: 50.h,
                        flexibleSpace:
                            BlocConsumer<FavoriteCubit, FavoriteState>(
                              builder: (context, state) {
                                final cubit = context.read<FavoriteCubit>();
                                return QuickFoodResturantAppBar(
                                  title:
                                      (resName != null && resName.length > 20)
                                          ? resName.substring(0, 20)
                                          : (resName ?? ""),
                                  themeState: themeState,
                                  onFavTap: () {
                                    cubit.addToFav(resId: resId ?? "");
                                  },
                                );
                              },
                              listener: (
                                BuildContext context,
                                FavoriteState<dynamic> state,
                              ) {
                                state.whenOrNull(
                                  addToFavSuccess: (data) {
                                    showSuccessSnackBar(
                                      context,
                                      AppStrings.resturantAddedToFavorite.tr(),
                                    );
                                  },
                                );
                              },
                            ),
                      ),

                      // Restaurant Info Section
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpace(10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: SizedBox(
                                height: 40.h,
                                child: TextField(
                                  onChanged: (v) {
                                    setState(() => _searchQuery = v);
                                  },
                                  style: TextStyles.bimini13W400Grey.copyWith(
                                    color:
                                        themeState.themeMode == ThemeMode.dark
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal: 10,
                                    ),
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    hintText: AppStrings.searchForMeals.tr(),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: BorderSide(
                                        color: AppColors.greyBlue,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: BorderSide(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: BorderSide(
                                        color: AppColors.greyBlue,
                                      ),
                                    ),
                                    hintStyle: TextStyles.bimini13W400Grey,
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            verticalSpace(20),
                            ResturantStackedImage(logo: logo, img: img),
                            ResturantReviewAndName(
                              resName: resName,
                              reviews: reviews ?? [],
                              resId: resId ?? "",
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                              child: _AboutUsExpandable(
                                aboutUs: aboutUs,
                                expanded: _aboutUsExpanded,
                                onTap: () {
                                  setState(() {
                                    _aboutUsExpanded = !_aboutUsExpanded;
                                  });
                                },
                              ),
                            ),
                            verticalSpace(10),
                            RateAndDeliveryCostRow(
                              deliveryCost: deliveryCost,
                              estimatedTime: estimatedTime,
                              themeState: themeState,
                              rate: rate,
                            ),
                            verticalSpace(10),
                            
                          ],
                        ),
                      ),
                    ];
                  },
                  body: buildFoodTypeTabs(resId),
                );
              },
            ),
          ),
        );
      },
    );
  }
}


class _AboutUsExpandable extends StatelessWidget {
  final String aboutUs;
  final bool expanded;
  final VoidCallback onTap;

  const _AboutUsExpandable({
    super.key,
    required this.aboutUs,
    required this.expanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyles.bimini16W400Body.copyWith(
      color: AppColors.grey,
    );
    final span = TextSpan(text: aboutUs, style: textStyle);
    final tp = TextPainter(
      text: span,
      maxLines: 3,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: MediaQuery.of(context).size.width - 10.w);

    final exceedsFourLines = tp.didExceedMaxLines;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          aboutUs,
          textAlign: TextAlign.start,
          style: textStyle,
          maxLines: expanded ? null : 3,
          overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        if (exceedsFourLines || !expanded)
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                expanded ? AppStrings.seeLess.tr() : AppStrings.seeMore.tr(),
                style: TextStyles.bimini13W400Grey.copyWith(
                  color: AppColors.primaryDeafult,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
