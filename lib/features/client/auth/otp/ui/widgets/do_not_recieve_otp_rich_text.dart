import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DonotRecieveOtpRichText extends StatelessWidget {
  const DonotRecieveOtpRichText({super.key, required this.theme});
  final ThemeState theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: AppStrings.didNotRecieveOtp.tr(),
              style: TextStyles.bimini13W400Grey,
            ),
            TextSpan(
              text: AppStrings.resend.tr(),
              style: TextStyles.bimini13W700Deafult.copyWith(
                color:
                    theme.themeMode == ThemeMode.dark
                        ? AppColors.primaryDeafult
                        : AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
