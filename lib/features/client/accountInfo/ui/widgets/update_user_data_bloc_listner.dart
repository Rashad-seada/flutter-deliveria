import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_cubit.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserDataBlocListner extends StatelessWidget {
  const UpdateUserDataBlocListner({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserDataCubit, UserDataState>(
      listenWhen:
          (previous, current) =>
              current is UpdateSuccess || current is UpdateFail,
      listener: (context, state) {
        state.whenOrNull(
          updateSuccess: (data) {
            showSuccessSnackBar(context, "Your info updated successfully");
            context.read<UserDataCubit>().getUserData();
            context.pop();
          },
          updateFail: (error) {
            print(error.message);
            showErrorSnackBar(context, error.message);
          },
        );
      },
      buildWhen:
          (previous, current) =>
              current is UpdateLoading || current is! UpdateLoading,
      builder: (context, state) {
        if (state is UpdateLoading ||
            state.maybeWhen(updateLoading: () => true, orElse: () => false)) {
          return CustomLoading();
        }
        return child;
      },
    );
  }
}
