import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/features/client/orders/data/models/get_orders_model.dart';
import 'package:delveria/features/client/orders/logic/cubit/get_orders_cubit.dart';
import 'package:delveria/features/client/orders/order_details_user.dart';
import 'package:delveria/features/client/orders/ui/widgets/my_order_card.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersList extends StatelessWidget {
  const MyOrdersList({
    super.key,
    required this.isOngoing,
    required this.themeState,
    required this.orders,
    required this.orderStatus,
  });

  final bool isOngoing;
  final ThemeState themeState;
  final List<OrderModel> orders;
  final String orderStatus;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Text('No orders found.', style: TextStyle(fontSize: 16)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (BuildContext context, int index) {
        final order = orders[index];
        final status = order.status;
        final time = order.createdAt;
        final List<RestaurantOrder> restaurantOrders = order.orders ?? [];

        final RestaurantOrder? restaurantOrder =
            restaurantOrders.isNotEmpty ? restaurantOrders.first : null;

        final List<OrderItem> items = restaurantOrder?.items ?? [];
        final OrderItem? firstItem = items.isNotEmpty ? items.first : null;

        final String restaurantName =
            firstItem?.item_details?.name ?? 'Unknown Restaurant';
        final String price =
            order.final_price != null ? '${order.final_price} L.E' : 'N/A';
        final String orderNumber =
            order.id != null ? '#${order.orderId}' : '#N/A';
        final String date =
            order.createdAt != null
                ? _formatDate(order.createdAt!)
                : 'Unknown Date';
        final String itemsCount =
            items.isNotEmpty
                ? '${items.length.toString().padLeft(2, '0')} ${AppStrings.items.tr()}'
                : '00 ${AppStrings.items.tr()}';

        return BlocProvider(
          create: (context) => getIt<GetOrdersCubit>(),
          child: MyOrderCard(
            onTap:
                isOngoing == true
                    ? () {}
                    : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OrderDetailsUserScreen(order: order),
                        ),
                      );
                    },
            orderStatus: status,
            time: time,
            isResturant: false,
            orderId: order.id ?? "",
            resId: restaurantOrder?.restaurant_id ?? "",
            themeState: themeState,
            restaurantName: restaurantName,
            price: price,
            orderNumber: orderNumber,
            date: date,
            items: itemsCount,
            isOngoing: isOngoing,
          ),
        );
      },
    );
  }

  String _formatDate(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate);

      final day = dateTime.day;
      final month = _monthName(dateTime.month);
      final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final period = dateTime.hour >= 12 ? 'PM' : 'AM';
      return '$day $month, $hour:$minute $period';
    } catch (e) {
      return isoDate;
    }
  }

  String _monthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return (month >= 1 && month <= 12) ? months[month] : '';
  }
}
