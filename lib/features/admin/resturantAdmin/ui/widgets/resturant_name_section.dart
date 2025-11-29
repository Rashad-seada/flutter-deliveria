import 'package:custom_form_w/custom_form_w.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResturantNameSection extends StatelessWidget {
  const ResturantNameSection({super.key, required this.nameController, required this.estimatedTimeController, required this.passwordController, required this.deliveryCostController});
  final TextEditingController nameController;
  final TextEditingController estimatedTimeController;
  final TextEditingController passwordController;
  final TextEditingController deliveryCostController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      
        verticalSpace(10),
        CustomFormW(
          padding: EdgeInsets.zero,
          showButton: false,
          spacing: 30.h,
          children: [
            CustomTextField(
              controller: nameController,
              headerText: "Resturant Name",
              headerTextStyle: TextStyles.bimini16W700,
              hint: "Enter the restaurant’s  name",
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              hintStyle: TextStyles.bimini13W400Grey,
            ),
       
            CustomTextField(
              controller: passwordController,
              headerText: "Resturant Password",
              headerTextStyle: TextStyles.bimini16W700,
              hint: "Enter the restaurant’s  password",
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              hintStyle: TextStyles.bimini13W400Grey,
            ),
            // CustomTextField(
            //   controller: deliveryCostController,
            //   headerText: "Resturant Delivery Cost ",
            //   headerTextStyle: TextStyles.bimini16W700,
            //   hint: "Enter the restaurant’s  delivery cost ",
            //   contentPadding: EdgeInsets.symmetric(horizontal: 10),
            //   hintStyle: TextStyles.bimini13W400Grey,
            // ),
            CustomTextField(
              controller: estimatedTimeController,
              headerText: "Resturant Estimated Time ",
              headerTextStyle: TextStyles.bimini16W700,
              hint: "Enter the restaurant’s  estimated time ",
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              hintStyle: TextStyles.bimini13W400Grey,
            ),
          ],
        ),
      ],
    );
  }
}
