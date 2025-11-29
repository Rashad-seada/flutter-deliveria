import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardHolderNameTextField extends StatelessWidget {
  const CardHolderNameTextField({
    super.key,
    required this.cardHolderController,
  });

  final TextEditingController cardHolderController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: cardHolderController,
      decoration: InputDecoration(
        hintText: 'Enter Card holder name',
        hintStyle: TextStyles.bimini13W400Grey,
     
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: Colors.red[700]!, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
