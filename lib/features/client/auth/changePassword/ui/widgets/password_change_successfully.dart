import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordChangeSuccessfully extends StatelessWidget {
  const PasswordChangeSuccessfully({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300.w,
        child: Text(
          textAlign: TextAlign.center,
          AppStrings.passwordChangedSuccessfully.tr(),
          style: TextStyles.bimini16W700BoldWhite.copyWith(
            color: AppColors.grey,
          ),
        ),
      ),
    );
  }
}
