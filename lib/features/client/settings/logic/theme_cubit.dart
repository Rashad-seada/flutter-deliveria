import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState()) {
    _loadSavedTheme();
  }

  Future<void> _loadSavedTheme() async {
    final savedTheme = await SharedPrefHelper.getString(SharedPrefKeys.themeMode);
    if (savedTheme != null) {
      final themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == savedTheme,
        orElse: () => ThemeMode.light,
      );
      emit(state.copyWith(themeMode: themeMode));
    }
  }

  void toggleTheme() async {
    final newThemeMode = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    await SharedPrefHelper.setData(SharedPrefKeys.themeMode, newThemeMode.toString());
    emit(state.copyWith(themeMode: newThemeMode));
  }

  void setTheme(ThemeMode themeMode) async {
    await SharedPrefHelper.setData(SharedPrefKeys.themeMode, themeMode.toString());
    emit(state.copyWith(themeMode: themeMode));
  }
}
