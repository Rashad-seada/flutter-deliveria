import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LogoutRow extends StatelessWidget {
  const LogoutRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.logout, color: Colors.black, size: 20),
        SizedBox(width: 12),
        Text(AppStrings.logOut.tr(), style: TextStyles.bimini16W700),
      ],
    );
  }
}
