import 'package:custom_form_w/custom_form_w.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemPriceTextField extends StatelessWidget {
  const ItemPriceTextField({super.key, required this.priceController});
  final TextEditingController priceController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 84.w,
      child: CustomFormW(
        padding: EdgeInsets.zero,
        showButton: false,
        children: [
          CustomTextField(
            controller: priceController,
            headerText: "Item Price",
            headerTextStyle: TextStyles.bimini16W700,
            hint: "320 LE",
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            hintStyle: TextStyles.bimini13W400Grey,
            radius: 5.r,
          ),
        ],
      ),
    );
  }
}
