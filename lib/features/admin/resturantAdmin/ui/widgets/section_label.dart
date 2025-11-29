import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';

Widget buildSectionLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(text, style: TextStyles.bimini16W700),
  );
}
