import 'package:json_annotation/json_annotation.dart';

part 'get_cart_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetCartResponse {
  final bool? success;
  final CartData? data;

  GetCartResponse({
    this.success,
    this.data,
  });

  factory GetCartResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCartResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CartData {
  @JsonKey(name: '_id')
  final String? id;
  final String? user_id;
  final List<Cart>? carts;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;
  final num? final_price_without_delivery_cost;
  final num? final_delivery_cost;
  final num? final_price;

  CartData({
    this.id,
    this.user_id,
    this.carts,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.final_price_without_delivery_cost,
    this.final_delivery_cost,
    this.final_price,
  });

  factory CartData.fromJson(Map<String, dynamic> json) =>
      _$CartDataFromJson(json);

  Map<String, dynamic> toJson() => _$CartDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Cart {
  final RestaurantDetails? restaurant_details;
  final List<CartItem>? items;
  final num? price_of_restaurant;

  Cart({
    this.restaurant_details,
    this.items,
    this.price_of_restaurant,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RestaurantDetails {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final num? delivery_cost;

  RestaurantDetails({
    this.id,
    this.name,
    this.delivery_cost,
  });

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantDetailsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CartItem {
  final ItemDetails? item_details;
  final SizeDetails? size_details;
  @JsonKey(defaultValue: const [])
  final List<ToppingDetails>? topping_details;
  final String? description;
  final num? total_price;

  CartItem({
    this.item_details,
    this.size_details,
    this.topping_details,
    this.description,
    this.total_price,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ItemDetails {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? description;
  final String? photo;

  ItemDetails({
    this.id,
    this.name,
    this.description,
    this.photo,
  });

  factory ItemDetails.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDetailsToJson(this);
}

@JsonSerializable()
class SizeDetails {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final num? price_before;
  final num? price_after;
  final int? quantity;
  final num? price_of_quantity;

  SizeDetails({
    this.id,
    this.name,
    this.price_before,
    this.price_after,
    this.quantity,
    this.price_of_quantity,
  });

  factory SizeDetails.fromJson(Map<String, dynamic> json) =>
      _$SizeDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$SizeDetailsToJson(this);
}

@JsonSerializable()
class ToppingDetails {
  @JsonKey(name: '_id')
  final String? id;
  final String? topping;
  final num? price;
  final int? quantity;
  final num? price_of_quantity;

  ToppingDetails({
    this.id,
    this.topping,
    this.price,
    this.quantity,
    this.price_of_quantity,
  });

  factory ToppingDetails.fromJson(Map<String, dynamic> json) =>
      _$ToppingDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ToppingDetailsToJson(this);
}