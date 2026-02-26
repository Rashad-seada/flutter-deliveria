import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/auth/login/data/models/login_request.dart';
import 'package:delveria/features/client/auth/login/logic/cubit/login_cubit.dart';
import 'package:delveria/features/client/auth/login/widgets/dont_have_account_rich_text.dart';
import 'package:delveria/features/client/auth/login/widgets/login_bloc_listener.dart';
import 'package:delveria/features/client/auth/login/widgets/login_button.dart';
import 'package:delveria/features/client/auth/login/widgets/user_data_input_form_login.dart';
import 'package:delveria/features/client/onboarding/logic/cubit/system_data_cubit.dart';
import 'package:delveria/features/client/onboarding/logic/cubit/system_data_state.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isGettingLocation = false;

  Future<void> _continueAsGuest() async {
    setState(() => _isGettingLocation = true);
    
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          _showLocationDialog(
            'Location Services Disabled',
            'Please enable location services to continue as a guest.',
          );
        }
        setState(() => _isGettingLocation = false);
        return;
      }

      // Check and request permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            _showLocationDialog(
              'Location Permission Required',
              'Location permission is required to browse restaurants near you. Please grant location access.',
            );
          }
          setState(() => _isGettingLocation = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          _showLocationDialog(
            'Location Permission Denied',
            'Location permission is permanently denied. Please enable it from app settings to continue as a guest.',
            showSettings: true,
          );
        }
        setState(() => _isGettingLocation = false);
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );

      // Save location to SharedPreferences
      await SharedPrefHelper.setData(SharedPrefKeys.lat, position.latitude);
      await SharedPrefHelper.setData(SharedPrefKeys.long, position.longitude);
      
      // Set Guest Flag
      await SharedPrefHelper.setData(SharedPrefKeys.isGuest, true);
      
      // Navigate to Home
      if (mounted) {
        context.pushReplacementNamed(Routes.bottomBarScreen, arguments: 0);
      }
    } catch (e) {
      print('Error getting location: $e');
      if (mounted) {
        _showLocationDialog(
          'Location Error',
          'Failed to get your location. Please try again.',
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isGettingLocation = false);
      }
    }
  }

  void _showLocationDialog(String title, String message, {bool showSettings = false}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextStyles.bimini16W700),
        content: Text(message, style: TextStyles.bimini16W400Body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          if (showSettings)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Geolocator.openAppSettings();
              },
              child: Text('Open Settings', style: TextStyle(color: AppColors.primaryDeafult)),
            )
          else
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _continueAsGuest(); // Retry
              },
              child: Text('Try Again', style: TextStyle(color: AppColors.primaryDeafult)),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return BlocBuilder<SystemDataCubit, SystemDataState>(
          builder: (context, systemState) {
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(40),
                        Text(
                          AppStrings.welcomeBack.tr(),
                          style: TextStyles.bimini31W700PrimaryDeafult,
                        ),
                        verticalSpace(20),
                        Text(
                          AppStrings.enterDetails.tr(),
                          style: TextStyles.bimini16W400Body,
                        ),
                        verticalSpace(50),
                        UserDataInputFormLogin(theme: state),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              context.pushNamed(Routes.forgotPasswordScreen);
                            },
                            child: Text(
                              AppStrings.forgotPassword.tr(),
                              style: TextStyles.bimini14W700.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        verticalSpace(40),
                        LoginButton(),
                        verticalSpace(50.h),
                        DoNotHaveAccountRichText(),
                        verticalSpace(20.h),

                        Center(
                          child: _isGettingLocation
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.primaryDeafult,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Getting location...',
                                      style: TextStyles.bimini16W700BoldWhite.copyWith(
                                        color: state.themeMode == ThemeMode.dark
                                            ? Colors.white
                                            : AppColors.primaryDeafult,
                                      ),
                                    ),
                                  ],
                                )
                              : GestureDetector(
                                  onTap: _continueAsGuest,
                                  child: Text(
                                    AppStrings.continueAsGuest.tr(),
                                    style: TextStyles.bimini16W700BoldWhite.copyWith(
                                      color: state.themeMode == ThemeMode.dark
                                          ? Colors.white
                                          : AppColors.primaryDeafult,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
