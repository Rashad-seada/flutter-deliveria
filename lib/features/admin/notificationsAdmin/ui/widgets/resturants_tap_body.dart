import 'package:delveria/core/func/push_notifications_func.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResturantsTapBody extends StatelessWidget {
  const ResturantsTapBody({super.key, required this.messageController});

  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.notificationsMessage.tr(), style: TextStyles.bimini16W700),
        verticalSpace(24),
        Container(
          width: 342.w,
          height: 44.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: AppColors.grey.withValues(alpha: .3)),
          ),
          child: TextField(
            controller: messageController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: AppStrings.writeYourTextHere.tr(),
              hintStyle: TextStyles.bimini13W400Grey,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(AppImages.emoji, width: 20.w, height: 20.h),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(AppImages.attach, width: 20.w, height: 20.h),
              ),
            ),
          ),
        ),
        verticalSpace(72),
        Center(
          child: AppButton(
            title:AppStrings.pushNotification.tr(),
            onPressed:
                () => pushNotification(
                  context,
                  messageController,
                  false
                 
                ),
          ),
        ),
      ],
    );
  }
}
