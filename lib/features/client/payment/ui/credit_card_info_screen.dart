import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/client/payment/ui/widgets/card_holder_name_textField.dart';
import 'package:delveria/features/client/payment/ui/widgets/card_number_text_field.dart';
import 'package:delveria/features/client/payment/ui/widgets/exp_date_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({super.key});

  @override
  _CreditCardScreenState createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: "Payment Method",
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(AppStrings.creditInfo.tr(), style: TextStyles.bimini20W700),
              SizedBox(height: 40),
              Text(AppStrings.cardHolderName.tr(), style: TextStyles.bimini16W400Body),
              SizedBox(height: 8),
              CardHolderNameTextField(
                cardHolderController: cardHolderController,
              ),
              SizedBox(height: 24),
              Text(AppStrings.cardNumber.tr(), style: TextStyles.bimini16W400Body),
              SizedBox(height: 8),
              CardNumberTextField(cardNumberController: cardNumberController),
              SizedBox(height: 24),
              ExpDateTextField(
                expiryController: expiryController,
                cvvController: cvvController,
              ),
verticalSpace(200.h),
              SizedBox(
                width: 500.w,
                child: AppButton(
                  title:AppStrings.confirm.tr(),
                  onPressed: () {
                    context.pushReplacementNamed(Routes.successOrderScreen);
                  },
                ),
              ),
              verticalSpace(40),
            ],
          ),
        ),
      ),
    );
  }
}
