import 'package:delveria/core/func/get_initial_route.dart';
import 'package:delveria/core/routing/app_router.dart';
import 'package:delveria/features/client/settings/logic/localCubit/local_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DelveriaApp extends StatefulWidget {
  final AppRouter appRouter;
  const DelveriaApp({super.key, required this.appRouter});

  @override
  State<DelveriaApp> createState() => _DelveriaAppState();
}

class _DelveriaAppState extends State<DelveriaApp> {
  String? _initialRoute;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initRoute();
  }

  Future<void> _initRoute() async {
    final result = await getInitialRouteWithArgs();
    setState(() {
      _initialRoute = result.route;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Material(child: Center(child: CircularProgressIndicator()));
    }
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider(
        create: (context) => ThemeCubit(),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return BlocBuilder<LocaleCubit, Locale>(
              builder: (context, localState) {
                return MaterialApp(
                   locale: context.locale, 
                  supportedLocales: context.supportedLocales,
                  localizationsDelegates: context.localizationDelegates,
                  theme: ThemeData(
                    scaffoldBackgroundColor: Colors.white,
                    brightness: Brightness.light,
                    primarySwatch: Colors.red,
                    fontFamily: context.locale.languageCode == 'ar' ? 'Lantx' : 'Bimini',
                  ),
                  darkTheme: ThemeData(
                    bottomNavigationBarTheme:
                        const BottomNavigationBarThemeData(
                          backgroundColor: Colors.black,
                        ),
                    brightness: Brightness.dark,
                    primarySwatch: Colors.red,
                    fontFamily: context.locale.languageCode == 'ar' ? 'Lantx' : 'Bimini',
                  ),
                  themeMode: state.themeMode,
                  debugShowCheckedModeBanner: false,
                  onGenerateRoute: widget.appRouter.generateRoute,
                  initialRoute: _initialRoute,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
