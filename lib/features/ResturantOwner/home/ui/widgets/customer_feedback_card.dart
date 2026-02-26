import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerFeedBackCard extends StatelessWidget {
  const CustomerFeedBackCard({super.key, required this.customerRate});
  final String customerRate;

  @override
  Widget build(BuildContext context) {
    final double rate = double.tryParse(customerRate) ?? 0.0;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.emoji_emotions_outlined,
                  color: Colors.amber.shade700,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12),
              Text(AppStrings.customerFeedback.tr(), style: TextStyles.bimini16W700),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                '$customerRate',
                style: TextStyles.bimini20W700.copyWith(
                  color: AppColors.primary,
                  fontSize: 28.sp,
                ),
              ),
              Text(
                '/5',
                style: TextStyles.bimini16W400Body.copyWith(
                  color: AppColors.grey,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: rate / 5.0,
                    minHeight: 8.h,
                    backgroundColor: AppColors.lightGrey,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      rate >= 4.0
                          ? Colors.green
                          : rate >= 3.0
                              ? Colors.amber
                              : Colors.red.shade400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
