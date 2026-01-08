import 'package:json_annotation/json_annotation.dart';

part 'get_orders_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GetOrdersModel {
  final List<OrderModel>? orders;

  GetOrdersModel({this.orders});

  factory GetOrdersModel.fromJson(Map<String, dynamic> json) =>
      _$GetOrdersModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetOrdersModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderModel {
  final OrderAddress? address;
  @JsonKey(name: '_id')
  final String? id;
  final String? user_id;
  final List<RestaurantOrder>? orders;
  final num? final_price_without_delivery_cost;
  final num? final_delivery_cost;
  final num? final_price;
  final String? delivery_type;
  final String? delivery_id;
  final String? payment_type;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'order_id')
  final int? orderId;

  OrderModel({
    this.address,
    this.id,
    this.user_id,
    this.orders,
    this.final_price_without_delivery_cost,
    this.final_delivery_cost,
    this.final_price,
    this.delivery_type,
    this.delivery_id,
    this.payment_type,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.orderId,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderAddress {
  final OrderCoordinates? coordinates;
  final String? address_title;
  final String? phone;
  final String? details;

  OrderAddress({
    this.coordinates,
    this.address_title,
    this.phone,
    this.details,
  });

  factory OrderAddress.fromJson(Map<String, dynamic> json) =>
      _$OrderAddressFromJson(json);

  Map<String, dynamic> toJson() => _$OrderAddressToJson(this);
}

@JsonSerializable()
class OrderCoordinates {
  final double? latitude;
  final double? longitude;

  OrderCoordinates({
    this.latitude,
    this.longitude,
  });

  factory OrderCoordinates.fromJson(Map<String, dynamic> json) =>
      _$OrderCoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCoordinatesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RestaurantOrder {
  final String? restaurant_id;
  final List<OrderItem>? items;
  final num? price_of_restaurant;
  final String? status;
  final bool? cancel_me;
  @JsonKey(name: '_id')
  final String? id;

  RestaurantOrder({
    this.restaurant_id,
    this.items,
    this.price_of_restaurant,
    this.status,
    this.cancel_me,
    this.id,
  });

  factory RestaurantOrder.fromJson(Map<String, dynamic> json) =>
      _$RestaurantOrderFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantOrderToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderItem {
  final OrderItemDetails? item_details;
  final OrderSizeDetails? size_details;
  final List<OrderToppingDetails>? topping_details;
  final num? total_price;
  @JsonKey(name: '_id')
  final String? id;

  OrderItem({
    this.item_details,
    this.size_details,
    this.topping_details,
    this.total_price,
    this.id,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

@JsonSerializable()
class OrderItemDetails {
  final String? item_id;
  final String? name;
  final String? description;
  final String? photo;

  OrderItemDetails({
    this.item_id,
    this.name,
    this.description,
    this.photo,
  });

  factory OrderItemDetails.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemDetailsToJson(this);
}

@JsonSerializable()
class OrderSizeDetails {
  final String? size_id;
  final String? size;
  final num? price_before;
  final num? price_after;
  final num? offer;
  final int? quantity;
  @JsonKey(name: 'price_Of_quantity')
  final num? priceOfQuantity;

  OrderSizeDetails({
    this.size_id,
    this.size,
    this.price_before,
    this.price_after,
    this.offer,
    this.quantity,
    this.priceOfQuantity,
  });

  factory OrderSizeDetails.fromJson(Map<String, dynamic> json) =>
      _$OrderSizeDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$OrderSizeDetailsToJson(this);
}

@JsonSerializable()
class OrderToppingDetails {
  final String? topping;
  final num? price;
  final int? quantity;
  @JsonKey(name: '_id')
  final String? id;

  OrderToppingDetails({
    this.topping,
    this.price,
    this.quantity,
    this.id,
  });

  factory OrderToppingDetails.fromJson(Map<String, dynamic> json) =>
      _$OrderToppingDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToppingDetailsToJson(this);
}
