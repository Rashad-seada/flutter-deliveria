// Screen 2: Checkout Screen
import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_cubit.dart';
import 'package:delveria/features/client/cart/ui/widgets/coupone_body_bloc.dart';
import 'package:delveria/features/client/onboarding/logic/cubit/system_data_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required this.totalPrice});
  final int totalPrice;

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          onBack: () {
            context.pushNamed(Routes.bottomBarScreen, arguments: 0);
          },
          title: AppStrings.shippingCart.tr(),
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create:
                      (context) => getIt<CreateAddressCubit>()..getAdresses(),
                ),
                BlocProvider(
                  create:
                      (context) => getIt<SystemDataCubit>()..getSystemData(),
                ),
              ],
              child: CouponeBodyBloc(
                themeState: state,
                totalPrice: widget.totalPrice,
              ),
            ),
          );
        },
      ),
    );
  }
}
