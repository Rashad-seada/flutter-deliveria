import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/features/client/auth/changePassword/ui/widgets/password_and_confirm_password.dart';
import 'package:delveria/features/client/auth/otp/ui/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

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
                      AppStrings.changePasswordTitle.tr(),
                      style: TextStyles.bimini31W700PrimaryDeafult,
                    ),
                    verticalSpace(20),
                    Text(
                      AppStrings.changePasswordSubtitle.tr(),
                      style: TextStyles.bimini16W400Body,
                    ),
                    verticalSpace(72),
                    PasswordAndConfirmPassword(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppStrings.atleast8Characters.tr(),
                        style: TextStyles.bimini13W400Grey,
                      ),
                    ),
                    verticalSpace(108),
                    Center(
                      child: AppButton(
                        title: AppStrings.resetPassword.tr(),
                        onPressed: () {
                          context.pushNamed(Routes.successChangePasswordScreen);
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
