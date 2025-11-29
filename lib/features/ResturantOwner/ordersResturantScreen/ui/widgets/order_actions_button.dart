import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/data/models/orders_details_view_model.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/logic/cubit/orders_resturant_cubit.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/logic/cubit/orders_resturant_state.dart';
import 'package:delveria/features/client/payment/ui/widgets/track_order_button_row.dart';
import 'package:delveria/features/deliveryAgent/logic/cubit/agent_orders_cubit.dart';
import 'package:delveria/features/deliveryAgent/logic/cubit/agent_orders_state.dart';
import 'package:delveria/features/deliveryAgent/ui/widgets/accept_order_bloc_listener.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/strings.dart';

class OrderActionButtons extends StatelessWidget {
  final OrderDetailsViewModel viewModel;

  const OrderActionButtons({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    if (viewModel.isReceived) {
      return _buildReceivedOrderActions(context);
    }
    return _buildPendingOrderActions(context);
  }

  Widget _buildReceivedOrderActions(BuildContext context) {
    return BlocBuilder<OrdersResturantCubit, OrdersResturantState>(
      builder: (context, state) {
        return BlocConsumer<AgentOrdersCubit, AgentOrdersState>(
          builder: (context, state) {
            if (viewModel.isRestaurant == true) {
              return _buildRestaurantActions(context);
            }
            return _buildAgentActions(context);
          },
          listener: (context, state) {
            if (viewModel.isRestaurant == true &&
                state is ReadyForPickUpSuccess) {
              showSuccessSnackBar(context, AppStrings.success.tr());
            } else if (viewModel.isRestaurant == false &&
                state is UpdateOrderStatusAgentSuccess) {
              showSuccessSnackBar(context, AppStrings.success.tr());
            }
          },
        );
      },
    );
  }

  Widget _buildRestaurantActions(BuildContext context) {
    if (viewModel.singleStatus != "Preparing" ||
        SharedPrefHelper.getBool(SharedPrefKeys.showbtn) == false) {
      return SizedBox();
    }
    return Center(
      child: AppButton(
        title: "Ready For pickUp ",
        onPressed: () {
          context.read<AgentOrdersCubit>().readyForPickUp(
            orderId: viewModel.orderId ?? "",
          );
          context.read<OrdersResturantCubit>().getOrdersRestuant();
          SharedPrefHelper.setData(SharedPrefKeys.showbtn, false);
          context.pop();
        },
      ),
    );
  }

  Widget _buildAgentActions(BuildContext context) {
    return BlocBuilder<AgentOrdersCubit, AgentOrdersState>(
      builder: (context, state) {
        final cubit = context.read<AgentOrdersCubit>();
        return TrackOrderButtonRow(
          ftitle: "On the way",
          sTitle: "Delivered",
          fOnPressed: _getFirstButtonAction(cubit),
          sOnPressed: _getSecondButtonAction(cubit),
          fColor: _getFirstButtonColor(),
          sTitleColor: Colors.white,
          sColor: _getSecondButtonColor(),
        );
      },
    );
  }

  VoidCallback _getFirstButtonAction(AgentOrdersCubit cubit) {
    if (viewModel.agentStatus != "Accepted" &&
        viewModel.agentStatus != "On the way" &&
        viewModel.agentStatus != "Completed") {
      return () {
        cubit.updateOrderStatusAgent(
          orderId: viewModel.acceptedOrder?.id ?? "",
          body: {"status": "On the way"},
        );
        cubit.getAcceptedOrders();
      };
    }
    return () {};
  }

  VoidCallback _getSecondButtonAction(AgentOrdersCubit cubit) {
    if (viewModel.agentStatus == "On the way") {
      return () {
        cubit.updateOrderStatusAgent(
          orderId: viewModel.acceptedOrder?.id ?? "",
          body: {"status": "DELIVERED"},
        );
      };
    }
    return () {};
  }

  Color _getFirstButtonColor() {
    if (viewModel.agentStatus == "Accepted" ||
        viewModel.agentStatus == "On the way" ||
        viewModel.orderStatus == "Completed") {
      return Colors.grey;
    }
    return AppColors.primary;
  }

  Color _getSecondButtonColor() {
    if (viewModel.agentStatus == "Accepted") {
      return Colors.grey;
    }
    if (viewModel.agentStatus == "On the way") {
      return AppColors.primary;
    }
    return Colors.grey;
  }

  Widget _buildPendingOrderActions(BuildContext context) {
    return BlocConsumer<AgentOrdersCubit, AgentOrdersState>(
      builder: (context, state) {
        final cubit = context.read<AgentOrdersCubit>();
        return AcceptOrderBlocListener(
          child: TrackOrderButtonRow(
            showSecond: false,
            fWidth: 200.w,
            ftitle: "Accept",
            sTitle:
                viewModel.isDeliveryAgent ? "Reject" : AppStrings.cancel.tr(),
            fOnPressed: () {
              if (viewModel.isDeliveryAgent) {
                cubit.acceptOrder(orderId: viewModel.agentOrder?.id ?? "");
              } else {
                cubit.acceptOrderRestuarnt(orderId: viewModel.orderId ?? "");
                context.pop();
                context.read<OrdersResturantCubit>().getOrdersRestuant();
              }
            },
          ),
        );
      },
      listener: (context, state) {
        if (viewModel.isDeliveryAgent && state is AcceptOrderSuccess) {
          showSuccessSnackBar(context, AppStrings.success.tr());
        } else if (!viewModel.isDeliveryAgent &&
            state is AcceptOrderResSuccess) {
          showSuccessSnackBar(context, AppStrings.success.tr());
        }
      },
    );
  }
}
