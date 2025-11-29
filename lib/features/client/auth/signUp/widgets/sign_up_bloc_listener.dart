import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/client/auth/signUp/logic/cubit/signup_cubit.dart';
import 'package:delveria/features/client/auth/signUp/logic/cubit/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBlocListener extends StatelessWidget {
  const SignUpBlocListener({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      child: child,
      listenWhen:
          (previous, current) =>
              current is Loading || current is Success || current is Fail,

      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            Center(
              child: CustomLoading(),
            );
          },
          success: (data) {
            showSuccessSnackBar(context, "Account created successfully");
            context.pushNamedAndRemoveUntil(
              Routes.loginScreen,

              predicate: (Route<dynamic> route) => false,
            );
          },
          fail: (apiErrorModel) {
            showErrorSnackBar(context, apiErrorModel.message);

            print(apiErrorModel.message);
          },
        );
      },
    );
  }
}
