import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MobileNumberTextField extends StatefulWidget {
  const MobileNumberTextField({
    super.key,
    required this.selectedCountryCode,
    required this.phoneController,
    this.isAdmin,
    this.readOnly,
    this.hint,
  });

  final bool? readOnly;
  final String? hint;
  final String selectedCountryCode;
  final TextEditingController phoneController;
  final bool? isAdmin;

  @override
  State<MobileNumberTextField> createState() => _MobileNumberTextFieldState();
}

class _MobileNumberTextFieldState extends State<MobileNumberTextField> {
  String? errorText;

  
  bool _validatePhone(String phone) {
    final trimmed = phone.trim();
    
    String selectedCode = widget.selectedCountryCode.replaceAll("+", "");
    if (selectedCode == "20") {
      
      
      
      final regex = RegExp(r'^(01[0125][0-9]{8}|1[0125][0-9]{8})$');
      return regex.hasMatch(trimmed);
    } else {
      
      final regex = RegExp(r'^\d{7,15}$');
      return regex.hasMatch(trimmed);
    }
  }

  void _onChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        errorText = AppStrings.mobileNumberRequired.tr();
      } else if (!_validatePhone(value)) {
        if (widget.selectedCountryCode.replaceAll("+", "") == "20") {
          errorText =
              "${AppStrings.pleaseEnterValidMobileNumber.tr()} (Eg. 01xxxxxxxxx)";
        } else {
          errorText = AppStrings.pleaseEnterValidMobileNumber.tr();
        }
      } else {
        errorText = null;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onChanged(widget.phoneController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    String effectiveHint;
    if (widget.hint != null && widget.hint!.isNotEmpty) {
      effectiveHint = widget.hint!;
    } else if (widget.isAdmin == true) {
      effectiveHint = AppStrings.enterRestaurantContactNumber.tr();
    } else {
      effectiveHint = AppStrings.enterYourMobileNumber.tr();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.mobileNumber.tr(), style: TextStyles.bimini16W400Body),
        verticalSpace(10),
        Container(
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  errorText == null
                      ? Colors.grey[300]!
                      : AppColors.primaryDeafult,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  border:
                      widget.isAdmin == true
                          ? null
                          : Border(right: BorderSide(color: Colors.grey[300]!)),
                ),
                child: Row(
                  children: [
                    Text(
                      widget.selectedCountryCode,
                      style: TextStyles.bimini16W400Body,
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color:
                          widget.isAdmin == true
                              ? AppColors.darkGrey
                              : Colors.grey[400],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TextField(
                  readOnly: widget.readOnly ?? false,
                  controller: widget.phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: effectiveHint,
                    hintStyle: TextStyles.bimini13W400Grey,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  onChanged: _onChanged,
                ),
              ),
            ],
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 4.0),
            child: Text(
              errorText!,
              style: TextStyles.bimini13W400Grey.copyWith(
                color: AppColors.primaryDeafult,
                fontSize: 12,
              ),
            ),
          ),
        Align(
          alignment: Alignment.topRight,
          child: Text(
            "برجاء ادخال رقم موبايل يوجد به واتساب ",
            style: TextStyles.bimini13W400Grey.copyWith(
              color: AppColors.primaryDeafult,
            ),
          ),
        ),

      ],
    );
  }
}
