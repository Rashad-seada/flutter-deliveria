import 'package:custom_form_w/custom_form_w.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PasswordAndConfirmPassword extends StatelessWidget {
  const PasswordAndConfirmPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFormW(
      spaceHeaders: 0,
      spacing: 20,
      padding: EdgeInsets.zero,
      showButton: false,
      children: [
        CustomTextField(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          type: CustomTextFieldType.password,
          visibiltyColor: Color(0xff94A3B8),
          fillColor: Colors.transparent,

          headerText: AppStrings.newPassword.tr(),
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
          hint: "",
          hintStyle: TextStyles.bimini13W400Grey,
        ),
      ],
    );
  }
}
