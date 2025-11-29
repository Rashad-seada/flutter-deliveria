import 'package:delveria/features/admin/resturantAdmin/data/models/super_categories_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

SuperCategoryInSuper getSelectedSuperCategory(
  List<SuperCategoryInSuper> superCategories,
  String effectiveSuperCategoryName,
  BuildContext context,
) {
  return superCategories.firstWhere(
    (e) => (context.locale.languageCode == "en"
        ? e.nameEn
        : e.nameAr) == effectiveSuperCategoryName,
    orElse: () => superCategories.first,
  );
}
