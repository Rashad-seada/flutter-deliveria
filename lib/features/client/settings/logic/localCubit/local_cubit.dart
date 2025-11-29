import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(BuildContext context) : super(context.locale);

  void changeLocale(BuildContext context, Locale newLocale) async {
    await context.setLocale(newLocale); // Updates EasyLocalization
    emit(newLocale); // Updates the cubit state
  }
}
