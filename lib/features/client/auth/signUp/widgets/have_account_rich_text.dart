import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HaveAccountRichText extends StatelessWidget {
  const HaveAccountRichText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: AppStrings.alreadyHaveAnAccount.tr(),
              style: TextStyles.bimini13W400Grey,
            ),
            TextSpan(
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () => context.pushNamed(Routes.loginScreen),
              text: AppStrings.signIn.tr(),
              style: TextStyles.bimini13W700Deafult,
            ),
          ],
        ),
      ),
    );
  }
}