import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/search_row.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_state.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_state.dart';
import 'package:delveria/features/client/resturant/ui/widgets/food_menu_text.dart';
import 'package:delveria/features/client/resturant/ui/widgets/horizental_body.dart';
import 'package:delveria/features/client/resturant/ui/widgets/rate_and_delivery_cost_row.dart';
import 'package:delveria/features/client/resturant/ui/widgets/resturant_review_and_name.dart';
import 'package:delveria/features/client/resturant/ui/widgets/resturant_stacked_image.dart';
import 'package:delveria/features/client/resturant/ui/widgets/vertical_menu_body.dart';
import 'package:delveria/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResturantAdminDetails extends StatefulWidget {
  const ResturantAdminDetails({super.key, required this.resturantAdmin});
  final ResturantAdmin resturantAdmin;

  @override
  State<ResturantAdminDetails> createState() => _ResturantAdminDetailsState();
}

class _ResturantAdminDetailsState extends State<ResturantAdminDetails> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      context.read<ItemCubit>().loadMoreItems();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await context.read<ItemCubit>().getAllItems(
                  resId: widget.resturantAdmin.id ?? "",
                );
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 200.h,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: ResturantStackedImage(
                    logo: widget.resturantAdmin.logo,
                    img: widget.resturantAdmin.photo,
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                leading: const BackButton(color: Colors.black),
              ),
              BlocBuilder<ResturantMenuCubit, ResturantMenuState>(
                builder: (resContext, state) {
                  return SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: SearchRow(
                            showButton: false, 
                            showIosArrow: false // already have back button in SliverAppBar
                          ),
                        ),
                        verticalSpace(10),
                        ResturantReviewAndName(
                          resName: widget.resturantAdmin.name,
                          reviews: widget.resturantAdmin.reviews ?? [],
                          resId: widget.resturantAdmin.id ?? "",
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                          child: Text(
                            widget.resturantAdmin.aboutUs,
                            textAlign: TextAlign.start,
                            style: TextStyles.bimini16W400Body.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                        verticalSpace(10),
                        RateAndDeliveryCostRow(
                          deliveryCost: widget.resturantAdmin.deliveryCost.toString(),
                          estimatedTime: widget.resturantAdmin.estimatedTime.toString(),
                          themeState: themeState,
                          rate: widget.resturantAdmin.rate.toString(),
                        ),
                        verticalSpace(20),
                        FoodMenuText(themeState: themeState),
                        verticalSpace(20),
                      ],
                    ),
                  );
                },
              ),
              BlocBuilder<ResturantMenuCubit, ResturantMenuState>(
                builder: (context, state) {
                  if (state.toggleToHorizental) {
                    return BlocBuilder<ItemCubit, ItemState>(
                      builder: (context, itemState) {
                        return HorizentalBodyForUser(
                          resId: widget.resturantAdmin.id,
                          isAdmin: true,
                          isSliver: true,
                        );
                      },
                    );
                  } else {
                    return BlocBuilder<ItemCubit, ItemState>(
                      builder: (context, itemState) {
                        return VerticalMenuBody(
                          resId: widget.resturantAdmin.id,
                          isAdmin: true,
                          isSliver: true,
                        );
                      },
                    );
                  }
                },
              ),
              // Add some bottom padding
              SliverToBoxAdapter(child: verticalSpace(20)),
            ],
          ),
        ),
      ),
    );
  }
}

