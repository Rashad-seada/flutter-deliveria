import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/auth/login/data/models/login_request.dart';
import 'package:delveria/features/client/auth/login/logic/cubit/login_cubit.dart';
import 'package:delveria/features/client/auth/login/logic/cubit/login_state.dart';
import 'package:delveria/features/client/auth/login/widgets/login_bloc_listener.dart';
import 'package:delveria/features/client/onboarding/logic/cubit/system_data_cubit.dart';
import 'package:delveria/features/client/onboarding/logic/cubit/system_data_state.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SignUpAppBar extends StatelessWidget {
  const SignUpAppBar({super.key, required this.state});
  final ThemeState state;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemDataCubit, SystemDataState>(
      builder: (context, systemState) {
        final systemcubit = context.read<SystemDataCubit>();
        print("......${systemcubit.isUploaded}");
        return BlocBuilder<LoginCubit, LoginState>(
          builder: (context, loginState) {
            final cubit = context.read<LoginCubit>();
            return AppBar(
              elevation: 0,
              backgroundColor:
                  state.themeMode == ThemeMode.dark
                      ? Colors.black12
                      : Colors.white,
              surfaceTintColor:
                  state.themeMode == ThemeMode.dark
                      ? Colors.black12
                      : Colors.white,
              centerTitle: false,
              automaticallyImplyLeading: false,
              title:
                  systemcubit.isUploaded == true
                      ? SizedBox()
                      : Row(
                        spacing: 10.w,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          LoginBlocListener(
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
                          SvgPicture.asset(
                            AppImages.arrowRight,
                            color:
                                state.themeMode == ThemeMode.dark
                                    ? Colors.white
                                    : null,
                          ),
                        ],
                      ),
            );
          },
        );
      },
    );
  }
}
