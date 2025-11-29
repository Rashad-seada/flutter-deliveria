import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/orders/data/models/get_orders_model.dart';
import 'package:flutter/material.dart';

class OrderDetailsUserScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsUserScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final address = order.address;
    final userPhone = address?.phone ?? '';
    final addressTitle = address?.address_title ?? '';
    final addressDetails = address?.details ?? '';
    final paymentType = order.payment_type ?? '';
    final items = (order.orders?.isNotEmpty ?? false) ? (order.orders!.first.items ?? []) : [];
    final priceWithoutDelivery = order.final_price_without_delivery_cost ?? 0;
    final deliveryCost = order.final_delivery_cost ?? 0;
    final totalPrice = order.final_price ?? 0;
    final status = order.status ?? '';
    final createdAt = order.createdAt ?? '';
    final updatedAt = order.updatedAt ?? '';
    final deliveryId = order.delivery_id ?? '';

    String formatDate(String? isoDate) {
      if (isoDate == null) return '-';
      try {
        final dateTime = DateTime.parse(isoDate);
        final day = dateTime.day;
        final month = _monthName(dateTime.month);
        final year = dateTime.year;
        final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
        final minute = dateTime.minute.toString().padLeft(2, '0');
        final period = dateTime.hour >= 12 ? 'PM' : 'AM';
        return '$day $month $year, $hour:$minute $period';
      } catch (e) {
        return isoDate;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "#${order.orderId ?? "-"}",
          style: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                "Customer Info",
                style: TextStyles.bimini20W700.copyWith(
                  color: AppColors.primaryDeafult,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Icon(Icons.phone, color: AppColors.primaryDeafult, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    userPhone,
                    style: TextStyles.bimini16W400Body,
                  ),
                ],
              ),
              verticalSpace(10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on, color: AppColors.primaryDeafult, size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          addressTitle,
                          style: TextStyles.bimini16W400Body,
                        ),
                        if (addressDetails.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              addressDetails,
                              style: TextStyles.bimini13W400Grey.copyWith(color: Colors.grey),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                "Payment Type: $paymentType",
                style: TextStyles.bimini16W700.copyWith(
                  color: AppColors.primaryDeafult,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                "Order Items",
                style: TextStyles.bimini20W700.copyWith(
                  color: AppColors.primaryDeafult,
                ),
              ),
              const SizedBox(height: 16),
              ...order.orders?.expand((restOrder) {
                    return restOrder.items?.map((item) {
                      final itemDetails = item.item_details;
                      final sizeDetails = item.size_details;
                      final toppingDetails = item.topping_details ?? [];
                      return Center(
                        child: Container(
                          width: 300,
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                itemDetails?.name ?? '',
                                style: TextStyles.bimini16W700,
                                textAlign: TextAlign.center,
                              ),
                              if ((itemDetails?.description ?? '').isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Text(
                                    itemDetails?.description ?? '',
                                    textAlign: TextAlign.center,
                                    style: TextStyles.bimini13W400Grey.copyWith(color: Colors.grey),
                                  ),
                                ),
                              const SizedBox(height: 6),
                              Text(
                                "Size: ${sizeDetails?.size ?? ''} | Qty: ${sizeDetails?.quantity ?? 1} | Price: ${sizeDetails?.price_after ?? ''} L.E",
                                style: TextStyles.bimini13W400Grey,
                                textAlign: TextAlign.center,
                              ),
                              if (toppingDetails.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Toppings:",
                                        style: TextStyles.bimini13W700Deafult,
                                      ),
                                      ...toppingDetails.map((topping) => Text(
                                            "${topping.topping ?? ''} - ${topping.quantity ?? 1}x - ${topping.price ?? ''} L.E",
                                            style: TextStyles.bimini13W400Grey,
                                          )),
                                    ],
                                  ),
                                ),
                              const SizedBox(height: 4),
                              Text(
                                "Total Item Price: ${item.total_price ?? ''} L.E",
                                style: TextStyles.bimini13W400Grey.copyWith(color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList() ?? [];
                  }) ?? [],
              const SizedBox(height: 32),
              Text(
                "Order Summary",
                style: TextStyles.bimini20W700.copyWith(
                  color: AppColors.primaryDeafult,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order Price:", style: TextStyles.bimini16W700),
                  Text("$priceWithoutDelivery L.E", style: TextStyles.bimini14W500),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Delivery Cost:", style: TextStyles.bimini16W700),
                  Text("$deliveryCost L.E", style: TextStyles.bimini14W500),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: TextStyles.bimini16W700,
                  ),
                  Text(
                    "$totalPrice L.E",
                    style: TextStyles.bimini16W700,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                "Order Status & Dates",
                style: TextStyles.bimini20W700.copyWith(
                  color: AppColors.primaryDeafult,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.info_outline, size: 18, color: AppColors.primaryDeafult),
                  const SizedBox(width: 8),
                  Text(
                    "Status: $status",
                    style: TextStyles.bimini14W500.copyWith(
                      color: AppColors.green
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 18, color: AppColors.primaryDeafult),
                  const SizedBox(width: 8),
                  Text(
                    formatDate(createdAt),
                    style: TextStyles.bimini13W400Grey.copyWith(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.update, size: 18, color: AppColors.primaryDeafult),
                  const SizedBox(width: 8),
                  Text(
                    formatDate(updatedAt),
                    style: TextStyles.bimini13W400Grey.copyWith(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.delivery_dining, size: 18, color: AppColors.primaryDeafult),
                  const SizedBox(width: 8),
                  Text(
                    "Delivery ID: $deliveryId",
                    style: TextStyles.bimini13W400Grey.copyWith(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
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
    return (month > 0 && month < months.length) ? months[month] : '';
  }
}
