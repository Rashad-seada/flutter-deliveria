import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/date_formate.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/data/models/get_orders_resturant_response.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/logic/cubit/orders_resturant_cubit.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/logic/cubit/orders_resturant_state.dart'
    as state;
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/ui/new_orders_details_screen.dart';
import 'package:delveria/features/client/orders/logic/cubit/get_orders_cubit.dart';
import 'package:delveria/features/client/orders/ui/widgets/my_order_card.dart';
import 'package:delveria/features/deliveryAgent/logic/cubit/agent_orders_cubit.dart';
import 'package:delveria/features/deliveryAgent/logic/cubit/agent_orders_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersTabBody extends StatelessWidget {
  const OrdersTabBody({
    super.key,
    this.isDeliveryAgent,
    this.filterFromDate,
    this.filterToDate,
  });
  final bool? isDeliveryAgent;
  final DateTime? filterFromDate;
  final DateTime? filterToDate;

  bool _isWithinRange(DateTime date, DateTime? from, DateTime? to) {
    if (from == null || to == null) return true;
    final dateOnly = DateTime(date.year, date.month, date.day);
    final fromOnly = DateTime(from.year, from.month, from.day);
    final toOnly = DateTime(to.year, to.month, to.day);
    return !dateOnly.isBefore(fromOnly) && !dateOnly.isAfter(toOnly);
  }

  @override
  Widget build(BuildContext context) {
    if (isDeliveryAgent == true) {
      return BlocBuilder<AgentOrdersCubit, AgentOrdersState>(
        builder: (context, state) {
          final cubit = context.read<AgentOrdersCubit>();

          if (state is GetAcceptOrderLoading) {
            return CustomLoading();
          } else if (state is GetAcceptOrderFail) {
            return Center(child: Text('Failed to load orders'));
          } else if (state is GetAcceptOrderSuccess) {
            final orders = cubit.acceptedOrders;

            return ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount: orders.length,
              separatorBuilder: (_, __) => SizedBox(height: 16),
              itemBuilder: (context, index) {
                final order = orders[index];
                return BlocProvider(
                  create: (context) => getIt<GetOrdersCubit>(),
                  child: MyOrderCard(
                    isResturant: true,
                    orderId: order.id,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => BlocProvider(
                                create: (context) => getIt<AgentOrdersCubit>(),
                                child: NewOrdersDetailsScreen(
                                  singleStatus:
                                      order.orders.isNotEmpty
                                          ? (order.orders.first.status ?? "")
                                          : "",

                                  addressDetails: order.address.details,

                                  agentStatus: order.status,
                                  orderStatus: order.status ?? "",
                                  isResturant: false,
                                  orderId: order.id,
                                  recieved: true,
                                  isDeliveryAgent: true,
                                  acceptedOrder: order,
                                  phone: order.address.phone,
                                  address: order.address.addressTitle ?? "",
                                  name: order.userId.firstName,
                                ),
                              ),
                        ),
                      );
                    },
                    orders: true,
                    isDeliveryAgent: isDeliveryAgent,
                    orderStatus:
                        order.status == "Completed"
                            ? "مكتمل"
                            : order.status == "On the way"
                            ? "في الطريق"
                            : order.status == "Pick up"
                            ? "جاري التحضير "
                            : order.status,
                    orderStatusColor:
                        order.status == "Pick up"
                            ? Colors.yellow
                            : order.status == "On the way"
                            ? Colors.green
                            : AppColors.lightGreySecond,
                    restaurantName:
                        "${order.orderId} ${order.orders.length > 1 ? "multi " : order.orders.first.restaurantId.name}", //! show restuant name too
                 
                    shippingPrice:
                        "Shipping Price ${order.finalDeliveryCost} L.E",
                    price:
                        "Order Price ${order.finalPrice.toString().length > 4 ? order.finalPrice.toString().substring(0, 5) : order.finalPrice} L.E",
                    orderNumber: '#${order.orderId}',
                    date: formatDate(order.createdAt),
                    items:
                        '${order.orders.first.items.length.toString().padLeft(2, '0')} Items',
                    isOngoing: order.status != "delivered",
                  ),
                );
              },
            );
          } else {
            // Initial or unknown state
            return Center(child: Text(state.toString()));
          }
        },
      );
    }

    // Restaurant Orders Tab with optional Date Filtering
    return BlocBuilder<OrdersResturantCubit, state.OrdersResturantState>(
      builder: (context, res) {
        if (res is state.Loading) {
          return CustomLoading();
        }
        final cubit = context.read<OrdersResturantCubit>();

        // 1. Filter by status
        List<OrderResturantModel> filteredOrders =
            cubit.ordersResturant
                .where(
                  (e) =>
                      e.status == "Preparing" ||
                      e.status == "Completed" ||
                      e.status == "Delivered" ||
                      e.status == "Canceled" ||
                      e.status == "Ready for Delivery",
                )
                .toList();

        // 2. Filter by date range if both from and to dates are provided
        if (filterFromDate != null && filterToDate != null) {
          filteredOrders =
              filteredOrders.where((order) {
                // Parse createdAt to DateTime. If fails, keep (safe).
                DateTime? createdDate = DateTime.tryParse(
                  order.createdAt ?? "",
                );
                if (createdDate == null) return false;
                return _isWithinRange(
                  createdDate,
                  filterFromDate,
                  filterToDate,
                );
              }).toList();
        }

        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredOrders.length,
            itemBuilder: (BuildContext context, int index) {
              final order = filteredOrders[index];
              final restOrder =
                  order.orders != null && order.orders!.isNotEmpty
                      ? order.orders!.first
                      : null;
              final restaurantId = restOrder?.restaurantId;
              String restaurantName;
              if (restaurantId != null && restaurantId.length > 5) {
                restaurantName = restaurantId.substring(1, 5);
              } else if (restaurantId != null) {
                restaurantName = restaurantId;
              } else {
                restaurantName = 'ID #0123456789';
              }
              // Calculate items count
              int itemsCount = 0;
              if (order.orders != null) {
                for (final ro in order.orders!) {
                  itemsCount += ro.items?.length ?? 0;
                }
              }
              String? singleStatus;
              if (order.orders != null && order.orders!.isNotEmpty) {
                singleStatus = order.orders!.first.status;
              }
              return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => getIt<GetOrdersCubit>()),
                  BlocProvider(
                    create:
                        (context) =>
                            getIt<OrdersResturantCubit>()..getOrdersRestaurant(),
                  ),
                ],
                child: MyOrderCard(
                  isResturant: true,
                  orderStatus: order.status,
                  onTap: () {
                    print("sssstatus $singleStatus");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create:
                                      (context) => getIt<AgentOrdersCubit>(),
                                ),
                                BlocProvider(
                                  create:
                                      (context) =>
                                          getIt<OrdersResturantCubit>()
                                            ..getOrdersRestaurant(),
                                ),
                              ],
                              child: NewOrdersDetailsScreen(
                                singleStatus: singleStatus,
                                orderStatus: order.status ?? "",
                                isResturant: true,
                                orderId: order.id ?? "",
                                phone: order.address?.phone,
                                recieved: true,
                                isDeliveryAgent: false,
                                resturantOrderModel: restOrder,
                                address: order.address?.addressTitle ?? "",
                                name:
                                    "${order.user?.firstName ?? ''}${order.user?.lastName ?? ''}",
                              ),
                            ),
                      ),
                    );
                  },
                  isDeliveryAgent: isDeliveryAgent,
                  newOrders: false,
                  restaurantName: restaurantName,
                  shippingPrice:
                      order.finalDeliveryCost != null
                          ? "Shipping Price ${order.finalDeliveryCost} L.E"
                          : "Shipping Price 0 L.E",
                  price:
                      order.orders != null && order.orders!.isNotEmpty
                          ? 'Total Price ${order.orders!.map((e) => e.priceOfRestaurant ?? 0).fold<num>(0, (prev, curr) => prev + curr)} L.E'
                          : 'Total Price 0 L.E',
                  orderNumber:
                      order.orderId != null ? '#${order.orderId}' : '#162432',
                  date: formatDate(order.createdAt),
                  items:
                      itemsCount > 0
                          ? '${itemsCount.toString().padLeft(2, '0')} Items'
                          : '00 Items',
                ),
              );
            },
          ),
        );
      },
    );
  }
}
