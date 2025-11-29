import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/features/client/auth/forgetPassword/ui/widgets/email_field_for_forget_password.dart';
import 'package:delveria/features/client/auth/forgetPassword/ui/widgets/remeber_the_password.dart';
import 'package:delveria/features/client/auth/otp/ui/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: ArrowBackAppBar(theme: state,),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.forgotPasswordTitle.tr(),
                      style: TextStyles.bimini31W700PrimaryDeafult,
                    ),
                    verticalSpace(20),
                    Text(
                      AppStrings.forgotPasswordSubtitle.tr(),
                      style: TextStyles.bimini16W400Body,
                    ),
                    verticalSpace(72),
                    EmailFieldForForgetPass(),
                    RemeberThePassword(),
                    verticalSpace(44),
                    Center(
                      child: AppButton(
                        title: AppStrings.submit.tr(),
                        onPressed: () {
                          context.pushNamed(Routes.changePasswordScreen);
                        },
                      ),
                    ),
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
