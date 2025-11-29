import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';

Widget buildEmptyState() {
  return Center(
    child: Text(
      "No valid categories available.",
      style: TextStyles.bimini16W700.copyWith(color: Colors.black),
    ),
  );
}
