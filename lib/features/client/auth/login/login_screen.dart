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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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

                        context.read<SystemDataCubit>().isUploaded == true
                            ? SizedBox()
                            : Center(
                              child: LoginBlocListener(
                                child: GestureDetector(
                                  onTap: () async {
                                    await SharedPrefHelper.setData(
                                      SharedPrefKeys.continueAsGuest,
                                      true,
                                    );
                                    await SharedPrefHelper.setData(
                                      SharedPrefKeys.isDeleted,
                                      false,
                                    );
                                    context.read<LoginCubit>().login(
                                      LoginRequestBody(
                                        phone: "01234567891",
                                        password: "123456",
                                        fbToken: "",
                                      ),
                                    );
                                    // context.pushNamed(Routes.bottomBarScreen, arguments: 0);
                                  },
                                  child: Text(
                                    AppStrings.continueAsGuest.tr(),
                                    style: TextStyles.bimini16W700BoldWhite
                                        .copyWith(
                                          color:
                                              state.themeMode == ThemeMode.dark
                                                  ? Colors.white
                                                  : AppColors.primaryDeafult,
                                        ),
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
