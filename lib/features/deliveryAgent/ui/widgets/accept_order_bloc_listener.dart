import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/features/deliveryAgent/logic/cubit/agent_orders_cubit.dart';
import 'package:delveria/features/deliveryAgent/logic/cubit/agent_orders_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcceptOrderBlocListener extends StatelessWidget {
  const AcceptOrderBlocListener({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgentOrdersCubit, AgentOrdersState>(
      listenWhen:
          (previous, current) =>
              current is AcceptOrderSuccess || current is AcceptOrderFail,
      listener: (context, state) {
        final cubit = context.read<AgentOrdersCubit>();
        state.whenOrNull(
          acceptOrderSuccess: (data) {
            showSuccessSnackBar(context, "Order accepted successfully ");
            cubit.getCurrentOrdersAgent();
            context.pop();
          },
          acceptOrderFail: (error) {
            print(error.message);
            showErrorSnackBar(context, error.message);
          },
        );
      },
      buildWhen:
          (previous, current) =>
              current is AcceptOrderLoading || current is! AcceptOrderLoading,
      builder: (context, state) {
        if (state is AcceptOrderLoading ||
            state.maybeWhen(
              acceptOrderLoading: () => true,
              orElse: () => false,
            )) {}
        return child;
      },
    );
  }
}
