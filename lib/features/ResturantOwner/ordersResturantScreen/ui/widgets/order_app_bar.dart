import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/deliveryAgent/logic/cubit/agent_orders_cubit.dart';
import 'package:delveria/features/deliveryAgent/logic/cubit/agent_orders_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDeliveryAgent;
  final String orderId;
  final VoidCallback? onUpdateTap;

  const OrderAppBar({
    Key? key,
    required this.orderId,
    this.onUpdateTap,
    this.isDeliveryAgent = false,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    if (!isDeliveryAgent) {
      return ArrowBackAppBarWithTitle(
        showTitle: true,
        onUpdateTap: onUpdateTap,
        update: false,
        title: "Order # $orderId",
        titleStyle: TextStyles.bimini20W700.copyWith(
          color: AppColors.primaryDeafult,
        ),
      );
    }
    return BlocConsumer<AgentOrdersCubit, AgentOrdersState>(
      builder: (context, state) {
        return ArrowBackAppBarWithTitle(
          showTitle: true,
          onUpdateTap: onUpdateTap,
          update: false,
          title: "Order # $orderId",
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        );
      },
      listener: (context, state) {
        state.whenOrNull(
          updateOrderStatusAgentSuccess: (data) {
            showSuccessSnackBar(
              context,
              AppStrings.orderStatusUpdatedSuccess.tr(),
            );
            context.read<AgentOrdersCubit>().getAcceptedOrders();
            context.pop();
          },
          updateOrderStatusAgentFail: (error) {
            showErrorSnackBar(context, error.message);
          },
        );
      },
    );
  }
}
