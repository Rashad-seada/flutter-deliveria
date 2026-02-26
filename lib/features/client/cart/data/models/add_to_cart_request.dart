import 'package:json_annotation/json_annotation.dart';

part 'add_to_cart_request.g.dart';

@JsonSerializable()
class ToppingRequest {
  final String topping;

  ToppingRequest({required this.topping});

  factory ToppingRequest.fromJson(Map<String, dynamic> json) =>
      _$ToppingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ToppingRequestToJson(this);
}

@JsonSerializable()
class AddToCartRequest {
  @JsonKey(name: 'restaurant_id')
  final String restaurantId;

  @JsonKey(name: 'item_id')
  final String itemId;

  final String size;

  final List<ToppingRequest> toppings;

  final String description;

  AddToCartRequest({
    required this.restaurantId,
    required this.itemId,
    required this.size,
    required this.toppings,
    required this.description,
    this.quantity = 1,
  });

  final int? quantity;

  factory AddToCartRequest.fromJson(Map<String, dynamic> json) =>
      _$AddToCartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartRequestToJson(this);
}
