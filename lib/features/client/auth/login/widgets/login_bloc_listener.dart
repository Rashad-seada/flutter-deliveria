import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_cubit.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_state.dart';
import 'package:delveria/features/client/auth/login/logic/cubit/login_cubit.dart';
import 'package:delveria/features/client/auth/login/logic/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAddressCubit, CreateAddressState>(
      builder: (context, state) {
        final adressCubit = context.read<CreateAddressCubit>();
        return BlocConsumer<LoginCubit, LoginState>(
          listenWhen: (previous, current) =>
              current is LoginSuccess || current is LoginFail,
          listener: (context, state) {
            final cubit = context.read<LoginCubit>();
            state.whenOrNull(
              success: (data) {
                showSuccessSnackBar(context, "Login successfully ");
                if (cubit.userType == "user") {
                  if (adressCubit.addresses.isEmpty ||
                      adressCubit.addresses == []) {
                    // Go to address list, but when back, go to home (bottom bar)
                    context.pushNamed(Routes.addressListScreen).then((value) {
                      // When user returns (back) from address list, go to home
                      context.pushNamedAndRemoveUntil(
                        Routes.bottomBarScreen,
                        arguments: 0,
                        predicate: (Route<dynamic> route) => false,
                      );
                    });
                  } else {
                    context.pushNamedAndRemoveUntil(
                      Routes.bottomBarScreen,
                      arguments: 0,
                      predicate: (Route<dynamic> route) => false,
                    );
                  }
                } else if (cubit.userType == "restaurant") {
                  context.pushNamedAndRemoveUntil(
                    Routes.resturantBottomBar,
                    arguments: cubit.resturantId,
                    predicate: (Route<dynamic> route) => false,
                  );
                } else if (cubit.userType == "agent") {
                  context.pushNamedAndRemoveUntil(
                    Routes.deliveryAgentHomeScreen,
                    predicate: (Route<dynamic> route) => false,
                  );
                } else {
                  context.pushNamedAndRemoveUntil(
                    Routes.adminBottomBarScreen,
                    arguments: [0, false, false],
                    predicate: (Route<dynamic> route) => false,
                  );
                }
              },
              fail: (error) {
                print(error.message);
                showErrorSnackBar(context, error.message);
              },
            );
          },
          buildWhen: (previous, current) =>
              current is LoginLoading || current is! LoginLoading,
          builder: (BuildContext context, LoginState<dynamic> state) {
            if (state is LoginLoading ||
                state.maybeWhen(loading: () => true, orElse: () => false)) {
              return Center(
                child: LoadingAnimationWidget.newtonCradle(
                  color: AppColors.primaryDeafult,
                  size: 150,
                ),
              );
            }
            return child;
          },
        );
      },
    );
  }
}
