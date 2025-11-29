import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/auth/signUp/widgets/have_account_rich_text.dart';
import 'package:delveria/features/client/auth/signUp/widgets/sign_up_app_bar.dart';
import 'package:delveria/features/client/auth/signUp/widgets/sign_up_button.dart';
import 'package:delveria/features/client/auth/signUp/widgets/user_data_input_sign_up.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: SignUpAppBar(state: state),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.signUp.tr(),
                      style: TextStyles.bimini31W700PrimaryDeafult,
                    ),
                    verticalSpace(15),
                    Text(
                      AppStrings.fillInfobelow.tr(),
                      style: TextStyles.bimini16W400Body,
                    ),
                    verticalSpace(30),
                    UserDataInputSignUp(),
                    verticalSpace(25),
                    SignUpButton(),
                    verticalSpace(40.h),
                    HaveAccountRichText(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
