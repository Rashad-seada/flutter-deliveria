import 'package:delveria/core/func/url_launcher.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget socialButton({
  required String label,
  required Widget icon,
  required String url,
  Color? color,
}) {
  return InkWell(
    onTap: () => launchUrlHelper(url, mode: LaunchMode.externalApplication),
    child: Row(
      children: [
        icon,
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyles.bimini14W700.copyWith(color: Colors.blueAccent),
        ),
      ],
    ),
  );
}
