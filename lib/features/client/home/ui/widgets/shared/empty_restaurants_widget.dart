import 'package:delveria/core/helper/strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Reusable empty state widget for restaurant lists
class EmptyRestaurantsWidget extends StatelessWidget {
  final String? customMessage;
  
  const EmptyRestaurantsWidget({super.key, this.customMessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          customMessage ?? AppStrings.noRestaurantsFound.tr(),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
