import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(BuildContext context) : super(_getInitialLocale(context));
  
  static Locale _getInitialLocale(BuildContext context) {
    try {
      return context.locale;
    } catch (e) {
      // Fallback to English if EasyLocalization context is not available yet
      return const Locale('en');
    }
  }

  void changeLocale(BuildContext context, Locale newLocale) async {
    await context.setLocale(newLocale); // Updates EasyLocalization
    emit(newLocale); // Updates the cubit state
  }
}
