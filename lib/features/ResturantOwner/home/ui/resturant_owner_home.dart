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

class RestaurantDashboard extends StatefulWidget {
  const RestaurantDashboard({super.key, required this.resId});

  final String resId;

  @override
  _RestaurantDashboardState createState() => _RestaurantDashboardState();
}

class _RestaurantDashboardState extends State<RestaurantDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: AppColors.primary,
        backgroundColor: Colors.white,
        elevation: 0,
        onRefresh: () async {
          context.read<ResturantDataCubit>().getResturantDataForHome();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: MultiBlocListener(
            listeners: [
              BlocListener<ResturantDataCubit, ResturantDataState>(
                listener: (context, state) {
                  // If the state is changed after enabling/disabling, rebuild the widget
                  if (state is ChangeEnableSuccess ||
                      state is ChangeEnableFail) {
                    // You can add logic here if you want to show a snackbar or handle errors
                    setState(() {});
                  }
                },
              ),
            ],
            child: BlocBuilder<
              ResturantProfileDataCubit,
              ResturantProfileDataState
            >(
              builder: (context, profileState) {
                final cubit = context.read<ResturantProfileDataCubit>();
                return BlocBuilder<ResturantDataCubit, ResturantDataState>(
                  buildWhen:
                      (previous, current) =>
                          current is GetHomeResLoading ||
                          current is! GetHomeResLoading,
                  builder: (context, state) {
                    if (state is GetHomeResLoading) {
                      return CustomLoading();
                    }
                    final resCubit = context.watch<ResturantDataCubit>();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.openingNow.tr(),
                              style: TextStyles.bimini20W700,
                            ),
                            BlocBuilder<
                              ResturantProfileDataCubit,
                              ResturantProfileDataState
                            >(
                              builder: (context, state) {
                                final cubit =
                                    context.read<ResturantProfileDataCubit>();
                                return Switch(
                                  activeColor: Colors.white,
                                  activeTrackColor: Colors.green,
                                  value: cubit.isOpen ?? false,
                                  onChanged: (value) async {
                                    // Call changeEnable and then refresh profile data
                                    await resCubit.changeEnable(
                                      resID: widget.resId,
                                    );
                                    // After changing, refresh the profile data to get the latest isOpen value
                                    await context
                                        .read<ResturantProfileDataCubit>()
                                        .getResturantProfileData();
                                    setState(
                                      () {},
                                    ); // Force rebuild to reflect changes immediately
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        StateCardRow(
                          totalOrders: (resCubit.ordersNumber ?? 0).toString(),
                          totalRevenue: (resCubit.netRevenue ?? 0).toString(),
                        ),
                        verticalSpace(16),
                        CustomerFeedBackCard(
                          customerRate: (resCubit.customerFeedBack ?? 0)
                              .toString()
                              .substring(0, 1),
                        ),
                        SizedBox(height: 16),
                        RevenueChartSection(
                          data: resCubit.ordersOfLastWeek ?? [],
                        ),
                        SizedBox(height: 16),
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
                        VerticalMenuBody(
                          showRow: false,
                          resId: widget.resId,
                          isAdmin: false,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
