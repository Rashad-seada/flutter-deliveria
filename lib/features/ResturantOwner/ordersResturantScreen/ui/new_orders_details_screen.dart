import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/data/models/get_orders_resturant_response.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/data/models/orders_details_view_model.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/logic/cubit/orders_resturant_cubit.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/ui/widgets/customer_info_section.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/ui/widgets/customer_order_details_item.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/ui/widgets/order_actions_button.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/ui/widgets/order_app_bar.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/ui/widgets/resturant_order_group.dart';
import 'package:delveria/features/deliveryAgent/data/models/get_accepted_orders.dart';
import 'package:delveria/features/deliveryAgent/data/models/get_not_accepted_order_agent.dart';
import 'package:delveria/features/deliveryAgent/logic/cubit/agent_orders_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/order_summary_section.dart';

class NewOrdersDetailsScreen extends StatefulWidget {
  const NewOrdersDetailsScreen({
    super.key,
    required this.recieved,
    required this.isDeliveryAgent,
    this.resturantOrderModel,
    this.address,
    this.name,
    this.phone,
    this.agentOrder,
    this.acceptedOrder,
    this.orderId,
    this.isResturant,
    this.agentStatus,
    this.orderStatus,
    this.addressDetails,
    this.singleStatus,
  });

  final bool recieved;
  final bool isDeliveryAgent;
  final ResturantOrderModel? resturantOrderModel;
  final String? address;
  final String? name;
  final String? phone;
  final AgentOrder? agentOrder;
  final AcceptedOrder? acceptedOrder;
  final String? orderId;
  final bool? isResturant;
  final String? agentStatus;
  final String? singleStatus;
  final String? orderStatus;
  final String? addressDetails;

  @override
  State<NewOrdersDetailsScreen> createState() => _NewOrdersDetailsScreenState();
}

class _NewOrdersDetailsScreenState extends State<NewOrdersDetailsScreen> {
  late final OrderDetailsViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = OrderDetailsViewModel(
      isDeliveryAgent: widget.isDeliveryAgent,
      isRestaurant: widget.isResturant ?? false,
      isReceived: widget.recieved,
      orderId: widget.orderId,
      agentStatus: widget.agentStatus,
      orderStatus: widget.orderStatus,
      singleStatus: widget.singleStatus,
      customerName: widget.name,
      customerPhone: widget.phone,
      customerAddress: widget.address,
      addressDetails: widget.addressDetails,
      paymentType:
          widget.acceptedOrder?.paymentType ?? widget.agentOrder?.paymentType,
      restaurantOrderModel: widget.resturantOrderModel,
      agentOrder: widget.agentOrder,
      acceptedOrder: widget.acceptedOrder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrderAppBar(
        isDeliveryAgent: widget.isDeliveryAgent,
        orderId: viewModel.formattedOrderId,
        onUpdateTap: widget.isDeliveryAgent
            ? () async {
                final status = await SharedPrefHelper.getString(
                  SharedPrefKeys.agentStatus,
                );
                context.read<AgentOrdersCubit>().updateOrderStatusAgent(
                  orderId: viewModel.formattedOrderId,
                  body: {"status": status ?? ""},
                );
              }
            : null,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(20),
                  CustomerInfoSection(
                    name: viewModel.customerName,
                    phone: viewModel.customerPhone,
                    address: viewModel.customerAddress,
                    addressDetails: viewModel.addressDetails,
                    isDeliveryAgent: viewModel.isDeliveryAgent,
                  ),
                  viewModel.isDeliveryAgent
                      ? SizedBox()
                      : const SizedBox(height: 32),
                  _buildOrderSection(),
                  verticalSpace(40),
                  OrderActionButtons(viewModel: viewModel),
                  verticalSpace(100),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOrderSection() {
    if (!viewModel.isDeliveryAgent) {
      return _buildRestaurantOrderSection();
    }
    return _buildDeliveryAgentOrderSection();
  }

  Widget _buildRestaurantOrderSection() {
    final items = viewModel.restaurantOrderModel?.items ?? [];
    final branch = viewModel.restaurantOrderModel?.branchId;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.ordersDetails.tr(), style: TextStyles.bimini20W700),
        if (branch != null && (branch.branchName ?? branch.name ?? '').isNotEmpty) ...[
          verticalSpace(8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.primaryDeafult.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(Icons.store_outlined, size: 18.sp, color: AppColors.primaryDeafult),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        branch.branchName ?? branch.name ?? '',
                        style: TextStyles.bimini14W700.copyWith(color: AppColors.primaryDeafult),
                      ),
                      if (branch.address != null && branch.address!.isNotEmpty)
                        Text(
                          branch.address!,
                          style: TextStyles.bimini12W500.copyWith(color: Colors.grey.shade600),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        verticalSpace(24),
        ...items.map((item) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomerOrderDetailsItem(
                title:
                    item.itemDetails?.name ?? AppStrings.chickenSandwich.tr(),
                description: item.itemDetails?.description ?? '',
              ),
              verticalSpace(8),
              CustomerOrderDetailsItem(
                title: item.sizeDetails?.size ?? AppStrings.fries.tr(),
                description:
                    '${item.sizeDetails?.quantity ?? 1}x ${item.sizeDetails?.size ?? AppStrings.fries.tr()} - ${item.sizeDetails?.priceAfter ?? ''} L.E',
              ),
              verticalSpace(8),
              if (item.toppingDetails != null)
                ...item.toppingDetails!.map(
                  (e) => CustomerOrderDetailsItem(
                    title: e.topping ?? AppStrings.coke.tr(),
                    description:
                        '${e.quantity ?? 1}x ${e.topping ?? AppStrings.coke.tr()} - ${e.price ?? ''} L.E',
                  ),
                ),
              CustomerOrderDetailsItem(
                title: AppStrings.description.tr(),
                description: "${item.description}",
              ),
              verticalSpace(16),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildDeliveryAgentOrderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Type: ${viewModel.paymentType ?? ''}",
          style: TextStyles.bimini16W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
        verticalSpace(32),
        Text(
          "Order Items",
          style: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
        verticalSpace(16),
        if (viewModel.acceptedOrder != null)
          ...viewModel.acceptedOrder!.orders.map(
            (order) => RestaurantOrderGroup(restaurantOrder: order),
          )
        else if (viewModel.agentOrder != null)
          ...viewModel.agentOrder!.orders.map(
            (order) => RestaurantOrderGroup(restaurantOrder: order),
          ),
        verticalSpace(32),
        if (viewModel.acceptedOrder != null)
          OrderSummarySection(
            orderPrice:
                viewModel.acceptedOrder!.finalPriceWithoutDeliveryCost
                    .toString(),
            deliveryCost: viewModel.acceptedOrder!.finalDeliveryCost.toString(),
            totalPrice: viewModel.acceptedOrder!.finalPrice.toString(),
          )
        else if (viewModel.agentOrder != null)
          OrderSummarySection(
            orderPrice:
                viewModel.agentOrder!.finalPriceWithoutDeliveryCost.toString(),
            deliveryCost: viewModel.agentOrder!.finalDeliveryCost.toString(),
            totalPrice: viewModel.agentOrder!.finalPrice.toString(),
          ),
      ],
    );
  }
}
