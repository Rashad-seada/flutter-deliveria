import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';

Widget buildSettingsItem(String title, String subtitle, VoidCallback onTap) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
    minVerticalPadding: 10,
    title: Text(title, style: TextStyles.bimini16W700),
    subtitle: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        subtitle,
        style: TextStyles.bimini16W400Body.copyWith(
          fontStyle: FontStyle.italic,
          color: AppColors.grey,
        ),
      ),
    ),
    trailing: Icon(
      Icons.arrow_forward_ios,
      color: AppColors.darkGrey,
      size: 16,
    ),
    onTap: onTap,
  );
}
