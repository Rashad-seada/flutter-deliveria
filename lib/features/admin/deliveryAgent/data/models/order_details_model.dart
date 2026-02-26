import 'package:json_annotation/json_annotation.dart';

part 'order_details_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDetailsResponse {
  final OrderDetailsModel order;

  OrderDetailsResponse({required this.order});

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderDetailsModel {
  final AddressModel address;
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  final List<RestaurantOrderModel> orders;
  @JsonKey(name: 'final_price_without_delivery_cost')
  final num finalPriceWithoutDeliveryCost;
  @JsonKey(name: 'final_delivery_cost')
  final num finalDeliveryCost;
  @JsonKey(name: 'final_price')
  final num finalPrice;
  @JsonKey(name: 'delivery_type')
  final String? deliveryType;
  @JsonKey(name: 'payment_type')
  final String? paymentType;
  final String? status;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;
  @JsonKey(name: 'delivery_id')
  final String? deliveryId;

  OrderDetailsModel({
    required this.address,
    required this.id,
    required this.userId,
    required this.orders,
    required this.finalPriceWithoutDeliveryCost,
    required this.finalDeliveryCost,
    required this.finalPrice,
    this.deliveryType,
    this.paymentType,
    this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.deliveryId,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailsModelToJson(this);
}

@JsonSerializable()
class AddressModel {
  final CoordinatesModel coordinates;
  @JsonKey(name: 'address_title')
  final String addressTitle;
  final String phone;
  final String details;

  AddressModel({
    required this.coordinates,
    required this.addressTitle,
    required this.phone,
    required this.details,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}

@JsonSerializable()
class CoordinatesModel {
  final String latitude;
  final String longitude;

  CoordinatesModel({
    required this.latitude,
    required this.longitude,
  });

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RestaurantOrderModel {
  @JsonKey(name: 'restaurant_id')
  final String restaurantId;
  @JsonKey(name: 'branch_id', fromJson: _orderDetailsBranchFromJson)
  final OrderDetailsBranchInfo? branch;
  final List<OrderItemModel> items;
  @JsonKey(name: 'price_of_restaurant')
  final num priceOfRestaurant;
  final String status;
  @JsonKey(name: 'cancel_me')
  final bool cancelMe;
  @JsonKey(name: '_id')
  final String id;

  RestaurantOrderModel({
    required this.restaurantId,
    this.branch,
    required this.items,
    required this.priceOfRestaurant,
    required this.status,
    required this.cancelMe,
    required this.id,
  });

  factory RestaurantOrderModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantOrderModelToJson(this);
}

/// Safely parse branch_id which can be a String (old) or Map (new)
OrderDetailsBranchInfo? _orderDetailsBranchFromJson(dynamic json) {
  if (json == null) return null;
  if (json is Map<String, dynamic>) {
    return OrderDetailsBranchInfo.fromJson(json);
  }
  if (json is String) {
    return OrderDetailsBranchInfo(id: json);
  }
  return null;
}

@JsonSerializable()
class OrderDetailsBranchInfo {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  @JsonKey(name: 'branch_name')
  final String? branchName;
  final String? address;
  final String? phone;
  final CoordinatesModel? coordinates;
  @JsonKey(name: 'location_map')
  final String? locationMap;

  OrderDetailsBranchInfo({
    this.id,
    this.name,
    this.branchName,
    this.address,
    this.phone,
    this.coordinates,
    this.locationMap,
  });

  /// Display name helper
  String get displayName => branchName ?? name ?? '';

  factory OrderDetailsBranchInfo.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsBranchInfoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailsBranchInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderItemModel {
  @JsonKey(name: 'item_details')
  final ItemDetailsModel itemDetails;
  @JsonKey(name: 'size_details')
  final SizeDetailsModel sizeDetails;
  @JsonKey(name: 'topping_details')
  final List<ToppingDetailsModel> toppingDetails;
  @JsonKey(name: 'total_price')
  final num totalPrice;
  @JsonKey(name: '_id')
  final String id;

  OrderItemModel({
    required this.itemDetails,
    required this.sizeDetails,
    required this.toppingDetails,
    required this.totalPrice,
    required this.id,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}

@JsonSerializable()
class ItemDetailsModel {
  @JsonKey(name: 'item_id')
  final String itemId;
  final String name;
  final String description;
  final String photo;

  ItemDetailsModel({
    required this.itemId,
    required this.name,
    required this.description,
    required this.photo,
  });

  factory ItemDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDetailsModelToJson(this);
}

@JsonSerializable()
class SizeDetailsModel {
  @JsonKey(name: 'size_id')
  final String sizeId;
  final String size;
  @JsonKey(name: 'price_before')
  final num priceBefore;
  @JsonKey(name: 'price_after')
  final num priceAfter;
  final num offer;
  final int quantity;
  @JsonKey(name: 'price_Of_quantity')
  final num priceOfQuantity;

  SizeDetailsModel({
    required this.sizeId,
    required this.size,
    required this.priceBefore,
    required this.priceAfter,
    required this.offer,
    required this.quantity,
    required this.priceOfQuantity,
  });

  factory SizeDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$SizeDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SizeDetailsModelToJson(this);
}

@JsonSerializable()
class ToppingDetailsModel {
  final String topping;
  final num price;
  final int quantity;
  @JsonKey(name: '_id')
  final String id;

  ToppingDetailsModel({
    required this.topping,
    required this.price,
    required this.quantity,
    required this.id,
  });

  factory ToppingDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ToppingDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ToppingDetailsModelToJson(this);
}
