import 'package:custom_form_w/custom_form_w.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstAndLastNameRow extends StatelessWidget {
  const FirstAndLastNameRow({super.key, this.firstName, this.lastName});
  final TextEditingController ? firstName, lastName;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15.w,
      children: [
        SizedBox(
          width: 160.w,
          child: CustomFormW(
            
            spaceHeaders: 0,
            spacing: 0,
            padding: EdgeInsets.zero,
            showButton: false,
            children: [
              CustomTextField(
            controller: firstName,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                fillColor: Colors.transparent,
                headerText: AppStrings.firstName.tr(),
                headerTextStyle: TextStyles.bimini16W400Body,
                withoutLabel: true,
                hint: "",
                hintStyle: TextStyles.bimini13W400Grey,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 160.w,
          child: CustomFormW(
            spaceHeaders: 0,
            spacing: 0,
            padding: EdgeInsets.zero,
            showButton: false,
            children: [
              CustomTextField(
                controller: lastName,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                fillColor: Colors.transparent,

                headerText: AppStrings.lastName.tr(),
                headerTextStyle: TextStyles.bimini16W400Body,
                withoutLabel: true,
                hint: "",
                hintStyle: TextStyles.bimini13W400Grey,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
