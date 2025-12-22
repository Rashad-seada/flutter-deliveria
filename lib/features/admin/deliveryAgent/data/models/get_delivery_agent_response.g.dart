// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_delivery_agent_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDeliveryAgentResponse _$GetDeliveryAgentResponseFromJson(
  Map<String, dynamic> json,
) => GetDeliveryAgentResponse(
  agents:
      (json['agents'] as List<dynamic>)
          .map((e) => AgentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$GetDeliveryAgentResponseToJson(
  GetDeliveryAgentResponse instance,
) => <String, dynamic>{
  'agents': instance.agents.map((e) => e.toJson()).toList(),
};

AgentModel _$AgentModelFromJson(Map<String, dynamic> json) => AgentModel(
  id: json['_id'] as String,
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  userName: json['user_name'] as String?,
  password: json['password'] as String?,
  ban: json['ban'] as bool?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  v: (json['__v'] as num?)?.toInt(),
  orders: AgentModel._ordersFromJson(json['orders']),
);

Map<String, dynamic> _$AgentModelToJson(AgentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'user_name': instance.userName,
      'password': instance.password,
      'ban': instance.ban,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
      'orders': AgentModel._ordersToJson(instance.orders),
    };

OrderModelAgent _$OrderModelAgentFromJson(Map<String, dynamic> json) =>
    OrderModelAgent(
      id: json['_id'] as String,
      address: OrderModelAgent._addressFromJson(json['address']),
      user: OrderModelAgent._userFromJson(json['user_id']),
      orders: OrderModelAgent._restaurantOrdersFromJson(json['orders']),
      finalPriceWithoutDeliveryCost:
          json['final_price_without_delivery_cost'] as num?,
      finalDeliveryCost: json['final_delivery_cost'] as num?,
      finalPrice: json['final_price'] as num?,
      deliveryType: json['delivery_type'] as String?,
      paymentType: json['payment_type'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
      deliveryId: json['delivery_id'] as String?,
    );

Map<String, dynamic> _$OrderModelAgentToJson(
  OrderModelAgent instance,
) => <String, dynamic>{
  '_id': instance.id,
  'address': instance.address?.toJson(),
  'user_id': instance.user?.toJson(),
  'orders': instance.orders.map((e) => e.toJson()).toList(),
  'final_price_without_delivery_cost': instance.finalPriceWithoutDeliveryCost,
  'final_delivery_cost': instance.finalDeliveryCost,
  'final_price': instance.finalPrice,
  'delivery_type': instance.deliveryType,
  'payment_type': instance.paymentType,
  'status': instance.status,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  '__v': instance.v,
  'delivery_id': instance.deliveryId,
};

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
  coordinates: AddressModel._coordinatesFromJson(json['coordinates']),
  addressTitle: json['address_title'] as String?,
  phone: json['phone'] as String?,
  details: json['details'] as String?,
);

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates?.toJson(),
      'address_title': instance.addressTitle,
      'phone': instance.phone,
      'details': instance.details,
    };

CoordinatesModel _$CoordinatesModelFromJson(Map<String, dynamic> json) =>
    CoordinatesModel(
      latitude: CoordinatesModel._asString(json['latitude']),
      longitude: CoordinatesModel._asString(json['longitude']),
    );

Map<String, dynamic> _$CoordinatesModelToJson(CoordinatesModel instance) =>
    <String, dynamic>{
      'latitude': CoordinatesModel._toString(instance.latitude),
      'longitude': CoordinatesModel._toString(instance.longitude),
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['_id'] as String?,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  '_id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
};

RestaurantOrderModel _$RestaurantOrderModelFromJson(
  Map<String, dynamic> json,
) => RestaurantOrderModel(
  restaurant: RestaurantOrderModel._restaurantFromJson(json['restaurant_id']),
  items: RestaurantOrderModel._itemsFromJson(json['items']),
  priceOfRestaurant: json['price_of_restaurant'] as num?,
  status: json['status'] as String?,
  cancelMe: json['cancel_me'] as bool?,
  id: json['_id'] as String?,
);

Map<String, dynamic> _$RestaurantOrderModelToJson(
  RestaurantOrderModel instance,
) => <String, dynamic>{
  'restaurant_id': instance.restaurant?.toJson(),
  'items': instance.items.map((e) => e.toJson()).toList(),
  'price_of_restaurant': instance.priceOfRestaurant,
  'status': instance.status,
  'cancel_me': instance.cancelMe,
  '_id': instance.id,
};

RestaurantModel _$RestaurantModelFromJson(Map<String, dynamic> json) =>
    RestaurantModel(
      id: json['_id'] as String?,
      logo: json['logo'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$RestaurantModelToJson(RestaurantModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'logo': instance.logo,
      'name': instance.name,
      'phone': instance.phone,
    };

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
  itemDetails: ItemModel._itemDetailsFromJson(json['item_details']),
  sizeDetails: ItemModel._sizeDetailsFromJson(json['size_details']),
  toppingDetails: ItemModel._toppingDetailsFromJson(json['topping_details']),
  total_price: json['total_price'] as num?,
  id: json['_id'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
  'item_details': instance.itemDetails?.toJson(),
  'size_details': instance.sizeDetails?.toJson(),
  'topping_details': instance.toppingDetails.map((e) => e.toJson()).toList(),
  'total_price': instance.total_price,
  '_id': instance.id,
  'description': instance.description,
};

ItemDetailsModel _$ItemDetailsModelFromJson(Map<String, dynamic> json) =>
    ItemDetailsModel(
      itemId: json['item_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$ItemDetailsModelToJson(ItemDetailsModel instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'name': instance.name,
      'description': instance.description,
      'photo': instance.photo,
    };

SizeDetailsModel _$SizeDetailsModelFromJson(Map<String, dynamic> json) =>
    SizeDetailsModel(
      sizeId: json['size_id'] as String?,
      size: json['size'] as String?,
      priceBefore: json['price_before'] as num?,
      priceAfter: json['price_after'] as num?,
      offer: json['offer'] as num?,
      quantity: (json['quantity'] as num?)?.toInt(),
      priceOfQuantity: json['price_Of_quantity'] as num?,
    );

Map<String, dynamic> _$SizeDetailsModelToJson(SizeDetailsModel instance) =>
    <String, dynamic>{
      'size_id': instance.sizeId,
      'size': instance.size,
      'price_before': instance.priceBefore,
      'price_after': instance.priceAfter,
      'offer': instance.offer,
      'quantity': instance.quantity,
      'price_Of_quantity': instance.priceOfQuantity,
    };

ToppingModel _$ToppingModelFromJson(Map<String, dynamic> json) => ToppingModel(
  topping: json['topping'] as String?,
  price: json['price'] as num?,
  quantity: (json['quantity'] as num?)?.toInt(),
  id: json['_id'] as String?,
);

Map<String, dynamic> _$ToppingModelToJson(ToppingModel instance) =>
    <String, dynamic>{
      'topping': instance.topping,
      'price': instance.price,
      'quantity': instance.quantity,
      '_id': instance.id,
    };
