import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';

Widget buildDetailRowWithDropdown(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyles.bimini20W700),
        Row(
          children: [
            Text(
              value,
              style: TextStyles.bimini16W400Body.copyWith(
                color: AppColors.grey,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
          ],
        ),
      ],
    ),
  );
}
