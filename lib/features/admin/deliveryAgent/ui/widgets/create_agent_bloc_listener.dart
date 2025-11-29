import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/admin/deliveryAgent/logic/cubit/agents_cubit.dart';
import 'package:delveria/features/admin/deliveryAgent/logic/cubit/agents_state.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/resturant_admin_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAgentBlocListener extends StatelessWidget {
  const CreateAgentBlocListener({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgentsCubit, AgentsState>(
      listenWhen:
          (previous, current) =>
              current is CreateSuccess || current is CreateFail,
      listener: (context, state) {
        final cubit = context.read<AgentsCubit>();
        state.whenOrNull(
          createSuccess: (data) {
            showDialog(
              context: context,
              builder: (index) {
                return RestaurantAdminDialog(
                  userName: cubit.phoneController.text,
                  password: cubit.passwordContoller.text,
                  isAgent: true,
                );
              },
            );
          },
          createFail: (error) {
            print(error.message);
            showErrorSnackBar(context, error.message);
          },
        );
      },
      buildWhen:
          (previous, current) =>
              current is CreateLoading || current is! CreateLoading,
      builder: (context, state) {
        if (state is CreateLoading ||
            state.maybeWhen(createLoading: () => true, orElse: () => false)) {
          return CustomLoading();
        }
        return child;
      },
    );
  }
}
