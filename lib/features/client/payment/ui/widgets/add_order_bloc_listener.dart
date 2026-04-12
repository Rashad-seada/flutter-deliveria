import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOrderBlocListener extends StatelessWidget {
  const AddOrderBlocListener({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToCartCubit, AddToCartState>(
      listenWhen:
          (previous, current) =>
              current is AddOrderSuccess || current is AddOrderFail,
      listener: (context, state) {
        state.whenOrNull(
          addOrderSuccess: (data) {
            showSuccessSnackBar(context, "Order placed successfully");
            // Use pushNamedAndRemoveUntil to clear the checkout stack and ensure we reach the success screen
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.successOrderScreen,
              (route) => route.settings.name == Routes.bottomBarScreen || route.isFirst,
            );
          },
          addOrderFail: (error) => showErrorSnackBar(context, error.message),
        );
      },
      buildWhen:
          (previous, current) =>
              current is AddOrderLoading || current is! AddOrderLoading,
      builder: (context, state) {
        if (state is AddOrderLoading ||
            state.maybeWhen(addOrderLoading: () => true, orElse: () => false)) {
          return CustomLoading();
        }
        return child;
      },
    );
  }
}
