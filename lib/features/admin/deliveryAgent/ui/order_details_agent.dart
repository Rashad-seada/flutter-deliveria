import 'package:delveria/core/func/date_formate.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/admin/deliveryAgent/logic/cubit/agents_cubit.dart';
import 'package:delveria/features/admin/deliveryAgent/logic/cubit/agents_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsAgent extends StatelessWidget {
  const OrderDetailsAgent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgentsCubit, AgentsState>(
      builder: (context, state) {
        final cubit = context.read<AgentsCubit>();
        final order = cubit.orderDetailsModel;
        if (order == null) {
          return const Scaffold(
            body: Center(child: Text('No order details found.')),
          );
        }

        final address = order.address;
        final userName = order.userId;
        final userPhone = address.phone ?? '';
        final addressTitle = address.addressTitle ?? '';
        final addressDetails = address.details ?? '';
        final coordinates = address.coordinates;
        final latitude = coordinates.latitude.toString();
        final longitude = coordinates.longitude.toString();

        final restaurantOrder = order.orders.isNotEmpty ? order.orders.first : null;
        final restaurantId = restaurantOrder?.restaurantId ?? '';

        String appBarTitle = "Order #";
        if (order.id.length > 6) {
          appBarTitle += order.id.substring(1, 6);
        } else        appBarTitle += order.id;
      

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
              appBarTitle,
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
verticalSpace(10),                  Row(
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
                    "Payment Type: ${order.paymentType}",
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
                  ...order.orders.expand((restOrder) {
                    return [
                      ...restOrder.items.map((item) {
                        final itemDetails = item.itemDetails;
                        final sizeDetails = item.sizeDetails;
                        final toppingDetails = item.toppingDetails;
                        return Center(
                          child: Container(
                            width: 300.w,
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
                                  itemDetails.name ?? '',
                                  style: TextStyles.bimini16W700,
                                  textAlign: TextAlign.center,
                                ),
                                if ((itemDetails.description ?? '').isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text(
                                                                        textAlign: TextAlign.center,

                                      itemDetails.description ?? '',
                                      style: TextStyles.bimini13W400Grey.copyWith(color: Colors.grey),
                                    ),
                                  ),
                                const SizedBox(height: 6),
                                Text(
                                                                    textAlign: TextAlign.center,

                                  "Size: ${sizeDetails.size ?? ''} | Qty: ${sizeDetails.quantity ?? 1} | Price: ${sizeDetails.priceAfter ?? ''} L.E",
                                  style: TextStyles.bimini13W400Grey,
                                ),
                                if (toppingDetails.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Column(
                                      spacing: 4,
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
                                  "Total Item Price: ${item.totalPrice ?? ''} L.E",
                                  style: TextStyles.bimini13W400Grey.copyWith(color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ];
                  }),
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
                      Text("${order.finalPriceWithoutDeliveryCost} L.E", style: TextStyles.bimini14W500),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delivery Cost:", style: TextStyles.bimini16W700),
                      Text("${order.finalDeliveryCost} L.E", style: TextStyles.bimini14W500),
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
                        "${order.finalPrice} L.E",
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
                        "Status: ${order.status}",
                        style: TextStyles.bimini14W500,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 18, color: AppColors.primaryDeafult),
                      const SizedBox(width: 8),
                     
                      Text(
                        formatDate(order.createdAt),
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
                        formatDate(order.updatedAt),
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
                        "Delivery ID: ${order.deliveryId}",
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
      },
    );
  }
}
