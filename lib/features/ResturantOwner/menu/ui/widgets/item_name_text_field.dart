import 'package:custom_form_w/custom_form_w.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ItemNameTextField extends StatelessWidget {
  const ItemNameTextField({super.key, required this.itemNameController, this.hint});
  final TextEditingController itemNameController;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return CustomFormW(
      padding: EdgeInsets.zero,
      showButton: false,
      children: [
        CustomTextField(
          controller: itemNameController,
          headerText:AppStrings.itemName.tr(),
          headerTextStyle: TextStyles.bimini16W700,
          hint: hint ?? AppStrings.enterYourItemName.tr(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          hintStyle: TextStyles.bimini13W400Grey,
        ),
      ],
    );
  }
}
