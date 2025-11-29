import 'package:carousel_slider/carousel_slider.dart';
import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:delveria/features/client/filter/logic/cubit/filter_category_cubit.dart';
import 'package:delveria/features/client/filter/ui/category_filter_screen.dart';
import 'package:delveria/features/client/filter/ui/nearby_see_all_screen.dart';
import 'package:delveria/features/client/filter/ui/rating_filter_screen.dart';
import 'package:delveria/features/client/filter/ui/widgets/categories_container.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_state.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_state.dart';
import 'package:delveria/features/client/home/ui/widgets/build_resturant_card.dart';
import 'package:delveria/features/client/home/ui/widgets/nearby_text.dart';
import 'package:delveria/features/client/home/ui/widgets/reactive_dots.dart';
import 'package:delveria/features/client/home/ui/widgets/search_bar.dart';
import 'package:delveria/features/client/home/ui/widgets/slider_section.dart';
import 'package:delveria/features/client/home/ui/widgets/top_resturants_text.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScrollableContent extends StatefulWidget {
  const ScrollableContent({
    super.key,
    required this.themeState,
    required this.cubit,
    required this.lat,
    required this.long,
  });
  final ThemeState themeState;
  final SlidersCubit cubit;
  final double lat, long;

  @override
  State<ScrollableContent> createState() => _ScrollableContentState();
}

class _ScrollableContentState extends State<ScrollableContent> {
  String query = "";
  int _topRestIndex = 0;
  int _nearbyRestIndex = 0;

  String? _getValidSuperCategoryName(BuildContext context, String? prefName) {
    final allSuperCategories =
        context.read<AllresturantsadminCubit>().allSuperCategories;
    if (allSuperCategories.isEmpty) return "";
    final names = allSuperCategories.map((e) => e.nameEn).toList();
    if (prefName != null && names.contains(prefName)) {
      return prefName;
    }
    return names.isNotEmpty ? names.first : "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AllresturantsadminCubit>().getAllResturantsForAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: BlocBuilder<CarouselCubit, CarouselState>(
          builder: (context, state) {
            return BlocBuilder<SlidersCubit, SlidersState>(
              builder: (context, sliderState) {
                final sliderCubit = context.read<SlidersCubit>();
                return BlocBuilder<
                  AllresturantsadminCubit,
                  AllresturantsadminState
                >(
                  builder: (context, adminState) {
                    final admin = context.read<AllresturantsadminCubit>();
                    // Defensive coding: verify list before accessing first element
                    final resturantsList = admin.allResturants;
                    final showSliderSection = resturantsList.isNotEmpty;
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: SearchBarSection(
                            themeState: widget.themeState,
                            lat: widget.lat,
                            long: widget.long,
                            onChanged: (p0) async {
                              setState(() {
                                query = p0;
                              });
                              await sliderCubit.searchResturantUserSide(
                                query: query,
                                lat: widget.lat,
                                long: widget.long,
                              );
                            },
                          ),
                        ),
                        verticalSpace(20),

                        if (showSliderSection)
                          SliderSection(
                            state: state,
                            resId: resturantsList.map((e) => e.id).toString(),
                            resturantAdmin: resturantsList,
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppStrings.noRestaurantsFound.tr(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        verticalSpace(20),
                        ReactiveDots(
                          state: state,
                          themeState: widget.themeState,
                          cubit: widget.cubit,
                        ),
                        verticalSpace(20),

                        FutureBuilder<dynamic>(
                          future: SharedPrefHelper.getString("name"),
                          builder: (context, snapshot) {
                            final selectedSuperCategoryName =
                                _getValidSuperCategoryName(
                                  context,
                                  snapshot.data as String?,
                                );
                            return BlocBuilder<
                              AllresturantsadminCubit,
                              AllresturantsadminState
                            >(
                              builder: (context, state) {
                                if (state is SuperCateLoading) {
                                  return CustomLoading();
                                }
                                final superCategories =
                                    context
                                        .read<AllresturantsadminCubit>()
                                        .allSuperCategories;
                                if (superCategories.isEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        AppStrings.noRestaurantsFound.tr(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return CategoriesContainer(
                                  superCategories: superCategories,
                                  selectedSuperCategoryName:
                                      selectedSuperCategoryName ?? "",
                                  onSuperCategoryChanged: (selectedName) async {
                                    await SharedPrefHelper.setData(
                                      "name",
                                      selectedName,
                                    );
                                    // ignore: avoid_print
                                    print(
                                      "Selected category name: $selectedName",
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => MultiBlocProvider(
                                              providers: [
                                                BlocProvider.value(
                                                  value:
                                                      context
                                                          .read<
                                                            AllresturantsadminCubit
                                                          >(),
                                                ),
                                                BlocProvider(
                                                  create:
                                                      (context) =>
                                                          getIt<
                                                            FilterCategoryCubit
                                                          >(),
                                                ),
                                              ],
                                              child: CategoryFilterScreen(
                                                lat: widget.lat,
                                                long: widget.long,
                                                isAdmin: false,
                                              ),
                                            ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                        verticalSpace(20),
                        TopResturantText(
                          showSeeAll: !(query != ""),
                          title:
                              query != ""
                                  ? AppStrings.searchResults.tr()
                                  : AppStrings.top.tr(),
                          themeState: widget.themeState,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => BlocProvider(
                                      create:
                                          (context) =>
                                              getIt<AllresturantsadminCubit>()
                                                ..getAllRatedResturantsForAdmin(
                                                  widget.lat,
                                                  widget.long,
                                                ),
                                      child: RatingFilterScreen(
                                        showTitle: false,
                                        isTopTen: true,
                                      ),
                                    ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        BlocBuilder<SlidersCubit, SlidersState>(
                          builder: (context, sliderState) {
                            if (query.isNotEmpty) {
                              final searchResults = sliderCubit.searchResturant;
                              if (searchResults.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      AppStrings.noRestaurantsFound.tr(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              // Carousel for search results
                              return CarouselSlider.builder(
                                itemCount: searchResults.length,
                                itemBuilder: (context, index, realIdx) {
                                  return BuildResturantCard(
                                    isSearch: true,
                                    themeState: widget.themeState,
                                    isTopTen: true,
                                    resturantAdmin: searchResults[index],
                                  );
                                },
                                options: CarouselOptions(
                                  height: 260,
                                  enableInfiniteScroll: false,
                                  enlargeCenterPage: true,
                                  viewportFraction: 1,
                                ),
                              );
                            } else {
                              // Not searching, show top 10 rated restaurants as carousel
                              return BlocBuilder<
                                AllresturantsadminCubit,
                                AllresturantsadminState
                              >(
                                builder: (context, adminState) {
                                  final cubit =
                                      context.read<AllresturantsadminCubit>();
                                  final allRes = cubit.allRatedResturants;
                                  final showCount =
                                      allRes.length > 10 ? 10 : allRes.length;
                                  if (showCount == 0) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          AppStrings.noRestaurantsFound.tr(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return CarouselSlider.builder(
                                    itemCount: showCount,
                                    itemBuilder: (context, index, realIdx) {
                                      return BuildResturantCard(
                                        isSearch: false,
                                        themeState: widget.themeState,
                                        isTopTen: true,
                                        resturantAdmin: allRes[index],
                                      );
                                    },
                                    options: CarouselOptions(
                                      height: 260,
                                      enableInfiniteScroll: false,
                                      enlargeCenterPage: true,
                                      viewportFraction: 1,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _topRestIndex = index;
                                        });
                                      },
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 24),

                        query != ""
                            ? const SizedBox()
                            : NearbyText(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => BlocProvider(
                                          create:
                                              (context) =>
                                                  getIt<
                                                      AllresturantsadminCubit
                                                    >()
                                                    ..getNearbyResturants(
                                                      lat: widget.lat,
                                                      long: widget.long,
                                                    ),
                                          child: NearbySeeAllScreen(),
                                        ),
                                  ),
                                );
                              },
                            ),

                        const SizedBox(height: 16),
                        query != ""
                            ? const SizedBox()
                            : BlocBuilder<
                              AllresturantsadminCubit,
                              AllresturantsadminState
                            >(
                              builder: (context, state) {
                                final cubit =
                                    context.read<AllresturantsadminCubit>();
                                final nearbyList = cubit.allNearbyResturant;
                                if (nearbyList.isEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        AppStrings.noRestaurantsFound.tr(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                // Carousel for nearby restaurants
                                return CarouselSlider.builder(
                                  itemCount: nearbyList.length,
                                  itemBuilder: (context, index, realIdx) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: BuildResturantCard(
                                        isTopTen: false,
                                        themeState: widget.themeState,
                                        nearbyRestaurant: nearbyList[index],
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    height: 260,
                                    enableInfiniteScroll: false,
                                    enlargeCenterPage: true,
                                    viewportFraction: 1,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _nearbyRestIndex = index;
                                      });
                                    },
                                  ),
                                );
                              },
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
}
