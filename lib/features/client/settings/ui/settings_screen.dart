import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:delveria/features/client/settings/ui/language_selection_dialog.dart';
import 'package:delveria/features/client/settings/ui/mode_selection_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: AppStrings.setting.tr(),
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: ListView(
        children: [
          verticalSpace(50),
          ListTile(
            title: Text(AppStrings.changeLanguage.tr(), style: TextStyles.bimini16W400Body),
            trailing: Icon(Icons.arrow_forward_ios, size: 15.sp),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const LanguageSelectionDialog();
                },
              );
            },
          ),
          ListTile(
            title: Text(AppStrings.changeMode.tr(), style: TextStyles.bimini16W400Body),
            trailing: Icon(Icons.arrow_forward_ios, size: 15.sp),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, state) {
                      return const ModeSelectionDialog();
                    },
                  );
                },
              );
            },
          ),
          // ListTile(
          //   title: Text(
          //    AppStrings.commentsAndReviews.tr(),
          //     style: TextStyles.bimini16W400Body,
          //   ),
          //   trailing: Icon(Icons.arrow_forward_ios, size: 15.sp),
          //   onTap: () {
          //     // Navigate to comments and reviews screen
          //   },
          // ),
        ],
      ),
    );
  }
}
