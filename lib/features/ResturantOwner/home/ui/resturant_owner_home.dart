import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/ResturantOwner/home/logic/cubit/resturant_data_cubit.dart';
import 'package:delveria/features/ResturantOwner/home/logic/cubit/resturant_data_state.dart';
import 'package:delveria/features/ResturantOwner/home/ui/widgets/customer_feedback_card.dart';
import 'package:delveria/features/ResturantOwner/home/ui/widgets/popular_item_text.dart';
import 'package:delveria/features/ResturantOwner/home/ui/widgets/rating_text.dart';
import 'package:delveria/features/ResturantOwner/home/ui/widgets/revenue_chart_section.dart';
import 'package:delveria/features/ResturantOwner/home/ui/widgets/reviews_text.dart';
import 'package:delveria/features/ResturantOwner/home/ui/widgets/state_card_row.dart';
import 'package:delveria/features/ResturantOwner/resturantProfile/logic/cubit/resturant_profile_data_cubit.dart';
import 'package:delveria/features/ResturantOwner/resturantProfile/logic/cubit/resturant_profile_data_state.dart';
import 'package:delveria/features/client/resturant/ui/widgets/vertical_menu_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../menu/logic/cubit/item_cubit.dart';

class RestaurantDashboard extends StatefulWidget {
  const RestaurantDashboard({super.key, required this.resId});

  final String resId;

  @override
  _RestaurantDashboardState createState() => _RestaurantDashboardState();
}

class _RestaurantDashboardState extends State<RestaurantDashboard> {
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
      body: MultiBlocListener(
        listeners: [
          BlocListener<ResturantDataCubit, ResturantDataState>(
            listener: (context, state) {
              if (state is ChangeEnableSuccess || state is ChangeEnableFail) {
                setState(() {});
              }
            },
          ),
        ],
        child: BlocBuilder<ResturantProfileDataCubit, ResturantProfileDataState>(
          builder: (context, profileState) {
            final cubit = context.read<ResturantProfileDataCubit>();
            return BlocBuilder<ResturantDataCubit, ResturantDataState>(
              buildWhen: (previous, current) =>
                  current is GetHomeResLoading || current is! GetHomeResLoading,
              builder: (context, state) {
                if (state is GetHomeResLoading) {
                  return const CustomLoading();
                }
                final resCubit = context.watch<ResturantDataCubit>();
                
                return RefreshIndicator(
                  color: AppColors.primary,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  onRefresh: () async {
                    await context.read<ResturantDataCubit>().getResturantDataForHome();
                    // Also refresh items for the list
                     if (context.mounted) {
                      await context.read<ItemCubit>().getAllItems(resId: widget.resId);
                    }
                  },
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppStrings.openingNow.tr(),
                                    style: TextStyles.bimini20W700,
                                  ),
                                  BlocBuilder<ResturantProfileDataCubit,
                                      ResturantProfileDataState>(
                                    builder: (context, state) {
                                      final cubit = context
                                          .read<ResturantProfileDataCubit>();
                                      return Switch(
                                        activeColor: Colors.white,
                                        activeTrackColor: Colors.green,
                                        value: cubit.isOpen ?? false,
                                        onChanged: (value) async {
                                          await resCubit.changeEnable(
                                            resID: widget.resId,
                                          );
                                          if (context.mounted) {
                                            await context
                                                .read<ResturantProfileDataCubit>()
                                                .getResturantProfileData();
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              StateCardRow(
                                totalOrders:
                                    (resCubit.ordersNumber ?? 0).toString(),
                                totalRevenue:
                                    (resCubit.netRevenue ?? 0).toString(),
                              ),
                              verticalSpace(16),
                              CustomerFeedBackCard(
                                customerRate: (resCubit.customerFeedBack ?? 0)
                                    .toString()
                                    .substring(0, 1),
                              ),
                              const SizedBox(height: 16),
                              RevenueChartSection(
                                data: resCubit.ordersOfLastWeek ?? [],
                              ),
                              const SizedBox(height: 16),
                              ReviewsText(
                                reviews: cubit.reviews,
                                resId: widget.resId,
                              ),
                              verticalSpace(15),
                              RatingText(
                                totalText:
                                    '${AppStrings.total.tr()} ${cubit.reviews.length} ${AppStrings.reviews.tr()}',
                              ),
                              verticalSpace(25),
                              PopularItemSection(resId: widget.resId),
                              verticalSpace(20),
                            ],
                          ),
                        ),
                      ),
                      VerticalMenuBody(
                        showRow: false,
                        resId: widget.resId,
                        isAdmin: false,
                        isSliver: true,
                      ),
                      // Add bottom padding
                      const SliverToBoxAdapter(child: SizedBox(height: 20)),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

