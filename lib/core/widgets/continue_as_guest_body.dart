import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ContinueAsGuestBody extends StatelessWidget {
  const ContinueAsGuestBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.youMustLoginFirst.tr(),
          style: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
        Center(
          child: AppButton(
            title: AppStrings.signIn.tr(),
            onPressed: () {
              context.pushNamed(Routes.loginScreen);
            },
          ),
        ),
      ],
    );
  }
}
