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
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      backgroundColor: const Color(0xFFF5F6FA),
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
                    if (context.mounted) {
                      await context.read<ItemCubit>().getAllItems(resId: widget.resId);
                    }
                  },
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // --- Header: Open/Close Toggle ---
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        BlocBuilder<ResturantProfileDataCubit,
                                            ResturantProfileDataState>(
                                          builder: (context, state) {
                                            final profileCubit = context
                                                .read<ResturantProfileDataCubit>();
                                            final isOpen = profileCubit.isOpen ?? false;
                                            return Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: isOpen
                                                    ? Colors.green.withOpacity(0.1)
                                                    : Colors.red.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    width: 8,
                                                    height: 8,
                                                    decoration: BoxDecoration(
                                                      color: isOpen ? Colors.green : Colors.red,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  SizedBox(width: 6),
                                                  Text(
                                                    isOpen ? AppStrings.openingNow.tr() : 'Closed',
                                                    style: TextStyles.bimini13W400Grey.copyWith(
                                                      color: isOpen ? Colors.green.shade700 : Colors.red.shade700,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    BlocBuilder<ResturantProfileDataCubit,
                                        ResturantProfileDataState>(
                                      builder: (context, state) {
                                        final profileCubit = context
                                            .read<ResturantProfileDataCubit>();
                                        return Switch(
                                          activeColor: Colors.white,
                                          activeTrackColor: Colors.green,
                                          value: profileCubit.isOpen ?? false,
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
                              ),
                              verticalSpace(16),

                              // --- Stats Cards ---
                              StateCardRow(
                                totalOrders:
                                    (resCubit.ordersNumber ?? 0).toString(),
                                totalRevenue:
                                    (resCubit.netRevenue ?? 0).toString(),
                                averageRating:
                                    (resCubit.customerFeedBack ?? 0).toStringAsFixed(1),
                              ),
                              verticalSpace(16),

                              // --- Customer Feedback ---
                              CustomerFeedBackCard(
                                customerRate: (resCubit.customerFeedBack ?? 0)
                                    .toStringAsFixed(1),
                              ),
                              verticalSpace(16),

                              // --- Revenue Chart ---
                              RevenueChartSection(
                                data: resCubit.ordersOfLastWeek ?? [],
                              ),
                              verticalSpace(20),

                              // --- Reviews Section ---
                              ReviewsText(
                                reviews: cubit.reviews,
                                resId: widget.resId,
                              ),
                              verticalSpace(10),
                              RatingText(
                                rating: (resCubit.customerFeedBack ?? 0).toStringAsFixed(1),
                                totalText:
                                    '${AppStrings.total.tr()} ${cubit.reviews.length} ${AppStrings.reviews.tr()}',
                              ),
                              verticalSpace(24),

                              // --- Popular Items ---
                              PopularItemSection(resId: widget.resId),
                              verticalSpace(16),
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
                      // Bottom padding
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
