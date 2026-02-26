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
import 'package:delveria/features/admin/deliveryAgent/ui/widgets/admin_order_card.dart';
import 'package:delveria/features/admin/deliveryAgent/ui/order_details_agent.dart';
import 'package:delveria/core/di/dependancy_injection.dart';

import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/admin/deliveryAgent/ui/widgets/admin_order_filter_bottom_sheet.dart';
import 'package:delveria/features/deliveryAgent/ui/widgets/delivery_filter_bottom_sheet.dart';

class AcceptedOrdersScreen extends StatefulWidget {
  const AcceptedOrdersScreen({
    super.key,
    required this.isAccepted,
    required this.agents,
  });
  final bool isAccepted;
  final List<AgentModel> agents;

  @override
  State<AcceptedOrdersScreen> createState() => _AcceptedOrdersScreenState();
}

class _AcceptedOrdersScreenState extends State<AcceptedOrdersScreen> {
  FilterData _currentFilters = FilterData();

  void _applyFilters(FilterData filters) {
    setState(() {
      _currentFilters = filters;
    });
    context.read<AgentsCubit>().getAllOrders(
      date: filters.date,
      paymentType: filters.paymentType,
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AdminOrderFilterBottomSheet(
        initialFilters: _currentFilters,
        onApply: _applyFilters,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          showRefresh: true,
          title: widget.isAccepted ? "Accepted Orders" : "Not Accepted Orders",
          widget: GestureDetector(
            onTap: _showFilterBottomSheet,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.filter_list, color: AppColors.primaryDeafult),
            ),
          ),
        ),
      ),
      body: BlocBuilder<AgentsCubit, AgentsState>(
        builder: (context, state) {
          final cubit = context.read<AgentsCubit>();
          final orders =
              widget.isAccepted
                  ? cubit.acceptedOrders
                  : cubit.notAcceptedOrders;

          if (state is GetAllOrdersLoading) {
             return Center(child: CustomLoading());
          }

          if (orders.isEmpty) {
            return const Center(child: Text("No orders found."));
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                print("sssssssssss${widget.agents}");
                final matchedAgent = widget.agents.firstWhere(
                  (agent) =>
                      agent.id?.toString() == order.deliveryId.toString(),
                  orElse: () => widget.agents.first,
                );
                if (matchedAgent != null && matchedAgent.name != null) {
                  agentNameById = matchedAgent.name!;
                }
              }

              return GestureDetector(
                onTap: () {
                  if (order.id != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => BlocProvider(
                              create:
                                  (context) =>
                                      getIt<AgentsCubit>()
                                        ..getEachOrderDeatils(order.id!),
                              child: const OrderDetailsAgent(),
                            ),
                      ),
                    );
                  }
                },
                child: AdminOrderCard(
                  restaurantName:
                      "Order #${restaurantName.length > 5 ? restaurantName.substring(0, 5) : restaurantName}", // Improving display
                  agentName: agentNameById.isNotEmpty ? agentNameById : null,
                  price: price,
                  shippingPrice: shippingPrice,
                  orderNumber: orderNumber,
                  date: date,
                  itemsCount: items.length,
                  isMulti: showMulti,
                  status: widget.isAccepted ? "Accepted" : "Not Accepted",
                ),
              );
            },
          );
        },
      ),
    );
  }
}
