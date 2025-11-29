import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';

class CustomerOrderDetailsItem extends StatelessWidget {
  const CustomerOrderDetailsItem({super.key, required this.title, required this.description});
  final String title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyles.bimini16W400Body),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyles.bimini14W400White.copyWith(color: AppColors.grey),
        ),
      ],
    );
  }
}
