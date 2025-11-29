import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/features/client/home/ui/widgets/close_icon.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModeSelectionDialog extends StatefulWidget {
  const ModeSelectionDialog({super.key});

  @override
  State<ModeSelectionDialog> createState() => _ModeSelectionDialogState();
}

class _ModeSelectionDialogState extends State<ModeSelectionDialog> {
  ThemeMode? _selectedMode;

  @override
  void initState() {
    super.initState();
    _selectedMode = context.read<ThemeCubit>().state.themeMode;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return AlertDialog(
          backgroundColor:
              state.themeMode == ThemeMode.dark ? null : Colors.white,
          icon: CloseIcon(),
          title: Text(
            'Select Modes',
            style: TextStyles.bimini20W400.copyWith(
              color: AppColors.primaryDeafult,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile<ThemeMode>(
                activeColor: AppColors.primaryDeafult,

                title: Text(AppStrings.lightMode.tr(), style: TextStyles.bimini16W700),
                value: ThemeMode.light,
                groupValue: _selectedMode,
                onChanged: (ThemeMode? value) {
                  setState(() {
                    _selectedMode = value;
                  });
                
                },
              ),
              RadioListTile<ThemeMode>(
                activeColor: AppColors.primaryDeafult,
                title: Text(AppStrings.darkMode.tr(), style: TextStyles.bimini16W700),
                value: ThemeMode.dark,
                groupValue: _selectedMode,
                onChanged: (ThemeMode? value) {
                  setState(() {
                    _selectedMode = value;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            AppButton(
              onPressed: () {
                if (_selectedMode != null) {
                  context.read<ThemeCubit>().setTheme(_selectedMode!);
                }
                Navigator.of(context).pop();
              },
              title: AppStrings.applyChanges.tr(),
            ),
          ],
        );
      },
    );
  }
}
