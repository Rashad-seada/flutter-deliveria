import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/client/auth/changePassword/ui/widgets/success_image.dart';
import 'package:delveria/features/client/payment/ui/widgets/order_success_text.dart';
import 'package:delveria/features/client/payment/ui/widgets/track_order_button_row.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: false,
          onBack: () {
            context.pushNamed(Routes.bottomBarScreen, arguments: 0);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            verticalSpace(32),

            SuccessImage(),
            verticalSpace(32),
            Text(
              AppStrings.success.tr(),
              style: TextStyles.bimini31W700PrimaryDeafult.copyWith(
                color: Colors.black,
              ),
            ),
            verticalSpace(20),
            OrderSuccessText(),
            Text(
              AppStrings.clickTrackOrder.tr(),
              style: TextStyles.bimini16W700BoldWhite.copyWith(
                color: AppColors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(70),
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return TrackOrderButtonRow(
                  themeState: state,
                  sOnPressed: () {
                    context.pushNamedAndRemoveUntil(
                      Routes.bottomBarScreen,
                      arguments: 0,
                      predicate: (Route<dynamic> route) => false,
                    );
                  },
                  fOnPressed: () {
                    context.pushNamed(Routes.myOrdersScreen);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
