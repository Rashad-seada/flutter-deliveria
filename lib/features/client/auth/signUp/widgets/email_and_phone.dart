import 'package:custom_form_w/custom_form_w.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/auth/signUp/logic/cubit/signup_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EmailAndPhone extends StatelessWidget {
  const EmailAndPhone({
    super.key,
    required this.cubit,
  });

  final SignupCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomFormW(
     
      spaceHeaders: 0,
      spacing: 20,
      padding: EdgeInsets.zero,
      showButton: false,
      children: [
    //     CustomTextField(
    //  controller: cubit.phone,
    //       contentPadding: EdgeInsets.symmetric(
    //         vertical: 10,
    //         horizontal: 10,
    //       ),
    //       fillColor: Colors.transparent,
    //       maxLines: 1,
    //       showCountryFlag: false,
    //       dropDownIcon: Icon(
    //         Icons.keyboard_arrow_down_outlined,
    //         size: 20,
    //         color: Colors.black54,
    //       ),
    //       headerText: AppStrings.mobileNumber.tr(),
    //       headerTextStyle: TextStyles.bimini16W400Body,
    //       withoutLabel: true,
    //       hint: "Enter your mobile number ",
    //       hintStyle: TextStyles.bimini13W400Grey,
    //     ),
        // CustomTextField(
        //  controller: cubit.email,
        //   contentPadding: EdgeInsets.symmetric(
        //     vertical: 10,
        //     horizontal: 10,
        //   ),
        //   type: CustomTextFieldType.email,
        //   fillColor: Colors.transparent,
             
        //   headerText: AppStrings.email.tr(),
        //   headerTextStyle: TextStyles.bimini16W400Body,
        //   withoutLabel: true,
        //   hint: "Enter your email ",
        //   hintStyle: TextStyles.bimini13W400Grey,
        // ),
      ],
    );
  }
}