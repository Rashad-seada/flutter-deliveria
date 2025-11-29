import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/features/client/auth/otp/logic/cubit/otp_cubit.dart';
import 'package:delveria/features/client/auth/otp/ui/otp_screen.dart';
import 'package:delveria/features/client/auth/signUp/logic/cubit/signup_cubit.dart';
import 'package:delveria/features/client/auth/signUp/logic/cubit/signup_state.dart';
import 'package:delveria/features/client/auth/signUp/widgets/sign_up_bloc_listener.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SignUpBlocListener(
      child: BlocBuilder<SignupCubit, SignupState>(
        builder: (context, state) {
          final cubit = context.read<SignupCubit>();
          return Center(
            child: AppButton(
              title: AppStrings.signUp.tr(),
              onPressed: () async {
                await SharedPrefHelper.setData(SharedPrefKeys.processNumber, 0);
                if (cubit.empyFields()) {
                  showWarningSnackBar(context, "You must fill all fields");
                } else {
                  // Get the phone number from the cubit or request
                  final cubit = context.read<SignupCubit>();
                  final phoneNumber = cubit.phone.text;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => getIt<OtpCubit>(),
                              ),
                              BlocProvider(
                                create: (context) => getIt<SignupCubit>(),
                              ),
                            ],
                            child: VerifyOtpScreen(
                              phoneNumber: "+20$phoneNumber",
                              firstName: cubit.firstName.text,
                              lastName: cubit.lastName.text,
                              email: cubit.email.text,
                              password: cubit.password.text,
                              phone: cubit.phone.text,
                            ),
                          ),
                    ),
                  );
               
                }
              },
            ),
          );
        },
    
      ),
    );
  }
}
