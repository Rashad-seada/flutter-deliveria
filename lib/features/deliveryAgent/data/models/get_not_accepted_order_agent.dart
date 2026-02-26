import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_not_accepted_order_agent.g.dart';

@JsonSerializable(explicitToJson: true)
class GetNotAcceptedOrderAgentResponse {
  final List<AgentOrder> orders;

  GetNotAcceptedOrderAgentResponse({required this.orders});

  factory GetNotAcceptedOrderAgentResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$GetNotAcceptedOrderAgentResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetNotAcceptedOrderAgentResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AgentOrder {
  final AgentOrderAddress address;
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'user_id')
  final AgentOrderUser user;
  final List<AgentOrderRestaurant> orders;
  @JsonKey(name: 'final_price_without_delivery_cost', fromJson: _safeNumFromJson)
  final num finalPriceWithoutDeliveryCost;
  @JsonKey(name: 'final_delivery_cost', fromJson: _safeNumFromJson)
  final num finalDeliveryCost;
  @JsonKey(name: 'final_price', fromJson: _safeNumFromJson)
  final num finalPrice;
  @JsonKey(name: 'delivery_type')
  final String deliveryType;
  @JsonKey(name: 'payment_type')
  final String paymentType;
  final String status;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v', fromJson: _safeIntFromJson)
  final int v;

  /// Add orderId field, not affecting serializable body.
  @JsonKey(name: 'order_id')
  final int? orderId;
  @JsonKey(name: 'acceptance_status')
  final AcceptanceStatus? acceptanceStatus;

  AgentOrder({
    required this.address,
    required this.id,
    required this.user,
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
    this.orderId, // optional for "order_id"
    this.acceptanceStatus,
  });

  factory AgentOrder.fromJson(Map<String, dynamic> json) =>
      _$AgentOrderFromJson(json);

  Map<String, dynamic> toJson() => _$AgentOrderToJson(this);
}

@JsonSerializable()
class AcceptanceStatus {
  @JsonKey(name: 'accepted_by_delivery_agents')
  final List<String>? acceptedByDeliveryAgents;

  AcceptanceStatus({this.acceptedByDeliveryAgents});

  factory AcceptanceStatus.fromJson(Map<String, dynamic> json) =>
      _$AcceptanceStatusFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptanceStatusToJson(this);
}

/// Robust num parsing to avoid type errors from backend
num _safeNumFromJson(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value;
  if (value is String) {
    final parsed = num.tryParse(value);
    if (parsed != null) return parsed;
    // Try to clean up string (e.g. remove commas, spaces)
    final cleaned = value.replaceAll(RegExp(r'[^\d\.\-]'), '');
    return num.tryParse(cleaned) ?? 0;
  }
  // If value is bool, treat true as 1, false as 0
  if (value is bool) return value ? 1 : 0;
  // If value is Map or List, cannot convert
  return 0;
}

/// Safe int parsing to avoid type errors from backend
int _safeIntFromJson(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) {
    final parsed = int.tryParse(value);
    if (parsed != null) return parsed;
    // Try to clean up string (e.g. remove commas, spaces)
    final cleaned = value.replaceAll(RegExp(r'[^\d\-]'), '');
    return int.tryParse(cleaned) ?? 0;
  }
  // If value is bool, treat true as 1, false as 0
  if (value is bool) return value ? 1 : 0;
  return 0;
}

/// Safe double parsing for coordinates
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
class AgentOrderAddress {
  final AgentOrderCoordinates coordinates;
  @JsonKey(name: 'address_title')
  final String addressTitle;
  final String phone;
  final String details;

  AgentOrderAddress({
    required this.coordinates,
    required this.addressTitle,
    required this.phone,
    required this.details,
  });

  factory AgentOrderAddress.fromJson(Map<String, dynamic> json) =>
      _$AgentOrderAddressFromJson(json);

  Map<String, dynamic> toJson() => _$AgentOrderAddressToJson(this);
}

@JsonSerializable()
class AgentOrderCoordinates {
  @JsonKey(fromJson: _safeDoubleFromJson)
  final double latitude;
  @JsonKey(fromJson: _safeDoubleFromJson)
  final double longitude;

  AgentOrderCoordinates({required this.latitude, required this.longitude});

  factory AgentOrderCoordinates.fromJson(Map<String, dynamic> json) =>
      _$AgentOrderCoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$AgentOrderCoordinatesToJson(this);
}

@JsonSerializable()
class AgentOrderUser {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;

  AgentOrderUser({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory AgentOrderUser.fromJson(Map<String, dynamic> json) =>
      _$AgentOrderUserFromJson(json);

  Map<String, dynamic> toJson() => _$AgentOrderUserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AgentOrderRestaurant {
  @JsonKey(name: 'restaurant_id')
  final AgentOrderRestaurantInfo restaurantId;
  @JsonKey(name: 'branch_id', fromJson: _branchInfoFromJson)
  final AgentOrderBranchInfo? branch;
  final List<AgentOrderItem> items;
  @JsonKey(name: 'price_of_restaurant', fromJson: _safeNumFromJson)
  final num priceOfRestaurant;
  final String status;
  @JsonKey(name: 'cancel_me')
  final bool? cancelMe;
  @JsonKey(name: '_id')
  final String id;

  AgentOrderRestaurant({
    required this.restaurantId,
    this.branch,
    required this.items,
    required this.priceOfRestaurant,
    required this.status,
    this.cancelMe,
    required this.id,
  });

  factory AgentOrderRestaurant.fromJson(Map<String, dynamic> json) =>
      _$AgentOrderRestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$AgentOrderRestaurantToJson(this);
}

/// Safely parse branch_id which can be a String (old) or Map (new)
AgentOrderBranchInfo? _branchInfoFromJson(dynamic json) {
  if (json == null) return null;
  if (json is Map<String, dynamic>) {
    return AgentOrderBranchInfo.fromJson(json);
  }
  // Legacy: branch_id was just a string ID
  if (json is String) {
    return AgentOrderBranchInfo(id: json);
  }
  return null;
}

@JsonSerializable(explicitToJson: true)
class AgentOrderBranchInfo {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  @JsonKey(name: 'branch_name')
  final String? branchName;
  final String? address;
  final String? phone;
  final AgentOrderCoordinates? coordinates;
  @JsonKey(name: 'location_map')
  final String? locationMap;

  AgentOrderBranchInfo({
    this.id,
    this.name,
    this.branchName,
    this.address,
    this.phone,
    this.coordinates,
    this.locationMap,
  });

  /// Display name helper: prefer branchName, fallback to name
  String get displayName => branchName ?? name ?? '';

  factory AgentOrderBranchInfo.fromJson(Map<String, dynamic> json) =>
      _$AgentOrderBranchInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AgentOrderBranchInfoToJson(this);
}

@JsonSerializable()
class AgentOrderRestaurantInfo {
  @JsonKey(name: '_id')
  final String id;
  final String? logo;
  final String? name;
  final String? phone;

  AgentOrderRestaurantInfo({
    required this.id,
    this.logo,
    this.name,
    this.phone,
  });

  factory AgentOrderRestaurantInfo.fromJson(Map<String, dynamic> json) =>
      _$AgentOrderRestaurantInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AgentOrderRestaurantInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AgentOrderItem {
  @JsonKey(name: 'item_details')
  final AgentOrderItemDetails itemDetails;
  @JsonKey(name: 'size_details')
  final AgentOrderSizeDetails sizeDetails;
  // Fix: Accept both List and Map for topping_details
  @JsonKey(
    name: 'topping_details',
    fromJson: _toppingDetailsFromJson,
    toJson: _toppingDetailsToJson,
  )
  final List<AgentOrderToppingDetails>? toppingDetails;
  final String? description;
  @JsonKey(name: 'total_price', fromJson: _safeNumFromJson)
  final num totalPrice;
  @JsonKey(name: '_id')
  final String id;

  AgentOrderItem({
    required this.itemDetails,
    required this.sizeDetails,
    this.toppingDetails,
    this.description,
    required this.totalPrice,
    required this.id,
  });

  factory AgentOrderItem.fromJson(Map<String, dynamic> json) =>
      _$AgentOrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$AgentOrderItemToJson(this);
}

// Custom fromJson/toJson for topping_details to handle both List and Map/null
List<AgentOrderToppingDetails>? _toppingDetailsFromJson(dynamic json) {
  if (json == null) return null;
  if (json is List) {
    return json
        .where((e) => e != null)
        .map((e) => AgentOrderToppingDetails.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
  if (json is Map<String, dynamic>) {
    // Sometimes backend may send a single object instead of a list
    return [AgentOrderToppingDetails.fromJson(json)];
  }
  return null;
}

dynamic _toppingDetailsToJson(List<AgentOrderToppingDetails>? toppings) {
  if (toppings == null) return null;
  return toppings.map((e) => e.toJson()).toList();
}

@JsonSerializable()
class AgentOrderItemDetails {
  @JsonKey(name: 'item_id')
  final String itemId;
  final String name;
  final dynamic description;
  final String photo;

  AgentOrderItemDetails({
    required this.itemId,
    required this.name,
    required this.description,
    required this.photo,
  });

  factory AgentOrderItemDetails.fromJson(Map<String, dynamic> json) =>
      _$AgentOrderItemDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AgentOrderItemDetailsToJson(this);
}

@JsonSerializable()
class AgentOrderSizeDetails {
  @JsonKey(name: 'size_id')
  final String sizeId;
  final String size;
  @JsonKey(name: 'price_before', fromJson: _safeNumFromJson)
  final num priceBefore;
  @JsonKey(name: 'price_after', fromJson: _safeNumFromJson)
  final num priceAfter;
  @JsonKey(fromJson: _safeNumFromJson)
  final num offer;
  @JsonKey(fromJson: _safeIntFromJson)
  final int quantity;
  @JsonKey(name: 'price_Of_quantity', fromJson: _safeNumFromJson)
  final num priceOfQuantity;

  AgentOrderSizeDetails({
    required this.sizeId,
    required this.size,
    required this.priceBefore,
    required this.priceAfter,
    required this.offer,
    required this.quantity,
    required this.priceOfQuantity,
  });

  factory AgentOrderSizeDetails.fromJson(Map<String, dynamic> json) =>
      _$AgentOrderSizeDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AgentOrderSizeDetailsToJson(this);
}

@JsonSerializable()
class AgentOrderToppingDetails {
  @JsonKey(name: 'topping_id')
  final String? toppingId;
  final String? topping;
  @JsonKey(fromJson: _safeNumFromJson)
  final num? price;
  @JsonKey(fromJson: _safeIntFromJson)
  final int? quantity;
  @JsonKey(name: 'price_Of_quantity', fromJson: _safeNumFromJson)
  final num? priceOfQuantity;
  @JsonKey(name: '_id')
  final String? id;

  AgentOrderToppingDetails({
    this.toppingId,
    this.topping,
    this.price,
    this.quantity,
    this.priceOfQuantity,
    this.id,
  });

  factory AgentOrderToppingDetails.fromJson(Map<String, dynamic> json) =>
      _$AgentOrderToppingDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AgentOrderToppingDetailsToJson(this);
}
