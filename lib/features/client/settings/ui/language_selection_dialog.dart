import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/features/client/home/ui/widgets/close_icon.dart';
import 'package:delveria/features/client/settings/logic/localCubit/local_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSelectionDialog extends StatefulWidget {
  const LanguageSelectionDialog({super.key});

  @override
  State<LanguageSelectionDialog> createState() =>
      _LanguageSelectionDialogState();
}

class _LanguageSelectionDialogState extends State<LanguageSelectionDialog> {
  String? _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final currentLocale = context.read<LocaleCubit>().state;

        return AlertDialog(
          backgroundColor:
              state.themeMode == ThemeMode.dark ? null : Colors.white,
          icon: CloseIcon(),

          title: Text(
            'Select Language',
            style: TextStyles.bimini20W400.copyWith(
              color: AppColors.primaryDeafult,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile<String>(
                activeColor: AppColors.primaryDeafult,
                title: Text(AppStrings.english.tr(), style: TextStyles.bimini16W700),
                value: AppStrings.english.tr(),
                groupValue: _selectedLanguage,
                onChanged: (String? value) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                },
              ),
              RadioListTile<String>(
                activeColor: AppColors.primaryDeafult,

                title: Text(AppStrings.arabic.tr(), style: TextStyles.bimini16W700),
                value: AppStrings.arabic.tr(),
                groupValue: _selectedLanguage,
                onChanged: (String? value) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                },
              ),
              verticalSpace(10),
              AppButton(
                title: AppStrings.applyChanges.tr(),
                onPressed: () {
                  if (currentLocale.languageCode == 'en') {
                    context.read<LocaleCubit>().changeLocale(context,
                      const Locale('ar'),
                    );
                    context.setLocale(const Locale('ar'));
                  } else {
                    context.read<LocaleCubit>().changeLocale( context,
                      const Locale('en'),
                    );
                    context.setLocale(const Locale('en'));
                  }
                  context.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
