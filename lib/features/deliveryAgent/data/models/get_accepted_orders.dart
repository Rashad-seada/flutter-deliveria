import 'package:json_annotation/json_annotation.dart';

part 'get_accepted_orders.g.dart';

@JsonSerializable(explicitToJson: true)
class GetAcceptedOrdersResponse {
  final List<AcceptedOrder> orders;

  GetAcceptedOrdersResponse({required this.orders});

  factory GetAcceptedOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAcceptedOrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAcceptedOrdersResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AcceptedOrder {
  final AcceptedOrderAddress address;
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'user_id')
  final AcceptedOrderUser userId;
  final List<AcceptedOrderRestaurantOrder> orders;
  @JsonKey(name: 'final_price_without_delivery_cost')
  final num finalPriceWithoutDeliveryCost;
  @JsonKey(name: 'final_delivery_cost')
  final num finalDeliveryCost;
  @JsonKey(name: 'final_price')
  final num finalPrice;
  @JsonKey(name: 'delivery_type')
  final String deliveryType;
  @JsonKey(name: 'payment_type')
  final String paymentType;
  final String status;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;
  @JsonKey(name: 'delivery_id')
  final String? deliveryId;

  // ADD: Order ID (as received in example, integer, but can be num for generality)
  @JsonKey(name: 'order_id')
  final num? orderId;

  AcceptedOrder({
    required this.address,
    required this.id,
    required this.userId,
    required this.orders,
    required this.finalPriceWithoutDeliveryCost,
    required this.finalDeliveryCost,
    required this.finalPrice,
    required this.deliveryType,
    required this.paymentType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.deliveryId,
    this.orderId,
  });

  factory AcceptedOrder.fromJson(Map<String, dynamic> json) =>
      _$AcceptedOrderFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptedOrderToJson(this);
}

@JsonSerializable()
class AcceptedOrderAddress {
  final AcceptedOrderCoordinates? coordinates;
  @JsonKey(name: 'address_title')
  final String? addressTitle;
  final String? phone;
  final String? details;

  AcceptedOrderAddress({
    this.coordinates,
    this.addressTitle,
    this.phone,
    this.details,
  });

  factory AcceptedOrderAddress.fromJson(Map<String, dynamic> json) =>
      _$AcceptedOrderAddressFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptedOrderAddressToJson(this);
}

@JsonSerializable()
class AcceptedOrderCoordinates {
  @JsonKey(fromJson: _safeDoubleFromJson)
  final double latitude;
  @JsonKey(fromJson: _safeDoubleFromJson)
  final double longitude;

  AcceptedOrderCoordinates({
    required this.latitude,
    required this.longitude,
  });

  factory AcceptedOrderCoordinates.fromJson(Map<String, dynamic> json) =>
      _$AcceptedOrderCoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptedOrderCoordinatesToJson(this);
}

/// Robust double parsing to avoid type errors from backend
double _safeDoubleFromJson(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is num) return value.toDouble();
  if (value is String) {
    final parsed = double.tryParse(value);
    if (parsed != null) return parsed;
    // Try to clean up string (e.g. remove commas, spaces)
    final cleaned = value.replaceAll(RegExp(r'[^\d\.\-]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }
  return 0.0;
}

@JsonSerializable()
class AcceptedOrderUser {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;

  AcceptedOrderUser({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory AcceptedOrderUser.fromJson(Map<String, dynamic> json) =>
      _$AcceptedOrderUserFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptedOrderUserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AcceptedOrderRestaurantOrder {
  @JsonKey(name: 'restaurant_id')
  final AcceptedOrderRestaurantInfo restaurantId;
  @JsonKey(name: 'branch_id', fromJson: _acceptedBranchInfoFromJson)
  final AcceptedOrderBranchInfo? branch;
  final List<AcceptedOrderItem> items;
  @JsonKey(name: 'price_of_restaurant')
  final num priceOfRestaurant;
  @JsonKey(name: '_id')
  final String id;
  final String? status;
  @JsonKey(name: 'cancel_me')
  final bool? cancelMe;

  AcceptedOrderRestaurantOrder({
    required this.restaurantId,
    this.branch,
    required this.items,
    required this.priceOfRestaurant,
    required this.id,
    this.status,
    this.cancelMe,
  });

  factory AcceptedOrderRestaurantOrder.fromJson(Map<String, dynamic> json) =>
      _$AcceptedOrderRestaurantOrderFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptedOrderRestaurantOrderToJson(this);
}

/// Safely parse branch_id which can be a String (old) or Map (new)
AcceptedOrderBranchInfo? _acceptedBranchInfoFromJson(dynamic json) {
  if (json == null) return null;
  if (json is Map<String, dynamic>) {
    return AcceptedOrderBranchInfo.fromJson(json);
  }
  if (json is String) {
    return AcceptedOrderBranchInfo(id: json);
  }
  return null;
}

@JsonSerializable(explicitToJson: true)
class AcceptedOrderBranchInfo {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  @JsonKey(name: 'branch_name')
  final String? branchName;
  final String? address;
  final String? phone;
  final AcceptedOrderCoordinates? coordinates;
  @JsonKey(name: 'location_map')
  final String? locationMap;

  AcceptedOrderBranchInfo({
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

  factory AcceptedOrderBranchInfo.fromJson(Map<String, dynamic> json) =>
      _$AcceptedOrderBranchInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptedOrderBranchInfoToJson(this);
}

@JsonSerializable()
class AcceptedOrderRestaurantInfo {
  @JsonKey(name: '_id')
  final String id;
  final String? logo;
  final String? name;
  final String? phone;

  AcceptedOrderRestaurantInfo({
    required this.id,
    this.logo,
    this.name,
    this.phone,
  });

  factory AcceptedOrderRestaurantInfo.fromJson(Map<String, dynamic> json) =>
      _$AcceptedOrderRestaurantInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptedOrderRestaurantInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AcceptedOrderItem {
  @JsonKey(name: 'item_details')
  final AcceptedOrderItemDetails itemDetails;
  @JsonKey(name: 'size_details')
  final AcceptedOrderSizeDetails sizeDetails;
  @JsonKey(name: 'topping_details')
  final List<AcceptedOrderToppingDetails>? toppingDetails;
  final String? description;
  @JsonKey(name: 'total_price')
  final num totalPrice;
  @JsonKey(name: '_id')
  final String id;

  AcceptedOrderItem({
    required this.itemDetails,
    required this.sizeDetails,
    this.toppingDetails,
    this.description,
    required this.totalPrice,
    required this.id,
  });

  factory AcceptedOrderItem.fromJson(Map<String, dynamic> json) =>
      _$AcceptedOrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptedOrderItemToJson(this);
}

@JsonSerializable()
class AcceptedOrderItemDetails {
  @JsonKey(name: 'item_id')
  final String? itemId;
  final String? name;
  final String? description;
  final String? photo;

  AcceptedOrderItemDetails({
    this.itemId,
    this.name,
    this.description,
    this.photo,
  });

  factory AcceptedOrderItemDetails.fromJson(Map<String, dynamic> json) =>
      _$AcceptedOrderItemDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptedOrderItemDetailsToJson(this);
}

@JsonSerializable()
class AcceptedOrderSizeDetails {
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

  AcceptedOrderSizeDetails({
    required this.sizeId,
    required this.size,
    required this.priceBefore,
    required this.priceAfter,
    required this.offer,
    required this.quantity,
    required this.priceOfQuantity,
  });

  factory AcceptedOrderSizeDetails.fromJson(Map<String, dynamic> json) =>
      _$AcceptedOrderSizeDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptedOrderSizeDetailsToJson(this);
}

@JsonSerializable()
class AcceptedOrderToppingDetails {
  // The response does not have 'topping_id', but has '_id'
  @JsonKey(name: '_id')
  final String id;
  final String topping;
  final num price;
  final int quantity;

  AcceptedOrderToppingDetails({
    required this.id,
    required this.topping,
    required this.price,
    required this.quantity,
  });

  factory AcceptedOrderToppingDetails.fromJson(Map<String, dynamic> json) =>
      _$AcceptedOrderToppingDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptedOrderToppingDetailsToJson(this);
}
