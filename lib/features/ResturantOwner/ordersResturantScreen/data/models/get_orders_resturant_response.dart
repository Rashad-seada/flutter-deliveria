import 'package:json_annotation/json_annotation.dart';

part 'get_orders_resturant_response.g.dart';

num? _numFromJson(dynamic value) {
  if (value == null) return null;
  if (value is num) return value;
  if (value is String) return num.tryParse(value);
  return null;
}

@JsonSerializable(explicitToJson: true)
class GetOrdersResturantResponse {
  final List<OrderResturantModel>? orders;

  GetOrdersResturantResponse({this.orders});

  factory GetOrdersResturantResponse.fromJson(Map<String, dynamic> json) =>
      _$GetOrdersResturantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetOrdersResturantResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderResturantModel {
  final AddressModel? address;
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'user_id')
  final UserModel? user;
  final List<ResturantOrderModel>? orders;
  @JsonKey(name: 'final_price_without_delivery_cost', fromJson: _numFromJson)
  final num? finalPriceWithoutDeliveryCost;
  @JsonKey(name: 'final_delivery_cost', fromJson: _numFromJson)
  final num? finalDeliveryCost;
  @JsonKey(name: 'final_price', fromJson: _numFromJson)
  final num? finalPrice;
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
  @JsonKey(name: 'order_id')
  final int? orderId;

  OrderResturantModel({
    this.address,
    this.id,
    this.user,
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
    this.orderId,
  });

  factory OrderResturantModel.fromJson(Map<String, dynamic> json) =>
      _$OrderResturantModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResturantModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserModel {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
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
  @JsonKey(fromJson: _numFromJson)
  final num? latitude;
  @JsonKey(fromJson: _numFromJson)
  final num? longitude;

  CoordinatesModel({
    this.latitude,
    this.longitude,
  });

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResturantOrderModel {
  @JsonKey(name: 'restaurant_id')
  final String? restaurantId;
  final List<OrderItemModel>? items;
  @JsonKey(name: 'price_of_restaurant', fromJson: _numFromJson)
  final num? priceOfRestaurant;
  final String? status;
  @JsonKey(name: 'cancel_me')
  final bool? cancelMe;
  @JsonKey(name: '_id')
  final String? id;

  ResturantOrderModel({
    this.restaurantId,
    this.items,
    this.priceOfRestaurant,
    this.status,
    this.cancelMe,
    this.id,
  });

  factory ResturantOrderModel.fromJson(Map<String, dynamic> json) =>
      _$ResturantOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResturantOrderModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderItemModel {
  @JsonKey(name: 'item_details')
  final ItemDetailsModel? itemDetails;
  @JsonKey(name: 'size_details')
  final SizeDetailsModel? sizeDetails;
  // Change: topping_details is a List<ToppingDetailsModel>
  @JsonKey(name: 'topping_details')
  final List<ToppingDetailsModel>? toppingDetails;
  final String? description;
  @JsonKey(name: 'total_price', fromJson: _numFromJson)
  final num? totalPrice;
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
  @JsonKey(name: 'price_before', fromJson: _numFromJson)
  final num? priceBefore;
  @JsonKey(name: 'price_after', fromJson: _numFromJson)
  final num? priceAfter;
  @JsonKey(fromJson: _numFromJson)
  final num? offer;
  final int? quantity;
  @JsonKey(name: 'price_Of_quantity', fromJson: _numFromJson)
  final num? priceOfQuantity;

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
  @JsonKey(name: 'topping_id')
  final String? toppingId;
  @JsonKey(fromJson: _numFromJson)
  final num? price;
  final int? quantity;
  final String? topping;
  @JsonKey(name: 'price_Of_quantity', fromJson: _numFromJson)
  final num? priceOfQuantity;
  @JsonKey(name: '_id')
  final String? id;

  ToppingDetailsModel({
    this.toppingId,
    this.price,
    this.quantity,
    this.topping,
    this.priceOfQuantity,
    this.id,
  });

  factory ToppingDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ToppingDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ToppingDetailsModelToJson(this);
}
