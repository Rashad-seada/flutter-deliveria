import 'package:delveria/core/func/date_formate.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/admin/deliveryAgent/data/models/get_delivery_agent_response.dart';
import 'package:delveria/features/admin/deliveryAgent/logic/cubit/agents_cubit.dart';
import 'package:delveria/features/admin/deliveryAgent/logic/cubit/agents_state.dart';
import 'package:delveria/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AcceptedOrdersScreen extends StatelessWidget {
  const AcceptedOrdersScreen({
    super.key,
    required this.isAccepted,
    required this.agents,
  });
  final bool isAccepted;
  final List<AgentModel> agents;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: isAccepted ? "Accepted Orders" : "Not Accepted Orders",
        ),
      ),
      body: BlocBuilder<AgentsCubit, AgentsState>(
        builder: (context, state) {
          final cubit = context.read<AgentsCubit>();
          final orders =
              isAccepted ? cubit.acceptedOrders : cubit.notAcceptedOrders;

          if (orders.isEmpty) {
            return const Center(child: Text("No orders found."));
          }

          return ListView.separated(
            itemCount: orders.length,
            separatorBuilder: (context, index) => verticalSpace(5),
            itemBuilder: (context, index) {
              final order = orders[index];

              final restaurantName = order.orderId.toString();
              final price =
                  order.orders?.first.items?.first.totalPrice?.toString() ??
                  "0";
              final orderNumber = order.orderId.toString();
              final date = order.createdAt ?? "";
              final items = order.orders?.first.items ?? [];
              final shippingPrice = order.finalDeliveryCost.toString();
              final bool showMulti =
                  order.orders != null && order.orders!.length > 1;

              // Find the agent name by deliveryId matching agent id
              String agentNameById = '';
              if (order.deliveryId != null) {
                print("sssssssssss$agents");
                final matchedAgent = agents.firstWhere(
                  (agent) =>
                      agent.id?.toString() == order.deliveryId.toString(),
                  orElse: () => agents.first,
                );
                if (matchedAgent != null && matchedAgent.name != null) {
                  agentNameById = matchedAgent.name!;
                }
              }

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundColor: AppColors.primaryDeafult,
                          child: Icon(
                            Icons.shopping_basket_outlined,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 200.w,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            restaurantName,
                                            style: TextStyles.bimini16W700,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(width: 8),

                                        // Required: agent name by delivery id
                                        Text(
                                          agentNameById.isNotEmpty
                                              ? agentNameById
                                              : '-',
                                          style: TextStyles.bimini16W700
                                              .copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryDeafult,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(width: 8),

                                        Text(
                                          '|',
                                          style: TextStyles.bimini16W700
                                              .copyWith(
                                                color: AppColors.grey
                                                    .withOpacity(0.6),
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (showMulti) ...[
                                    SizedBox(width: 8),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryDeafult
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        "Multi",
                                        style: TextStyles.bimini12W400Grey
                                            .copyWith(
                                              color: AppColors.primaryDeafult,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              verticalSpace(5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    price,
                                    style: TextStyles.bimini13W700Deafult
                                        .copyWith(
                                          color:
                                              themeState.themeMode ==
                                                      ThemeMode.dark
                                                  ? AppColors.lightGrey
                                                  : AppColors.darkGrey,
                                        ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "Shipping price : ",
                                    style: TextStyles.bimini12W400Grey,
                                  ),
                                  Text(
                                    shippingPrice ?? "",
                                    style: TextStyles.bimini13W700Deafult
                                        .copyWith(
                                          color:
                                              themeState.themeMode ==
                                                      ThemeMode.dark
                                                  ? AppColors.lightGrey
                                                  : AppColors.darkGrey,
                                        ),
                                  ),
                                ],
                              ),
                              verticalSpace(16),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      orderNumber,
                                      style: TextStyles.sen14W400.copyWith(
                                        color:
                                            themeState.themeMode ==
                                                    ThemeMode.dark
                                                ? AppColors.grey
                                                : AppColors.darkGrey,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    horizontalSpace(5),
                                    SizedBox(
                                      height: 20.h,
                                      child: VerticalDivider(),
                                    ),
                                    horizontalSpace(5),
                                    Text(
                                      formatDate(date),
                                      style: TextStyles.bimini13W400Grey,
                                    ),
                                    horizontalSpace(5),
                                    SizedBox(
                                      height: 20.h,
                                      child: VerticalDivider(),
                                    ),
                                    horizontalSpace(10),
                                    Text(
                                      items.length.toString(),
                                      style: TextStyles.bimini13W400Grey,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    SizedBox(height: 16),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
