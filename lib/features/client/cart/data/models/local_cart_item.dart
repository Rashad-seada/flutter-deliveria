
import 'package:delveria/features/client/cart/data/models/add_to_cart_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'local_cart_item.g.dart';

@JsonSerializable()
class LocalCartItem {
  final AddToCartRequest addRequest;
  final String itemName;
  final String itemImage;
  final double itemPrice; // Base price + size/toppings calculated
  final int quantity;
  final String? sizeName;
  final List<String>? toppingNames;
  
  // New fields
  final String? restaurantName;
  final String? restaurantImage;

  LocalCartItem({
    required this.addRequest,
    required this.itemName,
    required this.itemImage,
    required this.itemPrice,
    this.quantity = 1,
    this.sizeName,
    this.toppingNames,
    this.restaurantName,
    this.restaurantImage,
  });

  factory LocalCartItem.fromJson(Map<String, dynamic> json) => _$LocalCartItemFromJson(json);
  Map<String, dynamic> toJson() => _$LocalCartItemToJson(this);
  
  // Create a copy with updated quantity
  LocalCartItem copyWith({int? quantity}) {
    return LocalCartItem(
      addRequest: addRequest,
      itemName: itemName,
      itemImage: itemImage,
      itemPrice: itemPrice,
      quantity: quantity ?? this.quantity,
      sizeName: sizeName,
      toppingNames: toppingNames,
      restaurantName: restaurantName,
      restaurantImage: restaurantImage,
    );
  }
}
