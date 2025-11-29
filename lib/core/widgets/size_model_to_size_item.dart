import 'package:delveria/features/ResturantOwner/menu/data/models/get_all_item_response.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/widgets/size_selection_widget.dart';
import 'package:flutter/material.dart';

SizeItem sizeModelToSizeItem(SizeModel e) {
  return SizeItem(
    sizeController: TextEditingController(text: e.size?.toString() ?? ''),
    priceBeforeController: TextEditingController(
      text: e.priceBefore?.toString() ?? '',
    ),
    priceAfterController: TextEditingController(
      text: e.priceAfter?.toString() ?? '',
    ),
  );
}
