import 'package:delveria/features/admin/resturantAdmin/data/models/super_categories_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

List<SubCategory> getSubCategories(SuperCategoryInSuper superCategory, BuildContext context) {
  final isEn = context.locale.languageCode == "en";
  return superCategory.subCategories.where(
    (e) => isEn ? e.nameEn.isNotEmpty : e.nameAr.isNotEmpty,
  ).toList();
}
