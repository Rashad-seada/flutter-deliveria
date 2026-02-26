import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/client/adresses/ui/widgets/mobile_number_text_field.dart';
import 'package:delveria/features/client/auth/login/widgets/first_and_last_name_row.dart';
import 'package:delveria/features/client/auth/signUp/logic/cubit/signup_cubit.dart';
import 'package:delveria/features/client/auth/signUp/logic/cubit/signup_state.dart';
import 'package:delveria/features/client/auth/signUp/widgets/email_and_phone.dart';
import 'package:delveria/features/client/auth/signUp/widgets/password_and_confirm_password_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDataInputSignUp extends StatelessWidget {
  const UserDataInputSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        final cubit = context.read<SignupCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FirstAndLastNameRow(
              firstName: cubit.firstName,
              lastName: cubit.lastName,
            ),
            // Inline errors for first_name / last_name side by side
            Row(
              children: [
                SizedBox(
                  width: 160.w,
                  child: _FieldError(error: cubit.fieldErrors['first_name']),
                ),
                SizedBox(width: 15.w),
                SizedBox(
                  width: 160.w,
                  child: _FieldError(error: cubit.fieldErrors['last_name']),
                ),
              ],
            ),
            verticalSpace(10),
            MobileNumberTextField(
              selectedCountryCode: '+20',
              phoneController: cubit.phone,
            ),
            _FieldError(error: cubit.fieldErrors['phone']),
            verticalSpace(10),
            EmailAndPhone(cubit: cubit),
            PasswordAndConfirmPassword(cubit: cubit),
            _FieldError(error: cubit.fieldErrors['password']),
          ],
        );
      },
    );
  }
}

/// Displays a red inline error text under a field.
/// Shows nothing if [error] is null.
class _FieldError extends StatelessWidget {
  const _FieldError({this.error});
  final String? error;

  @override
  Widget build(BuildContext context) {
    if (error == null || error!.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 4, bottom: 2),
      child: Text(
        error!,
        style: TextStyle(
          color: AppColors.primaryDeafult,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
