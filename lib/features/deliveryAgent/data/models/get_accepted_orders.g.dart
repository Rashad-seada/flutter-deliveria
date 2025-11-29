// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_accepted_orders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAcceptedOrdersResponse _$GetAcceptedOrdersResponseFromJson(
  Map<String, dynamic> json,
) => GetAcceptedOrdersResponse(
  orders:
      (json['orders'] as List<dynamic>)
          .map((e) => AcceptedOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$GetAcceptedOrdersResponseToJson(
  GetAcceptedOrdersResponse instance,
) => <String, dynamic>{
  'orders': instance.orders.map((e) => e.toJson()).toList(),
};

AcceptedOrder _$AcceptedOrderFromJson(Map<String, dynamic> json) =>
    AcceptedOrder(
      address: AcceptedOrderAddress.fromJson(
        json['address'] as Map<String, dynamic>,
      ),
      id: json['_id'] as String,
      userId: AcceptedOrderUser.fromJson(
        json['user_id'] as Map<String, dynamic>,
      ),
      orders:
          (json['orders'] as List<dynamic>)
              .map(
                (e) => AcceptedOrderRestaurantOrder.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
      finalPriceWithoutDeliveryCost:
          json['final_price_without_delivery_cost'] as num,
      finalDeliveryCost: json['final_delivery_cost'] as num,
      finalPrice: json['final_price'] as num,
      deliveryType: json['delivery_type'] as String,
      paymentType: json['payment_type'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: (json['__v'] as num).toInt(),
      deliveryId: json['delivery_id'] as String,
      orderId: json['order_id'] as num?,
    );

Map<String, dynamic> _$AcceptedOrderToJson(
  AcceptedOrder instance,
) => <String, dynamic>{
  'address': instance.address.toJson(),
  '_id': instance.id,
  'user_id': instance.userId.toJson(),
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
  'order_id': instance.orderId,
};

AcceptedOrderAddress _$AcceptedOrderAddressFromJson(
  Map<String, dynamic> json,
) => AcceptedOrderAddress(
  coordinates: AcceptedOrderCoordinates.fromJson(
    json['coordinates'] as Map<String, dynamic>,
  ),
  addressTitle: json['address_title'] as String,
  phone: json['phone'] as String,
  details: json['details'] as String,
);

Map<String, dynamic> _$AcceptedOrderAddressToJson(
  AcceptedOrderAddress instance,
) => <String, dynamic>{
  'coordinates': instance.coordinates,
  'address_title': instance.addressTitle,
  'phone': instance.phone,
  'details': instance.details,
};

AcceptedOrderCoordinates _$AcceptedOrderCoordinatesFromJson(
  Map<String, dynamic> json,
) => AcceptedOrderCoordinates(
  latitude: _safeDoubleFromJson(json['latitude']),
  longitude: _safeDoubleFromJson(json['longitude']),
);

Map<String, dynamic> _$AcceptedOrderCoordinatesToJson(
  AcceptedOrderCoordinates instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};

AcceptedOrderUser _$AcceptedOrderUserFromJson(Map<String, dynamic> json) =>
    AcceptedOrderUser(
      id: json['_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
    );

Map<String, dynamic> _$AcceptedOrderUserToJson(AcceptedOrderUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
    };

AcceptedOrderRestaurantOrder _$AcceptedOrderRestaurantOrderFromJson(
  Map<String, dynamic> json,
) => AcceptedOrderRestaurantOrder(
  restaurantId: AcceptedOrderRestaurantInfo.fromJson(
    json['restaurant_id'] as Map<String, dynamic>,
  ),
  items:
      (json['items'] as List<dynamic>)
          .map((e) => AcceptedOrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
  priceOfRestaurant: json['price_of_restaurant'] as num,
  id: json['_id'] as String,
  status: json['status'] as String?,
  cancelMe: json['cancel_me'] as bool?,
);

Map<String, dynamic> _$AcceptedOrderRestaurantOrderToJson(
  AcceptedOrderRestaurantOrder instance,
) => <String, dynamic>{
  'restaurant_id': instance.restaurantId.toJson(),
  'items': instance.items.map((e) => e.toJson()).toList(),
  'price_of_restaurant': instance.priceOfRestaurant,
  '_id': instance.id,
  'status': instance.status,
  'cancel_me': instance.cancelMe,
};

AcceptedOrderRestaurantInfo _$AcceptedOrderRestaurantInfoFromJson(
  Map<String, dynamic> json,
) => AcceptedOrderRestaurantInfo(
  id: json['_id'] as String,
  logo: json['logo'] as String?,
  name: json['name'] as String?,
  phone: json['phone'] as String?,
);

Map<String, dynamic> _$AcceptedOrderRestaurantInfoToJson(
  AcceptedOrderRestaurantInfo instance,
) => <String, dynamic>{
  '_id': instance.id,
  'logo': instance.logo,
  'name': instance.name,
  'phone': instance.phone,
};

AcceptedOrderItem _$AcceptedOrderItemFromJson(Map<String, dynamic> json) =>
    AcceptedOrderItem(
      itemDetails: AcceptedOrderItemDetails.fromJson(
        json['item_details'] as Map<String, dynamic>,
      ),
      sizeDetails: AcceptedOrderSizeDetails.fromJson(
        json['size_details'] as Map<String, dynamic>,
      ),
      toppingDetails:
          (json['topping_details'] as List<dynamic>?)
              ?.map(
                (e) => AcceptedOrderToppingDetails.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
      description: json['description'] as String?,
      totalPrice: json['total_price'] as num,
      id: json['_id'] as String,
    );

Map<String, dynamic> _$AcceptedOrderItemToJson(
  AcceptedOrderItem instance,
) => <String, dynamic>{
  'item_details': instance.itemDetails.toJson(),
  'size_details': instance.sizeDetails.toJson(),
  'topping_details': instance.toppingDetails?.map((e) => e.toJson()).toList(),
  'description': instance.description,
  'total_price': instance.totalPrice,
  '_id': instance.id,
};

AcceptedOrderItemDetails _$AcceptedOrderItemDetailsFromJson(
  Map<String, dynamic> json,
) => AcceptedOrderItemDetails(
  itemId: json['item_id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  photo: json['photo'] as String,
);

Map<String, dynamic> _$AcceptedOrderItemDetailsToJson(
  AcceptedOrderItemDetails instance,
) => <String, dynamic>{
  'item_id': instance.itemId,
  'name': instance.name,
  'description': instance.description,
  'photo': instance.photo,
};

AcceptedOrderSizeDetails _$AcceptedOrderSizeDetailsFromJson(
  Map<String, dynamic> json,
) => AcceptedOrderSizeDetails(
  sizeId: json['size_id'] as String,
  size: json['size'] as String,
  priceBefore: json['price_before'] as num,
  priceAfter: json['price_after'] as num,
  offer: json['offer'] as num,
  quantity: (json['quantity'] as num).toInt(),
  priceOfQuantity: json['price_Of_quantity'] as num,
);

Map<String, dynamic> _$AcceptedOrderSizeDetailsToJson(
  AcceptedOrderSizeDetails instance,
) => <String, dynamic>{
  'size_id': instance.sizeId,
  'size': instance.size,
  'price_before': instance.priceBefore,
  'price_after': instance.priceAfter,
  'offer': instance.offer,
  'quantity': instance.quantity,
  'price_Of_quantity': instance.priceOfQuantity,
};

AcceptedOrderToppingDetails _$AcceptedOrderToppingDetailsFromJson(
  Map<String, dynamic> json,
) => AcceptedOrderToppingDetails(
  id: json['_id'] as String,
  topping: json['topping'] as String,
  price: json['price'] as num,
  quantity: (json['quantity'] as num).toInt(),
);

Map<String, dynamic> _$AcceptedOrderToppingDetailsToJson(
  AcceptedOrderToppingDetails instance,
) => <String, dynamic>{
  '_id': instance.id,
  'topping': instance.topping,
  'price': instance.price,
  'quantity': instance.quantity,
};
