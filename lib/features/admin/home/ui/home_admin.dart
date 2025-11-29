import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/admin/home/logic/cubit/get_home_data_admin_cubit.dart';
import 'package:delveria/features/admin/home/logic/cubit/get_home_data_admin_state.dart';
import 'package:delveria/features/admin/home/ui/orders_over_time_card.dart';
import 'package:delveria/features/admin/home/ui/top_rated_list_screen.dart';
import 'package:delveria/features/admin/home/ui/widgets/top_rated_resturant_body.dart';
import 'package:delveria/features/admin/home/ui/widgets/total_amount_row.dart';
import 'package:delveria/features/admin/home/ui/widgets/total_orders_and_active_users.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/client/home/ui/widgets/top_resturants_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetHomeDataAdminCubit, GetHomeDataAdminState>(
      buildWhen:
          (previous, current) => current is Loading || current is! Loading,
      builder: (context, state) {
        if (state is Loading) {
          return CustomLoading();
        }
        final cubit = context.read<GetHomeDataAdminCubit>();
        return RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: Colors.white,
          elevation: 0,
          onRefresh: () async {
            context.read<GetHomeDataAdminCubit>().getHomeDataAdmin();
          },
          child: Scaffold(
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TotalOrdersAndActiveUsers(
                    totalOrders: cubit.ordersNumber.toString(),
                    netRevenue: cubit.netRevenue.toString(),
                    activeUsers: cubit.activeUsers.toString(),
                    topRatedResturant: cubit.activeRestaurants.toString(),
                  ),

                  verticalSpace(24),

                  TotalAmountRow(
                    totalAmount: cubit.totalAmount.toString(),
                    ordersToday: cubit.ordersToday.toString(),
                  ),

                  verticalSpace(24),
                  OrdersOverTimeCard(data: cubit.ordersOfLastWeek ?? []),
                  verticalSpace(24),
                  TopResturantText(
                    title: AppStrings.topResturants.tr(),
                    withoutPadding: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => BlocProvider(
                                create:
                                    (context) =>
                                        getIt<AllresturantsadminCubit>()
                                          ..getAllRatedResturantsWithoutLocation(),
                                child: TopRatedListScreen(),
                              ),
                        ),
                      );
                    },
                  ),

                  verticalSpace(16),
                  TopRatedResturantBody(),
                  verticalSpace(80),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
