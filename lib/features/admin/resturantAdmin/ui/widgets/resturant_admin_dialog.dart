import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/admin_resturant_filter_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/resturant_admin_screen.dart';
import 'package:delveria/features/client/home/ui/widgets/close_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantAdminDialog extends StatelessWidget {
  final String userName;
  final String password;
  final bool? isAgent;
  const RestaurantAdminDialog({
    super.key,
    required this.userName,
    required this.password,
    this.isAgent,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      icon: CloseIcon(),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              isAgent == true ? AppStrings.agentData.tr() : AppStrings.resturantData.tr(),
              style: TextStyles.bimini20W700.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          verticalSpace(32),
          Text('Phone', style: TextStyles.bimini16W400Body),
          verticalSpace(8),
          Container(
            width: 279.w,
            height: 36.h,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(userName, style: TextStyles.bimini13W400Grey),
                ),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: userName));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('User name copied to clipboard'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Image.asset(AppImages.copy, width: 12.w, height: 12.h),
                ),
              ],
            ),
          ),

          verticalSpace(24),

          Text('Password', style: TextStyles.bimini16W400Body),
          verticalSpace(8),
          Container(
            width: 279.w,
            height: 36.h,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(password, style: TextStyles.bimini13W400Grey),
                ),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: password));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Password copied to clipboard'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Image.asset(AppImages.copy, width: 12.w, height: 12.h),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
          AppButton(
            title: AppStrings.done.tr(),
            onPressed: () {
              context.pop();
              context.pop();
         },
          ),
        ],
      ),
    );
  }
}
