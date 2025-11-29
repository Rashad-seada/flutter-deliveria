import 'dart:async';

import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_state.dart'
    as cartState;
import 'package:delveria/features/client/payment/data/repo/paymob_repo.dart';
import 'package:delveria/features/client/payment/ui/payment_web_view_screen.dart';
import 'package:delveria/features/client/payment/ui/widgets/add_order_bloc_listener.dart';
import 'package:delveria/features/client/payment/ui/widgets/payment_option.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key, this.selectedAdress, this.totalPrice});
  final String? selectedAdress;
  final int? totalPrice;

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedMethod = '';

  @override
  void initState() {
    super.initState();
    print("toooootal ${widget.totalPrice}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: AppStrings.paymentMethod.tr(),
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              AppStrings.choosePaymentMethod.tr(),
              style: TextStyles.bimini20W700,
            ),
            SizedBox(height: 40),
            (widget.totalPrice != null && widget.totalPrice! > 250)
                ? SizedBox()
                : PaymentOption(
                  title: AppStrings.cash.tr(),
                  isSelected: selectedMethod == 'cash',
                  onTap: () {
                    setState(() {
                      selectedMethod = 'cash';
                    });
                  },
                  imgRed: AppImages.cashRed,
                  imgGrey: AppImages.cashGrey,
                ),
            SizedBox(height: 20),
            PaymentOption(
              imgRed: AppImages.creditRed,
              imgGrey: AppImages.creditGrey,
              title: AppStrings.credit.tr(),
              isSelected: selectedMethod == 'card',
              onTap: () {
                setState(() {
                  selectedMethod = 'card';
                });
              },
            ),
            (widget.totalPrice != null && widget.totalPrice! > 250)
                ? Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: Text(
                    AppStrings.reasonBehindCash.tr(),
                    style: TextStyles.bimini14W700.copyWith(
                      color: AppColors.primaryDeafult,
                    ),
                  ),
                )
                : SizedBox(),
            Spacer(),
            AddOrderBlocListener(
              child: BlocBuilder<AddToCartCubit, cartState.AddToCartState>(
                builder: (context, cartState) {
                  final cubit = context.read<AddToCartCubit>();
                  return SizedBox(
                    width: 500.w,
                    child: AppButton(
                      title: AppStrings.confirm.tr(),
                      onPressed: () async {
                        if (selectedMethod == "card") {
                          await pay(
                            amount: widget.totalPrice?.toDouble() ?? 0,
                            onPaymentApproved: () {
                              print("Payment approved, calling addOrder...");
                              cubit.addOrder(
                                body: {
                                  "payment_type": "card",
                                  "address_id": widget.selectedAdress,
                                },
                              );
                              // cubit.getCart();
                            },
                          );
                        } else if (selectedMethod == "cash") {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return BlocBuilder<ThemeCubit, ThemeState>(
                                builder: (context, state) {
                                  return AlertDialog(
                                    backgroundColor:
                                        state.themeMode == ThemeMode.dark
                                            ? AppColors.darkGrey
                                            : Colors.white,
                                    content: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(AppImages.attention),
                                          Text(AppStrings.attention.tr()),
                                          AppButton(
                                            title: "I Agree ",
                                            onPressed: () {
                                              cubit.addOrder(
                                                body: {
                                                  "payment_type": "cash",
                                                  "address_id":
                                                      widget.selectedAdress,
                                                },
                                              );
                                              context.pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        } else {
                          showWarningSnackBar(context, AppStrings.youMustChoosePaymentMethod.tr());
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            verticalSpace(40),
          ],
        ),
      ),
    );
  }

  Future<void> pay({
    required double amount,
    required VoidCallback onPaymentApproved,
  }) async {
    final repo = PaymobRepo(apiServices: getIt());

    final result = await repo.getPaymentKeyForUi(
      amount: amount,
      currency: 'EGP',
    );

    if (result is Success<String>) {
      final paymentKey = (result).data;
      final url =
          "https://accept.paymob.com/api/acceptance/iframes/${ApiConstants.iFrameId}?payment_token=$paymentKey";

      final paymentResult = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder:
              (context) => PaymentWebViewScreen(
                paymentUrl: url,
                onPaymentApproved: onPaymentApproved,
              ),
        ),
      );

      if (paymentResult == true) {
        print("Payment completed successfully");
      }
    } else if (result is Failure) {
      final errorMsg = (result as Failure).message;
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMsg.message)));
      }
    }
  }
}
