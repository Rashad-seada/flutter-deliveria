import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';

class OrderSummarySection extends StatelessWidget {
  final String? orderPrice;
  final String? deliveryCost;
  final String? totalPrice;

  const OrderSummarySection({
    Key? key,
    this.orderPrice,
    this.deliveryCost,
    this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order Summary",
          style: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
        verticalSpace(16),
        _buildSummaryRow("Order Price:", orderPrice ?? ''),
        const SizedBox(height: 4),
        _buildSummaryRow("Delivery Cost:", deliveryCost ?? ''),
        const SizedBox(height: 4),
        _buildSummaryRow("Total:", totalPrice ?? '', isTotal: true),
        verticalSpace(32),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyles.bimini16W700),
        Text(
          "$value L.E",
          style: isTotal ? TextStyles.bimini16W700 : TextStyles.bimini14W500,
        ),
      ],
    );
  }
}
