import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/features/client/auth/changePassword/ui/widgets/click_conform.dart';
import 'package:delveria/features/client/auth/changePassword/ui/widgets/password_change_successfully.dart';
import 'package:delveria/features/client/auth/changePassword/ui/widgets/success_image.dart';
import 'package:delveria/features/client/auth/otp/ui/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessChangePasswordScreen extends StatelessWidget {
  const SuccessChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: ArrowBackAppBar(theme: state),
          ),
          body: Column(
            children: [
              SuccessImage(),
              verticalSpace(32),
              Text(
                AppStrings.success.tr(),
                style: TextStyles.bimini31W700PrimaryDeafult.copyWith(
                  color: Colors.black,
                ),
              ),
              verticalSpace(20),
              PasswordChangeSuccessfully(),
              ClickConfirm(),
              verticalSpace(100),
              Center(
                child: AppButton(
                  title: AppStrings.confirm.tr(),
                  onPressed: () {
                    context.pushReplacementNamed(Routes.loginScreen);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
