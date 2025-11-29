import 'package:json_annotation/json_annotation.dart';

part 'all_orders_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AllOrdersModel {
  final List<OrderModel>? orders;

  AllOrdersModel({this.orders});

  factory AllOrdersModel.fromJson(Map<String, dynamic> json) =>
      _$AllOrdersModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllOrdersModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderModel {
  final AddressModel? address;
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'order_id')
  final int? orderId; // <-- Added order_id field, mapped correctly
  @JsonKey(name: 'user_id')
  final String? userId;
  final List<RestaurantOrderModel>? orders;
  @JsonKey(name: 'final_price_without_delivery_cost')
  final dynamic finalPriceWithoutDeliveryCost;
  @JsonKey(name: 'final_delivery_cost')
  final dynamic finalDeliveryCost;
  @JsonKey(name: 'final_price')
  final dynamic finalPrice;
  @JsonKey(name: 'delivery_type')
  final String? deliveryType;
  @JsonKey(name: 'payment_type')
  final String? paymentType;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'delivery_id')
  final String? deliveryId;

  OrderModel({
    this.address,
    this.id,
    this.orderId,
    this.userId,
    this.orders,
    this.finalPriceWithoutDeliveryCost,
    this.finalDeliveryCost,
    this.finalPrice,
    this.deliveryType,
    this.paymentType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.deliveryId,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AddressModel {
  final CoordinatesModel? coordinates;
  @JsonKey(name: 'address_title')
  final String? addressTitle;
  final String? phone;
  final String? details;

  AddressModel({
    this.coordinates,
    this.addressTitle,
    this.phone,
    this.details,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}

@JsonSerializable()
class CoordinatesModel {
  final String? latitude;
  final String? longitude;

  CoordinatesModel({
    this.latitude,
    this.longitude,
  });

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RestaurantOrderModel {
  @JsonKey(name: 'restaurant_id')
  final String? restaurantId;
  final List<OrderItemModel>? items;
  @JsonKey(name: 'price_of_restaurant')
  final dynamic priceOfRestaurant;
  final String? status;
  @JsonKey(name: 'cancel_me')
  final bool? cancelMe;
  @JsonKey(name: '_id')
  final String? id;

  RestaurantOrderModel({
    this.restaurantId,
    this.items,
    this.priceOfRestaurant,
    this.status,
    this.cancelMe,
    this.id,
  });

  factory RestaurantOrderModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantOrderModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderItemModel {
  @JsonKey(name: 'item_details')
  final ItemDetailsModel? itemDetails;
  @JsonKey(name: 'size_details')
  final SizeDetailsModel? sizeDetails;
  @JsonKey(name: 'topping_details')
  final List<ToppingDetailsModel>? toppingDetails;
  final String? description;
  @JsonKey(name: 'total_price')
  final dynamic totalPrice;
  @JsonKey(name: '_id')
  final String? id;

  OrderItemModel({
    this.itemDetails,
    this.sizeDetails,
    this.toppingDetails,
    this.description,
    this.totalPrice,
    this.id,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}

@JsonSerializable()
class ItemDetailsModel {
  @JsonKey(name: 'item_id')
  final String? itemId;
  final String? name;
  final String? description;
  final String? photo;

  ItemDetailsModel({
    this.itemId,
    this.name,
    this.description,
    this.photo,
  });

  factory ItemDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDetailsModelToJson(this);
}

@JsonSerializable()
class SizeDetailsModel {
  @JsonKey(name: 'size_id')
  final String? sizeId;
  final String? size;
  @JsonKey(name: 'price_before')
  final dynamic priceBefore;
  @JsonKey(name: 'price_after')
  final dynamic priceAfter;
  final dynamic offer;
  final dynamic quantity;
  @JsonKey(name: 'price_Of_quantity')
  final dynamic priceOfQuantity;

  SizeDetailsModel({
    this.sizeId,
    this.size,
    this.priceBefore,
    this.priceAfter,
    this.offer,
    this.quantity,
    this.priceOfQuantity,
  });

  factory SizeDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$SizeDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SizeDetailsModelToJson(this);
}

@JsonSerializable()
class ToppingDetailsModel {
  final String? topping;
  final dynamic price;
  final dynamic quantity;
  @JsonKey(name: '_id')
  final String? id;

  ToppingDetailsModel({
    this.topping,
    this.price,
    this.quantity,
    this.id,
  });

  factory ToppingDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ToppingDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ToppingDetailsModelToJson(this);
}
