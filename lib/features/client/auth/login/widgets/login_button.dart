import 'package:delveria/core/func/continue_as_a_guest.dart';
import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/features/client/auth/login/data/models/login_request.dart';
import 'package:delveria/features/client/auth/login/logic/cubit/login_cubit.dart';
import 'package:delveria/features/client/auth/login/logic/cubit/login_state.dart';
import 'package:delveria/features/client/auth/login/widgets/login_bloc_listener.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  // Make isDeleted async, since getBool might be async in some implementations
  Future<bool> isDeleted() async {
    final result = await SharedPrefHelper.getBool(SharedPrefKeys.isDeleted);
    return result ?? false;
  }
  Future<int> process() async {
    final result = await SharedPrefHelper.getInt(SharedPrefKeys.processNumber);
    return result ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoginBlocListener(
        child: BlocBuilder<LoginCubit, LoginState>(
          buildWhen:
              (previous, current) =>
                  current is LoginLoading || current is! LoginLoading,
          builder: (context, state) {
            if (state is LoginLoading ||
                state.maybeWhen(loading: () => true, orElse: () => false)) {
              return LoadingAnimationWidget.newtonCradle(
                color: AppColors.primaryDeafult,
                size: 150,
              );
            }
            final cubit = context.read<LoginCubit>();
            return AppButton(
              title: AppStrings.signIn.tr(),
              onPressed: () async {
                if (cubit.emptyFields()) {
                  showWarningSnackBar(
                    context,
                    AppStrings.mustFillAllFields.tr(),
                  );
                  return;
                }
                final deleted = await isDeleted();
                final processNumber = await process();
                if (deleted && processNumber==1) {
                  showErrorSnackBar(context, "This account not exist ");
                  return;
                }

                // Await the future to get the actual token value
                final token = await SharedPrefHelper.getSecuredString(
                  SharedPrefKeys.fbToken,
                );
                await SharedPrefHelper.setData(
                  SharedPrefKeys.continueAsGuest,
                  false,
                );
                print(isContinueAsGuest);
                if (cubit.emptyFields()) {
                  showWarningSnackBar(
                    context,
                    AppStrings.mustFillAllFields.tr(),
                  );
                } else {
                  context.read<LoginCubit>().login(
                    LoginRequestBody(
                      phone: cubit.phone.text,
                      password: cubit.password.text,
                      fbToken: token?.toString() ?? "",
                    ),
                  );
                }

                //* resturant owner
                // context.pushNamed(Routes.resturantBottomBar);

                //* Admin panal
                // context.pushNamed(Routes.adminBottomBarScreen , arguments: [0, false , false ]);

                //* Delivery Agent Screen
                // context.pushNamed(Routes.deliveryAgentHomeScreen);
              },
            );
          },
        ),
      ),
    );
  }
}
