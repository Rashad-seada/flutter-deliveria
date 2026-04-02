import 'package:json_annotation/json_annotation.dart';

part 'each_agent_order_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EachAgentOrderResponse {
  final List<EachAgentOrderModel> orders;

  EachAgentOrderResponse({
    required this.orders,
  });

  factory EachAgentOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$EachAgentOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EachAgentOrderResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EachAgentOrderModel {
  final AddressModel address;
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'user_id')
  final UserModel userId;
  final List<EachOrderModel> orders;
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

  EachAgentOrderModel({
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

  factory EachAgentOrderModel.fromJson(Map<String, dynamic> json) =>
      _$EachAgentOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$EachAgentOrderModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
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
  @JsonKey(fromJson: _asString, toJson: _toString)
  final String latitude;
  @JsonKey(fromJson: _asString, toJson: _toString)
  final String longitude;

  CoordinatesModel({
    required this.latitude,
    required this.longitude,
  });

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesModelToJson(this);

  static String _asString(dynamic value) => value?.toString() ?? '';
  static dynamic _toString(String value) => value;
}

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EachOrderModel {
  @JsonKey(name: 'restaurant_id')
  final RestaurantModel? restaurantId;
  @JsonKey(name: 'branch_id', fromJson: _eachOrderBranchFromJson)
  final EachOrderBranchInfo? branch;
  final List<OrderItemModel> items;
  @JsonKey(name: 'price_of_restaurant')
  final num priceOfRestaurant;
  final String status;
  @JsonKey(name: 'cancel_me')
  final bool cancelMe;
  @JsonKey(name: '_id')
  final String id;

  EachOrderModel({
    this.restaurantId,
    this.branch,
    required this.items,
    required this.priceOfRestaurant,
    required this.status,
    required this.cancelMe,
    required this.id,
  });

  factory EachOrderModel.fromJson(Map<String, dynamic> json) =>
      _$EachOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$EachOrderModelToJson(this);
}

/// Safely parse branch_id which can be a String (old) or Map (new)
EachOrderBranchInfo? _eachOrderBranchFromJson(dynamic json) {
  if (json == null) return null;
  if (json is Map<String, dynamic>) {
    return EachOrderBranchInfo.fromJson(json);
  }
  if (json is String) {
    return EachOrderBranchInfo(id: json);
  }
  return null;
}

@JsonSerializable()
class EachOrderBranchInfo {
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

  EachOrderBranchInfo({
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

  factory EachOrderBranchInfo.fromJson(Map<String, dynamic> json) =>
      _$EachOrderBranchInfoFromJson(json);

  Map<String, dynamic> toJson() => _$EachOrderBranchInfoToJson(this);
}

@JsonSerializable()
class RestaurantModel {
  @JsonKey(name: '_id')
  final String id;
  final String logo;
  final String name;
  final String phone;

  RestaurantModel({
    required this.id,
    required this.logo,
    required this.name,
    required this.phone,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderItemModel {
  @JsonKey(name: 'item_details')
  final ItemDetailsModel itemDetails;
  @JsonKey(name: 'size_details')
  final SizeDetailsModel sizeDetails;
  @JsonKey(name: 'topping_details')
  final List<ToppingDetailsModel> toppingDetails;
  final String? description;
  @JsonKey(name: 'total_price')
  final num totalPrice;
  @JsonKey(name: '_id')
  final String id;

  OrderItemModel({
    required this.itemDetails,
    required this.sizeDetails,
    required this.toppingDetails,
    this.description,
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
