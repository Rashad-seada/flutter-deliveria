import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/payment/ui/widgets/track_order_button_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CloseAppDialog extends StatelessWidget {
  const CloseAppDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.areYouSureToClose.tr(),
            style: TextStyles.bimini16W700.copyWith(
              color: AppColors.primaryDeafult,
            ),
          ),
          verticalSpace(20),
          TrackOrderButtonRow(
            ftitle: AppStrings.close.tr(),
            sTitle: AppStrings.cancel.tr(),
            sOnPressed: () {
              context.pop();
            },
            fOnPressed: () {
              context.pop();
              context.pop();
            },
            fWidth: 130.w,
            sWidth: 90.w,
          ),
        ],
      ),
    );
  }
}
