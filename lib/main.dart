import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/firebase_notifications.dart';
import 'package:delveria/core/routing/app_router.dart';
import 'package:delveria/delveria_app.dart';
import 'package:delveria/features/client/settings/logic/localCubit/local_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:delveria/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ThemeState themeState = getIt();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.initialize();

  await ScreenUtil.ensureScreenSize();
  await setUpGetIt();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale("en"), Locale("ar",)],
      path: 'assets/translation',
      fallbackLocale: const Locale("en"),
      saveLocale: true, 
      child: 
      Builder(
        builder: (context) {
          return BlocProvider(
            create: (_) => LocaleCubit(context),
            child: DelveriaApp(appRouter: AppRouter()),
          );
        },
      ),
    ),
  );
}
