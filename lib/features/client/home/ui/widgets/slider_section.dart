import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/client/fav/logic/cubit/favorite_cubit.dart';
import 'package:delveria/features/client/filter/logic/cubit/filter_category_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_state.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_state.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/ui/resturant_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderSection extends StatelessWidget {
  const SliderSection({
    super.key,
    required this.state,
    required this.resId,
    required this.resturantAdmin,
  });
  final CarouselState state;
  final String resId;
  final List<ResturantAdmin> resturantAdmin;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SlidersCubit, SlidersState>(
      builder: (context, sliderState) {
        final cubit = context.read<SlidersCubit>();
        if (sliderState is Loading) {
          return Center(child: CustomLoading());
        }
        return CarouselSlider.builder(
          carouselController: state.carouselSliderController,
          itemCount: cubit.sliders.length,
          itemBuilder: (context, index, realIdx) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => ResturantMenuCubit(),
                        ),
                        BlocProvider(
                          create: (context) => getIt<ItemCubit>(),
                        ),
                        BlocProvider(
                          create: (context) => getIt<AllresturantsadminCubit>(),
                        ),
                        BlocProvider(
                          create: (context) =>
                              getIt<FilterCategoryCubit>()
                                ..sortByPrice(resId: resId ?? ""),
                        ),
                        BlocProvider(
                          create: (context) => getIt<FavoriteCubit>(),
                        ),
                      ],
                      child: ResturantScreen(
                        resturantAdmin: resturantAdmin.firstWhere(
                          (e) => e.id == cubit.sliders[realIdx].restaurantId,
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: AnimatedScale(
                scale: state.currentPage == index ? 1.0 : 0.95,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Main Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: SizedBox(
                          width: double.infinity,
                          height: 165.h,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                "${ApiConstants.baseUrl}/${cubit.sliders[index].image}",
                            placeholder: (context, url) =>
                                Center(child: CustomLoading()),
                            errorWidget: (context, url, error) {
                              return Center(child: CustomLoading());
                            },
                          ),
                        ),
                      ),
                      // Gradient Overlay for better text visibility if needed
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black.withOpacity(0.3),
                              ],
                              stops: const [0.0, 0.6, 1.0],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 165.h,
            viewportFraction: 0.92,
            enableInfiniteScroll: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOutCubic,
            enlargeCenterPage: true,
            enlargeFactor: 0.15,
            onPageChanged: (index, reason) {
              context.read<CarouselCubit>().updateCurrentPage(index);
            },
            initialPage: state.currentPage,
            scrollPhysics: const BouncingScrollPhysics(),
          ),
        );
      },
    );
  }
}
