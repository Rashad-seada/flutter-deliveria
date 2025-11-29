import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DetailsAdressTextField extends StatelessWidget {
  const DetailsAdressTextField({
    super.key,
    required TextEditingController detailsController,
  }) : _detailsController = detailsController;

  final TextEditingController _detailsController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        controller: _detailsController,
        maxLines: 1,
        decoration: InputDecoration(
          hintText:AppStrings.enterDetailsAddress.tr(),
          hintStyle: TextStyles.bimini13W400Grey,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}
