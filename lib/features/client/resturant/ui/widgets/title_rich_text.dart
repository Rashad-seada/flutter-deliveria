import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/resturant/ui/restaurant_filteration_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TitleRichText extends StatelessWidget {
  const TitleRichText({super.key, required this.title, required this.sortType});
  final String title;
  final String sortType;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: title, style: TextStyles.bimini20W700),
          sortType == "selling"
              ? TextSpan(
                text: AppStrings.sellingFrom.tr(),
                style: TextStyles.bimini18W700,
              )
              : TextSpan(
                text: AppStrings.priceFrom.tr(),
                style: TextStyles.bimini18W700,
              ),
        ],
      ),
    );
  }
}
