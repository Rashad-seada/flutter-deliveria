import 'package:custom_form_w/custom_form_w.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/adresses/ui/widgets/mobile_number_text_field.dart';
import 'package:delveria/features/client/auth/login/logic/cubit/login_cubit.dart';
import 'package:delveria/features/client/auth/login/logic/cubit/login_state.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDataInputFormLogin extends StatelessWidget {
  const UserDataInputFormLogin({super.key, required this.theme});
  final ThemeState theme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final cubit = context.read<LoginCubit>();
        return Column(
          children: [
            // FirstAndLastNameRow(),
            verticalSpace(10),
            MobileNumberTextField(
              selectedCountryCode: '+20',
              phoneController: cubit.phone,
            ),
            verticalSpace(10),

            CustomFormW(
              spaceHeaders: 0,
              spacing: 0,
              padding: EdgeInsets.zero,
              showButton: false,
              children: [
                // CustomTextField(
                //   controller: cubit.phone,
                //   contentPadding: EdgeInsets.symmetric(
                //     vertical: 10,
                //     horizontal: 10,
                //   ),
                //   fillColor: Colors.transparent,

                //   showCountryFlag: false,
                //   dropDownIcon: Icon(
                //     Icons.keyboard_arrow_down_outlined,
                //     size: 20,
                //     color:
                //         theme.themeMode == ThemeMode.dark
                //             ? Colors.white
                //             : Colors.black54,
                //   ),
                //   headerText: AppStrings.mobileNumber.tr(),
                //   headerTextStyle: TextStyles.bimini16W400Body,
                //   withoutLabel: true,
                //   hint: AppStrings.enterYourMobileNumber.tr(),
                //   hintStyle: TextStyles.bimini13W400Grey,
                // ),
                // // CustomTextField(
                //   contentPadding: EdgeInsets.symmetric(
                //     vertical: 10,
                //     horizontal: 10,
                //   ),
                //   type: CustomTextFieldType.email,
                //   fillColor: Colors.transparent,

                //   headerText: AppStrings.email,
                //   headerTextStyle: TextStyles.bimini16W400Body,
                //   withoutLabel: true,
                //   hint: "Enter your email ",
                //   hintStyle: TextStyles.bimini13W400Grey,
                // ),
              ],
            ),

            verticalSpace(10),
            CustomFormW(
              spaceHeaders: 0,
              spacing: 0,
              padding: EdgeInsets.zero,
              showButton: false,
              children: [
                CustomTextField(
                  controller: cubit.password,
                  fillColor: Colors.transparent,

                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  type: CustomTextFieldType.password,
                  maxLines: 1,
                  visibiltyColor: Color(0xff94A3B8),

                  headerText: AppStrings.password.tr(),
                  headerTextStyle: TextStyles.bimini16W400Body,
                  withoutLabel: true,
                  hint: "",
                  hintStyle: TextStyles.bimini13W400Grey,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
