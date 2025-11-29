import 'package:json_annotation/json_annotation.dart';

part 'get_delivery_agent_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetDeliveryAgentResponse {
  final List<AgentModel> agents;

  GetDeliveryAgentResponse({required this.agents});

  factory GetDeliveryAgentResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDeliveryAgentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetDeliveryAgentResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AgentModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String phone;
  @JsonKey(name: 'user_name')
  final String userName;
  final String password;
  final bool ban;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;

  @JsonKey(fromJson: _ordersFromJson, toJson: _ordersToJson)
  final List<OrderModelAgent>? orders;

  AgentModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.userName,
    required this.password,
    required this.ban,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.orders,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) =>
      _$AgentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AgentModelToJson(this);

  static List<OrderModelAgent>? _ordersFromJson(dynamic value) {
    if (value == null) return <OrderModelAgent>[];
    if (value is List) {
      return value
          .where((e) => e != null && e is Map)
          .map((e) {
            try {
              final map =
                  e is Map<String, dynamic>
                      ? e
                      : (e as Map).cast<String, dynamic>();
              return OrderModelAgent.fromJson(map);
            } catch (ex) {
              print('Error parsing order: $ex');
              print('Order data: $e');
              return null;
            }
          })
          .where((e) => e != null)
          .cast<OrderModelAgent>()
          .toList();
    }
    return <OrderModelAgent>[];
  }

  static dynamic _ordersToJson(List<OrderModelAgent>? orders) =>
      orders?.map((e) => e.toJson()).toList();
}

@JsonSerializable(explicitToJson: true)
class OrderModelAgent {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(fromJson: _addressFromJson)
  final AddressModel? address;
  @JsonKey(name: 'user_id', fromJson: _userFromJson)
  final UserModel? user;
  @JsonKey(fromJson: _restaurantOrdersFromJson)
  final List<RestaurantOrderModel> orders;
  @JsonKey(name: 'final_price_without_delivery_cost')
  final num? finalPriceWithoutDeliveryCost;
  @JsonKey(name: 'final_delivery_cost')
  final num? finalDeliveryCost;
  @JsonKey(name: 'final_price')
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

  OrderModelAgent({
    required this.id,
    this.address,
    this.user,
    required this.orders,
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

  factory OrderModelAgent.fromJson(Map<String, dynamic> json) =>
      _$OrderModelAgentFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelAgentToJson(this);

  static AddressModel? _addressFromJson(dynamic value) {
    if (value == null) return null;
    try {
      if (value is Map<String, dynamic>) {
        return AddressModel.fromJson(value);
      }
      if (value is Map) {
        return AddressModel.fromJson(value.cast<String, dynamic>());
      }
    } catch (e) {
      print('Error parsing address: $e');
    }
    return null;
  }

  static UserModel? _userFromJson(dynamic value) {
    if (value == null) return null;
    try {
      if (value is Map<String, dynamic>) {
        return UserModel.fromJson(value);
      }
      if (value is Map) {
        return UserModel.fromJson(value.cast<String, dynamic>());
      }
    } catch (e) {
      print('Error parsing user: $e');
    }
    return null;
  }

  static List<RestaurantOrderModel> _restaurantOrdersFromJson(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value
          .where((e) => e != null && e is Map)
          .map((e) {
            try {
              return e is Map<String, dynamic>
                  ? RestaurantOrderModel.fromJson(e)
                  : RestaurantOrderModel.fromJson(
                    (e as Map).cast<String, dynamic>(),
                  );
            } catch (ex) {
              print('Error parsing restaurant order: $ex');
              return null;
            }
          })
          .where((e) => e != null)
          .cast<RestaurantOrderModel>()
          .toList();
    }
    return [];
  }
}

@JsonSerializable(explicitToJson: true)
class AddressModel {
  @JsonKey(fromJson: _coordinatesFromJson)
  final CoordinatesModel? coordinates;
  @JsonKey(name: 'address_title')
  final String? addressTitle;
  final String? phone;
  final String? details;

  AddressModel({this.coordinates, this.addressTitle, this.phone, this.details});

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  static CoordinatesModel? _coordinatesFromJson(dynamic value) {
    if (value == null) return null;
    try {
      if (value is Map<String, dynamic>) {
        return CoordinatesModel.fromJson(value);
      }
      if (value is Map) {
        return CoordinatesModel.fromJson(value.cast<String, dynamic>());
      }
    } catch (e) {
      print('Error parsing coordinates: $e');
    }
    return null;
  }
}

@JsonSerializable()
class CoordinatesModel {
  @JsonKey(fromJson: _asString, toJson: _toString)
  final String latitude;
  @JsonKey(fromJson: _asString, toJson: _toString)
  final String longitude;

  CoordinatesModel({required this.latitude, required this.longitude});

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesModelToJson(this);

  static String _asString(dynamic value) => value?.toString() ?? '';
  static dynamic _toString(String value) => value;
}

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;

  UserModel({this.id, this.firstName, this.lastName});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RestaurantOrderModel {
  @JsonKey(name: 'restaurant_id', fromJson: _restaurantFromJson)
  final RestaurantModel? restaurant;
  @JsonKey(fromJson: _itemsFromJson)
  final List<ItemModel> items;
  @JsonKey(name: 'price_of_restaurant')
  final num? priceOfRestaurant;
  final String? status;
  @JsonKey(name: 'cancel_me')
  final bool? cancelMe;
  @JsonKey(name: '_id')
  final String? id;

  RestaurantOrderModel({
    this.restaurant,
    required this.items,
    this.priceOfRestaurant,
    this.status,
    this.cancelMe,
    this.id,
  });

  factory RestaurantOrderModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantOrderModelToJson(this);

  static RestaurantModel? _restaurantFromJson(dynamic value) {
    if (value == null) return null;
    try {
      if (value is Map<String, dynamic>) {
        return RestaurantModel.fromJson(value);
      }
      if (value is Map) {
        return RestaurantModel.fromJson(value.cast<String, dynamic>());
      }
    } catch (e) {
      print('Error parsing restaurant: $e');
    }
    return null;
  }

  static List<ItemModel> _itemsFromJson(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value
          .where((e) => e != null && e is Map)
          .map((e) {
            try {
              return e is Map<String, dynamic>
                  ? ItemModel.fromJson(e)
                  : ItemModel.fromJson((e as Map).cast<String, dynamic>());
            } catch (ex) {
              print('Error parsing item: $ex');
              return null;
            }
          })
          .where((e) => e != null)
          .cast<ItemModel>()
          .toList();
    }
    return [];
  }
}

@JsonSerializable(explicitToJson: true)
class RestaurantModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? logo;
  final String? name;
  final String? phone;

  RestaurantModel({this.id, this.logo, this.name, this.phone});

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ItemModel {
  @JsonKey(name: 'item_details', fromJson: _itemDetailsFromJson)
  final ItemDetailsModel? itemDetails;
  @JsonKey(name: 'size_details', fromJson: _sizeDetailsFromJson)
  final SizeDetailsModel? sizeDetails;
  @JsonKey(name: 'topping_details', fromJson: _toppingDetailsFromJson)
  final List<ToppingModel> toppingDetails;
  final num? total_price;
  @JsonKey(name: '_id')
  final String? id;
  final String? description;

  ItemModel({
    this.itemDetails,
    this.sizeDetails,
    required this.toppingDetails,
    this.total_price,
    this.id,
    this.description,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  static ItemDetailsModel? _itemDetailsFromJson(dynamic value) {
    if (value == null) return null;
    try {
      if (value is Map<String, dynamic>) {
        return ItemDetailsModel.fromJson(value);
      }
      if (value is Map) {
        return ItemDetailsModel.fromJson(value.cast<String, dynamic>());
      }
    } catch (e) {
      print('Error parsing item details: $e');
    }
    return null;
  }

  static SizeDetailsModel? _sizeDetailsFromJson(dynamic value) {
    if (value == null) return null;
    try {
      if (value is Map<String, dynamic>) {
        return SizeDetailsModel.fromJson(value);
      }
      if (value is Map) {
        return SizeDetailsModel.fromJson(value.cast<String, dynamic>());
      }
    } catch (e) {
      print('Error parsing size details: $e');
    }
    return null;
  }

  static List<ToppingModel> _toppingDetailsFromJson(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value
          .where((e) => e != null && e is Map)
          .map((e) {
            try {
              return e is Map<String, dynamic>
                  ? ToppingModel.fromJson(e)
                  : ToppingModel.fromJson((e as Map).cast<String, dynamic>());
            } catch (ex) {
              print('Error parsing topping: $ex');
              return null;
            }
          })
          .where((e) => e != null)
          .cast<ToppingModel>()
          .toList();
    }
    return [];
  }
}

@JsonSerializable()
class ItemDetailsModel {
  @JsonKey(name: 'item_id')
  final String? itemId;
  final String? name;
  final String? description;
  final String? photo;

  ItemDetailsModel({this.itemId, this.name, this.description, this.photo});

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
  final num? priceBefore;
  @JsonKey(name: 'price_after')
  final num? priceAfter;
  final num? offer;
  final int? quantity;
  @JsonKey(name: 'price_Of_quantity')
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
class ToppingModel {
  final String? topping;
  final num? price;
  final int? quantity;
  @JsonKey(name: '_id')
  final String? id;

  ToppingModel({this.topping, this.price, this.quantity, this.id});

  factory ToppingModel.fromJson(Map<String, dynamic> json) =>
      _$ToppingModelFromJson(json);

  Map<String, dynamic> toJson() => _$ToppingModelToJson(this);
}
