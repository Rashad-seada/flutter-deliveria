import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/admin/home/ui/widgets/chart_data.dart';
import 'package:delveria/features/admin/home/ui/widgets/days_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersOverTimeCard extends StatelessWidget {
  const OrdersOverTimeCard({super.key, required this.data});
  final List<int> data;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.grey, width: 1),
      ),
      child: Container(
        width: 380,
        height: 391.h,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.ordersOverTime.tr(), style: TextStyles.bimini20W400),
            verticalSpace(10),

         
            const SizedBox(height: 6),

            Row(
              children: [
                Text(
                  'last 7 Days ',
                  style: TextStyles.bimini16W400Body.copyWith(
                    color: AppColors.grey,
                  ),
                ),
               
              ],
            ),
            verticalSpace(40),

            ChartData(data: data),
            const SizedBox(height: 20),

            DaysRow(),
          ],
        ),
      ),
    );
  }
}
