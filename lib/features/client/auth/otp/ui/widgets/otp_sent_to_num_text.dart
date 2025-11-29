import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SentOtpToNumberText extends StatelessWidget {
  const SentOtpToNumberText({super.key, required this.phone});
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          AppStrings.otpVerification.tr(),
          style: TextStyles.bimini31W700PrimaryDeafult,
        ),
        verticalSpace(20),
        Text(
          " ${AppStrings.otpAlreadySent.tr()}$phone",
          style: TextStyles.bimini16W400Body,
        ),
      ],
    );
  }
}
