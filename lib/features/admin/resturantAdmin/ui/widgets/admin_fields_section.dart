import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Admin-only fields section for restaurant creation/editing
/// Contains: Commission Percentage, Preparation Time, Delivery Time
class AdminFieldsSection extends StatelessWidget {
  final TextEditingController commissionController;
  final TextEditingController preparationTimeController;
  final TextEditingController deliveryTimeController;

  const AdminFieldsSection({
    super.key,
    required this.commissionController,
    required this.preparationTimeController,
    required this.deliveryTimeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(
          "Admin Settings",
          style: TextStyles.bimini16W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
        SizedBox(height: 16.h),
        
        // Commission Percentage
        _buildTextField(
          controller: commissionController,
          label: "Commission Percentage (%)",
          hint: "e.g. 15",
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
          suffixText: "%",
        ),
        SizedBox(height: 16.h),
        
        // Preparation Time and Delivery Time Row
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: preparationTimeController,
                label: "Preparation Time",
                hint: "e.g. 20",
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                suffixText: "min",
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _buildTextField(
                controller: deliveryTimeController,
                label: "Delivery Time",
                hint: "e.g. 30",
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                suffixText: "min",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? suffixText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.bimini14W700.copyWith(color: Colors.black87),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            suffixText: suffixText,
            suffixStyle: TextStyles.bimini14W700.copyWith(
              color: AppColors.primaryDeafult,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.primaryDeafult, width: 2),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
        ),
      ],
    );
  }
}
