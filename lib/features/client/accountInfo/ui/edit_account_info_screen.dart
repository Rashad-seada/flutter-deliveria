import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_cubit.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_state.dart';
import 'package:delveria/features/client/accountInfo/ui/widgets/form_field_edit_account.dart';
import 'package:delveria/features/client/accountInfo/ui/widgets/stacked_profile_image.dart';
import 'package:delveria/features/client/accountInfo/ui/widgets/update_user_data_bloc_listner.dart';
import 'package:delveria/features/client/adresses/ui/widgets/mobile_number_text_field.dart';
import 'package:delveria/features/client/payment/ui/widgets/track_order_button_row.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditAccountInfoScreen extends StatefulWidget {
  const EditAccountInfoScreen({super.key});

  @override
  _EditAccountInfoScreenState createState() => _EditAccountInfoScreenState();
}

class _EditAccountInfoScreenState extends State<EditAccountInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: AppStrings.editInfo.tr(),
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return BlocBuilder<UserDataCubit, UserDataState>(
            builder: (context, userState) {
              final cubit = context.read<UserDataCubit>();
              return SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      StackedProfileImage(themeState: state),
                      verticalSpace(30),
                      FormFieldEditAccount(
                        label: AppStrings.firstName.tr(),
                        controller: firstName,
                        hint: cubit.firstName,
                      ),
                      verticalSpace(30),
                      FormFieldEditAccount(
                        label: AppStrings.lastName.tr(),
                        controller: lastName,
                        hint: cubit.lastName,
                      ),
                      SizedBox(height: 30),
                      FormFieldEditAccount(
                        hint: cubit.email,
                        label: AppStrings.email.tr(),
                        controller: _emailController,
                      ),
                      SizedBox(height: 30),

                      verticalSpace(10),
                      MobileNumberTextField(
                        readOnly: true,
                        hint: cubit.phone,
                        selectedCountryCode: '+20',
                        phoneController: _phoneController,
                      ),
                      SizedBox(height: 60),
                      UpdateUserDataBlocListner(
                        child: TrackOrderButtonRow(
                          ftitle: AppStrings.saveChanges.tr(),
                          sTitle: AppStrings.discard.tr(),
                          fOnPressed: () {
                            cubit.updateUserData(
                              body: {
                                "first_name":
                                    firstName.text.isEmpty
                                        ? cubit.firstName
                                        : firstName.text,
                                "last_name":
                                    lastName.text.isEmpty
                                        ? cubit.lastName
                                        : lastName.text,
                                "email":
                                    _emailController.text.isEmpty
                                        ? cubit.email
                                        : _emailController.text,
                              },
                            );
                            cubit.getUserData();
                          },
                          sOnPressed: () {
                            context.pop();
                          },
                          themeState: state,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
