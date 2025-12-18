import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/date_formate.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/data/models/get_orders_resturant_response.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/logic/cubit/orders_resturant_cubit.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/logic/cubit/orders_resturant_state.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/ui/new_orders_details_screen.dart';
import 'package:delveria/features/client/orders/logic/cubit/get_orders_cubit.dart';
import 'package:delveria/features/client/orders/ui/widgets/my_order_card.dart';
import 'package:delveria/features/deliveryAgent/data/models/get_not_accepted_order_agent.dart';
import 'package:delveria/features/deliveryAgent/logic/cubit/agent_orders_cubit.dart';
import 'package:delveria/features/deliveryAgent/logic/cubit/agent_orders_state.dart'
    as agent;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewOrdersTapBody extends StatelessWidget {
  const NewOrdersTapBody({super.key, this.isDeliveryAgent});
  final bool? isDeliveryAgent;

  @override
  Widget build(BuildContext context) {
    if (isDeliveryAgent == true) {
      return BlocBuilder<AgentOrdersCubit, agent.AgentOrdersState>(
        builder: (context, agentState) {
          List<AgentOrder> newOrders = [];
          if (agentState is agent.Success) {
            newOrders = context.read<AgentOrdersCubit>().agentOrders;
          }
          print(newOrders);
          if (agentState is Loading) {
            return CustomLoading();
          }
          if (agentState is Fail) {
            return Center(child: Text("Error"));
          }
          if (newOrders.isEmpty) {
            return const Center(child: Text("No new orders"));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: newOrders.length,
            itemBuilder: (BuildContext context, int index) {
              final order = newOrders[index];
              int itemsCount = order.orders.first.items.length;
              return BlocProvider(
                create: (context) => getIt<GetOrdersCubit>(),
                child: MyOrderCard(
                  isResturant: false,
                  onTap: () {
                    print(order.orders.first.status);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => BlocProvider(
                              create: (context) => getIt<AgentOrdersCubit>(),
                              child: NewOrdersDetailsScreen(
                                singleStatus:
                                    order.orders.isNotEmpty
                                        ? (order.orders.first.status )
                                        : "",

                                addressDetails: order.address.details,
                                isResturant: false,
                                orderId: order.id,
                                recieved: false,
                                orderStatus: order.orders.first.status ,
                                isDeliveryAgent: true,
                                agentOrder: order,
                                phone: order.address.phone,
                                address: order.address.addressTitle ,
                                name: order.user.firstName,
                              ),
                            ),
                      ),
                    );
                  },
                  isDeliveryAgent: isDeliveryAgent,
                  newOrders: true,
                  restaurantName:
                      "${order.orderId} ${order.orders.length > 1 ? "multi " : order.orders.first.restaurantId.name}", //! show restuant name too
                  shippingPrice:
                      order.finalDeliveryCost != null
                          ? "Shipping Price ${order.finalDeliveryCost} L.E"
                          : "Shipping Price 0 L.E",
                  price:
                      order.finalPrice != null
                          ? 'Order Price ${order.finalPrice.toString().length > 4 ? order.finalPrice.toString().substring(0, 5) : order.finalPrice.toString()} L.E'
                          : 'Order Price 0 L.E',
                  orderNumber:
                      order.id != null
                          ? '#${order.orderId}'
                          : '#162432',
                  date: formatDate(order.createdAt),
                  items:
                      itemsCount > 0
                          ? '${itemsCount.toString().padLeft(2, '0')} Items'
                          : '00 Items',
                ),
              );
            },
          );
        },
      );
    } else {
      return BlocBuilder<OrdersResturantCubit, OrdersResturantState>(
        builder: (context, state) {
          if (state is Loading) {
            return CustomLoading();
          }
          final cubit = context.read<OrdersResturantCubit>();
          final List<OrderResturantModel> newOrders =
              cubit.ordersResturant
                  .where(
                    (e) =>
                        (e.orders?.any((order) => order.status == "Pending Approval") ??
                            false),
                  )
                  .toList();
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: newOrders.length,
            itemBuilder: (BuildContext context, int index) {
              final order = newOrders[index];
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
              return BlocProvider(
                create: (context) => getIt<GetOrdersCubit>(),
                child: MyOrderCard(
                  isResturant: true,
                  onTap: () {
                    print("🔘 Tapped order: ${order.id}");
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
                                          getIt<OrdersResturantCubit>(),
                                ),
                              ],
                              child: NewOrdersDetailsScreen(
                                singleStatus:
                                    order.orders?.isNotEmpty == true
                                        ? order.orders!
                                            .where(
                                              (e) => e.status == "Preparing",
                                            )
                                            .join(', ')
                                        : "",

                                orderStatus: order.status ?? "",
                                isResturant: true,
                                orderId: order.id ?? "",
                                phone: order.address?.phone,
                                recieved: false,
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
                  isDeliveryAgent: isDeliveryAgent,
                  newOrders: true,
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
                      order.id != null
                          ? '#${order.orderId}'
                          : '#162432',
                  date: formatDate(order.createdAt),
                  items:
                      itemsCount > 0
                          ? '${itemsCount.toString().padLeft(2, '0')} Items'
                          : '00 Items',
                ),
              );
            },
          );
        },
      );
    }
  }
}
