import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/features/admin/home/ui/widgets/state_card_admin.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TotalAmountRow extends StatelessWidget {
  const TotalAmountRow({super.key, required this.totalAmount, required this.ordersToday});
  final String totalAmount;
  final String ordersToday;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StateCardAdmin(title: AppStrings.totalAmount.tr(), value: totalAmount),
        ),
        SizedBox(width: 16),
        Expanded(child: StateCardAdmin(title: AppStrings.ordersToday.tr(), value: ordersToday)),
      ],
    );
  }
}
