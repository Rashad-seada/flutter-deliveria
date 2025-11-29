import 'package:delveria/core/func/continue_as_a_guest.dart';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/continue_as_guest_body.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_cubit.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_state.dart';
import 'package:delveria/features/client/accountInfo/ui/widgets/account_info_app_bar.dart';
import 'package:delveria/features/client/accountInfo/ui/widgets/info_item_for_profile.dart';
import 'package:delveria/features/client/accountInfo/ui/widgets/stacked_profile_image.dart';
import 'package:delveria/features/client/onboarding/logic/cubit/system_data_cubit.dart';
import 'package:delveria/features/client/onboarding/logic/cubit/system_data_state.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key, required this.canPop});
  final bool canPop;

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadContinueAsGuest();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AccountInfoAppBar(
              showArrow:false,
              themeState: theme, canPop: widget.canPop),
          ),
          body:
              isContinueAsGuest == true
                  ? ContinueAsGuestBody()
                  : BlocBuilder<SystemDataCubit, SystemDataState>(
                    builder: (context, systemState) {
                      final systemCubit = context.read<SystemDataCubit>();
                      return SingleChildScrollView(
                        padding: EdgeInsets.all(20),
                        child: BlocBuilder<ThemeCubit, ThemeState>(
                          builder: (context, state) {
                            return BlocBuilder<UserDataCubit, UserDataState>(
                              builder: (context, userState) {
                                final cubit = context.read<UserDataCubit>();
                                print(cubit.firstName);
                                return Column(
                                  children: [
                                    SizedBox(height: 30),
                                    StackedProfileImage(themeState: state),
                                    SizedBox(height: 50),

                                    InfoItemForProfile(
                                      icon: Icons.person_outline,
                                      label: AppStrings.fullName.tr(),
                                      value:
                                          '${cubit.firstName}${cubit.lastName}',
                                      iconColor: Colors.red[800]!,
                                      themeState: state,
                                    ),
                                    SizedBox(height: 30),
                                    InfoItemForProfile(
                                      themeState: state,
                                      icon: Icons.email_outlined,
                                      label: AppStrings.email.tr(),
                                      value: cubit.email,
                                      iconColor: Colors.red[800]!,
                                    ),
                                    SizedBox(height: 30),
                                    InfoItemForProfile(
                                      themeState: state,
                                      icon: Icons.phone_outlined,
                                      label: AppStrings.mobileNumber.tr(),
                                      value: cubit.phone,
                                      iconColor: Colors.red[800]!,
                                    ),
                                    verticalSpace(50),
                                    systemCubit.isUploaded == false
                                        ? AppButton(
                                          title: AppStrings.deleteAccount.tr(),
                                          onPressed: () async {
                                            await SharedPrefHelper.setData(
                                              SharedPrefKeys.isDeleted,
                                              true,
                                            );
                                            await SharedPrefHelper.setData(
                                              SharedPrefKeys.processNumber,
                                              1,
                                            );
                                            print(SharedPrefHelper.getBool(SharedPrefKeys.isDeleted));
                                            context.pushNamed(
                                              Routes.loginScreen,
                                            );
                                          },
                                        )
                                        : SizedBox(),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
        );
      },
    );
  }
}
