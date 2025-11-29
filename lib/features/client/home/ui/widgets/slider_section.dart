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
                    builder:
                        (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) => ResturantMenuCubit(),
                            ),
                            BlocProvider(
                              create: (context) => getIt<ItemCubit>(),
                            ),
                            BlocProvider(
                              create:
                                  (context) => getIt<AllresturantsadminCubit>(),
                            ),
                            BlocProvider(
                              create:
                                  (context) =>
                                      getIt<FilterCategoryCubit>()
                                        ..sortByPrice(resId: resId ?? ""),
                            ),
                            BlocProvider(
                              create: (context) => getIt<FavoriteCubit>(),
                            ),
                          ],
                          child: ResturantScreen(
                            resturantAdmin: resturantAdmin.firstWhere(
                              (e) =>
                                  e.id == cubit.sliders[realIdx].restaurantId,
                            ),
                          ),
                        ),
                  ),
                );
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 342.w,
                    height: 158.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            "${ApiConstants.baseUrl}/${cubit.sliders[index].image}",
                        placeholder:
                            (context, url) => Center(child: CustomLoading()),
                        errorWidget: (context, url, error) {
                          return Center(child: CustomLoading());
                        },
                      ),
                    ),
                  ),
                  // OffersContainer(),
                ],
              ),
            );
          },
          options: CarouselOptions(
            height: 150.h,
            viewportFraction: 1,
            enableInfiniteScroll: false,
            autoPlay: true,
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
