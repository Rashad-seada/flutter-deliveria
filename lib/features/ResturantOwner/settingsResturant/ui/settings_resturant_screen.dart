import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/url_launcher.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/ResturantOwner/resturantProfile/logic/cubit/resturant_profile_data_cubit.dart';
import 'package:delveria/features/ResturantOwner/resturantProfile/resturant_profile.dart';
import 'package:delveria/features/ResturantOwner/settingsResturant/ui/widgets/build_settings_item.dart';
import 'package:delveria/features/ResturantOwner/settingsResturant/ui/widgets/log_out_row.dart';
import 'package:delveria/features/client/settings/ui/language_selection_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';

class SettingsResturantScreen extends StatefulWidget {
  const SettingsResturantScreen({super.key, this.isAdmin});
  final bool? isAdmin;

  @override
  _SettingsResturantScreenState createState() =>
      _SettingsResturantScreenState();
}

class _SettingsResturantScreenState extends State<SettingsResturantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: AppStrings.setting.tr(),
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(15),
              // Text(AppStrings.appPrefrence, style: TextStyles.bimini20W700),
              // SizedBox(height: 15),

              // NotificationRow(),
              // verticalSpace(20),
              // SoundSettings(),
              verticalSpace(30),
              Text(
                AppStrings.accountManagement.tr(),
                style: TextStyles.bimini20W700,
              ),
              verticalSpace(15),
        widget.isAdmin==true? SizedBox():     buildSettingsItem(
                AppStrings.restaurantProfile.tr(),
                AppStrings.updateResturantProfile.tr(),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create:
                                    (context) =>
                                        getIt<ResturantProfileDataCubit>()
                                          ..getResturantProfileData(),
                              ),
                              BlocProvider(
                                create:
                                    (context) =>
                                        getIt<AllresturantsadminCubit>(),
                              ),
                            ],
                            child: ResturantProfile(),
                          ),
                    ),
                  );
                },
              ),
              verticalSpace(12),
              buildSettingsItem(
                AppStrings.languageSettings.tr(),
                AppStrings.updateLanguageSettings.tr(),
                () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const LanguageSelectionDialog();
                    },
                  );
                },
              ),
              verticalSpace(12),
          widget.isAdmin==true?SizedBox():    buildSettingsItem(
                AppStrings.support.tr(),
                AppStrings.contactSupport.tr(),
                    () => launchUrlHelper(
                      'https://wa.me/message/2CXIY5TFVUZ6O1?src=qr',
                      mode: LaunchMode.externalApplication,
                    ),
              ),
              verticalSpace(40),
              LogoutRow(),
              verticalSpace(50),
            ],
          ),
        ),
      ),
    );
  }
}
