import 'package:custom_form_w/custom_form_w.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/auth/signUp/logic/cubit/signup_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PasswordAndConfirmPassword extends StatelessWidget {
  const PasswordAndConfirmPassword({super.key, required this.cubit});

  final SignupCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomFormW(
      spaceHeaders: 0,
      spacing: 20,
      padding: EdgeInsets.zero,
      showButton: false,
      children: [
        CustomTextField(
          controller: cubit.password,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          fillColor: Colors.transparent,

          type: CustomTextFieldType.password,
          maxLines: 1,
          visibiltyColor: Color(0xff94A3B8),

          headerText: AppStrings.password.tr(),
          headerTextStyle: TextStyles.bimini16W400Body,
          withoutLabel: true,
          hint: "",
          hintStyle: TextStyles.bimini13W400Grey,
        ),
        CustomTextField(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          type: CustomTextFieldType.password,
          maxLines: 1,
          isConfirmPassword: true,
          visibiltyColor: Color(0xff94A3B8),
          fillColor: Colors.transparent,

          headerText: AppStrings.confirmPassword.tr(),
          headerTextStyle: TextStyles.bimini16W400Body,
          withoutLabel: true,
          hint: " ",
          hintStyle: TextStyles.bimini13W400Grey,
        ),
      ],
    );
  }
}
