import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';

class StateCardAdmin extends StatelessWidget {
  const StateCardAdmin({super.key, required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyles.bimini20W400),
          Text(
            value,
            style: TextStyles.bimini20W700.copyWith(
              color: AppColors.primaryDeafult,
            ),
          ),
        ],
      ),
    );
  }
}
