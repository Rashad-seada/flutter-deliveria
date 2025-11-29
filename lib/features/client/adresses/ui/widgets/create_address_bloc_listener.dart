import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_cubit.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAddressBlocListener extends StatelessWidget {
  const CreateAddressBlocListener({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateAddressCubit, CreateAddressState>(
      listenWhen: (previous, current) => current is Success || current is Fail,
      listener: (context, state) {
        state.whenOrNull(
          success: (data) {
            print("success");
            showSuccessSnackBar(context, "Address Created Successfully ");
            context.pushNamedAndRemoveUntil(
              Routes.bottomBarScreen,
              arguments: 0,
              predicate: (Route<dynamic> route) => false,
            );
          },
          fail: (error) {
            showErrorSnackBar(context, error.message);
          },
        );
      },
      buildWhen:
          (previous, current) => current is Loading || current is! Loading,
      builder: (context, state) {
        if (state is Loading ||
            state.maybeWhen(loading: () => true, orElse: () => false)) {
          return CustomLoading();
        }
        return child;
      },
    );
  }
}
