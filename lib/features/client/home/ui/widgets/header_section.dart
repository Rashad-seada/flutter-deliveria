import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_cubit.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_cubit.dart';
import 'package:delveria/features/client/home/ui/widgets/greeting_section.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    super.key,
    required this.themeState,
    required this.lat,
    required this.long,
  });
  final ThemeState themeState;
  final double lat, long;

  @override
  Widget build(BuildContext context) {
    final isDark = themeState.themeMode == ThemeMode.dark;

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
                  AppColors.darkGrey.withOpacity(0.3),
                  Colors.transparent,
                ]
              : [
                  AppColors.primaryDeafult.withOpacity(0.03),
                  Colors.transparent,
                ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<CreateAddressCubit>()..getAdresses(),
              ),
              BlocProvider(
                create: (context) => getIt<UserDataCubit>()..getUserData(),
              ),
            ],
            child: const GreetingSection(),
          ),
          verticalSpace(16),
        ],
      ),
    );
  }
}
