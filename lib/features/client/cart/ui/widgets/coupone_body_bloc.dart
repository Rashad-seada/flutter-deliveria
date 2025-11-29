import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_cubit.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_state.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_state.dart';
import 'package:delveria/features/client/cart/logic/cubit/cart_cubit.dart';
import 'package:delveria/features/client/cart/logic/cubit/cart_state.dart';
import 'package:delveria/features/client/cart/ui/widgets/applied_coupon_text.dart';
import 'package:delveria/features/client/cart/ui/widgets/apply_coupon_button.dart';
import 'package:delveria/features/client/cart/ui/widgets/check_coupone_bloc_listener.dart';
import 'package:delveria/features/client/cart/ui/widgets/order_details_section.dart';
import 'package:delveria/features/client/onboarding/logic/cubit/system_data_cubit.dart';
import 'package:delveria/features/client/onboarding/logic/cubit/system_data_state.dart';
import 'package:delveria/features/client/payment/ui/payment_method_screen.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:delveria/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CouponeBodyBloc extends StatefulWidget {
  const CouponeBodyBloc({
    super.key,
    required this.themeState,
    required this.totalPrice,
  });
  final ThemeState themeState;
  final int totalPrice;

  @override
  State<CouponeBodyBloc> createState() => _CouponeBodyBlocState();
}

class _CouponeBodyBlocState extends State<CouponeBodyBloc> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: BlocBuilder<CouponeCubit, CouponeState>(
            builder: (context, couponeState) {
              final couponeCubit = context.read<CouponeCubit>();
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TextField(
                            controller: state.couponeController,
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              hintText: AppStrings.couponCode.tr(),
                              hintStyle: TextStyles.bimini16W400Body.copyWith(
                                color:
                                    widget.themeState.themeMode ==
                                            ThemeMode.dark
                                        ? Colors.white
                                        : AppColors.darkBrown,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.red[700]!),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),

                          verticalSpace(20),
                          BlocBuilder<AddToCartCubit, AddToCartState>(
                            builder: (context, cartState) {
                              return CheckCouponeBlocListener(
                                child: ApplyCouponButton(
                                  state: state,
                                  onPressed: () {
                                    context
                                        .read<CartCubit>()
                                        .toggleApplyCupon();

                                    couponeCubit.checkCoupone(
                                      code: state.couponeController.text,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  (state.applyCupone && state.couponeController.text.isNotEmpty)
                      ? AppliedCouponText(
                        state: state,
                        couponeCubit: couponeCubit,
                      )
                      : SizedBox(),
                  OrderDetailsSection(
                    couponeAccepted:
                        state.couponeController.text != "Aya10" &&
                        state.applyCupone &&
                        state.couponeController.text.isNotEmpty,
                  ),

                  verticalSpace(50),

                  BlocBuilder<SystemDataCubit, SystemDataState>(
                    builder: (context, state) {
                      final cubit = context.read<SystemDataCubit>();
                      return AppButton(
                        title: AppStrings.processToPayment.tr(),
                        onPressed:
                            cubit.isUploaded == false
                                ? () {
                                  showNewDialog(context);
                                }
                                : () async {
                                  final selectedAddressId =
                                      await SharedPrefHelper.getString(
                                        "selected_address_id",
                                      );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => BlocProvider(
                                            create:
                                                (context) =>
                                                    getIt<AddToCartCubit>(),
                                            child: BlocBuilder<
                                              AddToCartCubit,
                                              AddToCartState
                                            >(
                                              builder: (context, state) {
                                                final cartCubit =
                                                    context
                                                        .read<AddToCartCubit>();
                                                return PaymentMethodScreen(
                                                  totalPrice: widget.totalPrice,
                                                  selectedAdress:
                                                      selectedAddressId,
                                                );
                                              },
                                            ),
                                          ),
                                    ),
                                  );
                                },
                      );
                    },
                  ),
                  verticalSpace(30),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void showNewDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor:
              themeState.themeMode == ThemeMode.dark
                  ? AppColors.darkGrey
                  : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.attentionPayment.tr(),
                style: TextStyles.bimini16W700.copyWith(
                  color: AppColors.primaryDeafult,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.paymentMethodCach.tr(),
                style: TextStyles.bimini18W700,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            AppButton(
              title: AppStrings.done.tr(),
              onPressed: () async {
                await SharedPrefHelper.setData(
                  SharedPrefKeys.onlineGuest,
                  true,
                );
                context.pushNamed(Routes.bottomBarScreen, arguments: 0);
              },
            ),
          ],
        );
      },
    );
  }
}
