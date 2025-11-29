import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/features/client/adresses/ui/widgets/mobile_number_text_field.dart';
import 'package:delveria/features/client/auth/login/widgets/first_and_last_name_row.dart';
import 'package:delveria/features/client/auth/signUp/logic/cubit/signup_cubit.dart';
import 'package:delveria/features/client/auth/signUp/logic/cubit/signup_state.dart';
import 'package:delveria/features/client/auth/signUp/widgets/email_and_phone.dart';
import 'package:delveria/features/client/auth/signUp/widgets/password_and_confirm_password_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDataInputSignUp extends StatelessWidget {
  const UserDataInputSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        final cubit = context.read<SignupCubit>();
        return Column(
          children: [
            FirstAndLastNameRow(
              firstName: cubit.firstName,
              lastName: cubit.lastName,
            ),
            verticalSpace(10),
            MobileNumberTextField(
              selectedCountryCode: '+20',
              phoneController: cubit.phone,
            ),
            verticalSpace(10),

            EmailAndPhone(cubit: cubit),

            PasswordAndConfirmPassword(cubit: cubit),
          ],
        );
      },
    );
 
  }
}


