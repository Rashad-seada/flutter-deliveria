import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/search_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget buildHeader() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      verticalSpace(20),
      const SearchRow(showButton: false, showIosArrow: true),
      verticalSpace(30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(AppStrings.categories.tr(), style: TextStyles.bimini20W700),
      ),
      const SizedBox(height: 20),
    ],
  );
}
