import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void showCanceledDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        backgroundColor:
            themeState.themeMode == ThemeMode.dark
                ? AppColors.darkGrey
                : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Center(
          child: Text(
            AppStrings.attentionOrder.tr(),
            style: TextStyles.bimini20W700.copyWith(
              color: AppColors.primaryDeafult,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.orderCanceled.tr(),
              style: TextStyles.bimini16W700.copyWith(
                color: AppColors.primaryDeafult,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              AppStrings.canceledDetails.tr(),
              style: TextStyles.bimini14W500,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          AppButton(
            title: AppStrings.done.tr(),
            onPressed: () {
              context.pop();
            },
          ),
        ],
      );
    },
  );
}
