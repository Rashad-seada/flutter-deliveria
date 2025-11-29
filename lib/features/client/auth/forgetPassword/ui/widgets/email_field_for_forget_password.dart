import 'package:custom_form_w/custom_form_w.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EmailFieldForForgetPass extends StatelessWidget {
  const EmailFieldForForgetPass({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFormW(
      showButton: false,
      spacing: 0,
      spaceHeaders: 0,
      padding: EdgeInsets.zero,
      children: [
        CustomTextField(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          type: CustomTextFieldType.email,
fillColor: Colors.transparent,
          headerText: AppStrings.email.tr(),
          headerTextStyle: TextStyles.bimini16W400Body,
          withoutLabel: true,
          hint: "Enter your email ",
          hintStyle: TextStyles.bimini13W400Grey,
        ),
      ],
    );
  }
}
