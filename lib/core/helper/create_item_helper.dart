import 'package:delveria/features/ResturantOwner/menu/ui/widgets/size_selection_widget.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/widgets/toppings_selection_widget.dart';

class CreateItemHelper {
  static Map<String, dynamic> buildItemData({
    required List<SizeItemData> sizes,
    required List<ToppingItemData> toppings,
  }) {
    Map<String, dynamic> data = {};

    
    for (int i = 0; i < sizes.length; i++) {
      data['sizes[$i][size]'] = sizes[i].sizeName;
      data['sizes[$i][price_before]'] = sizes[i].priceBefore;
      data['sizes[$i][price_after]'] = sizes[i].priceAfter;
    }

    
    for (int i = 0; i < toppings.length; i++) {
      data['toppings[$i][topping]'] = toppings[i].toppingName;
      data['toppings[$i][price]'] = toppings[i].price;
    }

    return data;
  }

  
  static Map<String, dynamic> buildItemDataFromControllers({
    required List<SizeItem> sizes,
    required List<ToppingItem> toppings,
  }) {
    Map<String, dynamic> data = {};

    
    for (int i = 0; i < sizes.length; i++) {
      if (sizes[i].sizeController.text.isNotEmpty &&
          sizes[i].priceBeforeController.text.isNotEmpty &&
          sizes[i].priceAfterController.text.isNotEmpty) {
        data['sizes[$i][size]'] = sizes[i].sizeController.text;
        data['sizes[$i][price_before]'] = sizes[i].priceBeforeController.text;
        data['sizes[$i][price_after]'] = sizes[i].priceAfterController.text;
      }
    }

    
    for (int i = 0; i < toppings.length; i++) {
      if (toppings[i].nameController.text.isNotEmpty &&
          toppings[i].priceController.text.isNotEmpty) {
        data['toppings[$i][topping]'] = toppings[i].nameController.text;
        data['toppings[$i][price]'] = toppings[i].priceController.text;
      }
    }

    return data;
  }
}


class SizeItemData {
  final String sizeName;
  final String priceBefore;
  final String priceAfter;

  SizeItemData({
    required this.sizeName,
    required this.priceBefore,
    required this.priceAfter,
  });
}

class ToppingItemData {
  final String toppingName;
  final String price;

  ToppingItemData({required this.toppingName, required this.price});
}


extension SizeItemExtension on SizeItem {
  SizeItemData? toSizeItemData() {
    if (sizeController.text.isEmpty ||
        priceBeforeController.text.isEmpty ||
        priceAfterController.text.isEmpty) {
      return null;
    }
    return SizeItemData(
      sizeName: sizeController.text,
      priceBefore: priceBeforeController.text,
      priceAfter: priceAfterController.text,
    );
  }
}

extension ToppingItemExtension on ToppingItem {
  ToppingItemData? toToppingItemData() {
    if (nameController.text.isEmpty || priceController.text.isEmpty) {
      return null;
    }
    return ToppingItemData(
      toppingName: nameController.text,
      price: priceController.text,
    );
  }
}
