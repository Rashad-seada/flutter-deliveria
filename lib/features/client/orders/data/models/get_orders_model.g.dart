// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_orders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOrdersModel _$GetOrdersModelFromJson(Map<String, dynamic> json) =>
    GetOrdersModel(
      orders:
          (json['orders'] as List<dynamic>?)
              ?.map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$GetOrdersModelToJson(GetOrdersModel instance) =>
    <String, dynamic>{
      'orders': instance.orders?.map((e) => e.toJson()).toList(),
    };

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  address:
      json['address'] == null
          ? null
          : OrderAddress.fromJson(json['address'] as Map<String, dynamic>),
  id: json['_id'] as String?,
  user_id: json['user_id'] as String?,
  orders:
      (json['orders'] as List<dynamic>?)
          ?.map((e) => RestaurantOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
  final_price_without_delivery_cost:
      json['final_price_without_delivery_cost'] as num?,
  final_delivery_cost: json['final_delivery_cost'] as num?,
  final_price: json['final_price'] as num?,
  delivery_type: json['delivery_type'] as String?,
  delivery_id: json['delivery_id'] as String?,
  payment_type: json['payment_type'] as String?,
  status: json['status'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  v: (json['__v'] as num?)?.toInt(),
  orderId: (json['order_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'address': instance.address?.toJson(),
      '_id': instance.id,
      'user_id': instance.user_id,
      'orders': instance.orders?.map((e) => e.toJson()).toList(),
      'final_price_without_delivery_cost':
          instance.final_price_without_delivery_cost,
      'final_delivery_cost': instance.final_delivery_cost,
      'final_price': instance.final_price,
      'delivery_type': instance.delivery_type,
      'delivery_id': instance.delivery_id,
      'payment_type': instance.payment_type,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
      'order_id': instance.orderId,
    };

OrderAddress _$OrderAddressFromJson(Map<String, dynamic> json) => OrderAddress(
  coordinates:
      json['coordinates'] == null
          ? null
          : OrderCoordinates.fromJson(
            json['coordinates'] as Map<String, dynamic>,
          ),
  address_title: json['address_title'] as String?,
  phone: json['phone'] as String?,
  details: json['details'] as String?,
);

Map<String, dynamic> _$OrderAddressToJson(OrderAddress instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates?.toJson(),
      'address_title': instance.address_title,
      'phone': instance.phone,
      'details': instance.details,
    };

OrderCoordinates _$OrderCoordinatesFromJson(Map<String, dynamic> json) =>
    OrderCoordinates(
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
    );

Map<String, dynamic> _$OrderCoordinatesToJson(OrderCoordinates instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

RestaurantOrder _$RestaurantOrderFromJson(Map<String, dynamic> json) =>
    RestaurantOrder(
      restaurant_id: json['restaurant_id'] as String?,
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
              .toList(),
      price_of_restaurant: json['price_of_restaurant'] as num?,
      status: json['status'] as String?,
      cancel_me: json['cancel_me'] as bool?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$RestaurantOrderToJson(RestaurantOrder instance) =>
    <String, dynamic>{
      'restaurant_id': instance.restaurant_id,
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'price_of_restaurant': instance.price_of_restaurant,
      'status': instance.status,
      'cancel_me': instance.cancel_me,
      '_id': instance.id,
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
  item_details:
      json['item_details'] == null
          ? null
          : OrderItemDetails.fromJson(
            json['item_details'] as Map<String, dynamic>,
          ),
  size_details:
      json['size_details'] == null
          ? null
          : OrderSizeDetails.fromJson(
            json['size_details'] as Map<String, dynamic>,
          ),
  topping_details:
      (json['topping_details'] as List<dynamic>?)
          ?.map((e) => OrderToppingDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
  total_price: json['total_price'] as num?,
  id: json['_id'] as String?,
);

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
  'item_details': instance.item_details?.toJson(),
  'size_details': instance.size_details?.toJson(),
  'topping_details': instance.topping_details?.map((e) => e.toJson()).toList(),
  'total_price': instance.total_price,
  '_id': instance.id,
};

OrderItemDetails _$OrderItemDetailsFromJson(Map<String, dynamic> json) =>
    OrderItemDetails(
      item_id: json['item_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$OrderItemDetailsToJson(OrderItemDetails instance) =>
    <String, dynamic>{
      'item_id': instance.item_id,
      'name': instance.name,
      'description': instance.description,
      'photo': instance.photo,
    };

OrderSizeDetails _$OrderSizeDetailsFromJson(Map<String, dynamic> json) =>
    OrderSizeDetails(
      size_id: json['size_id'] as String?,
      size: json['size'] as String?,
      price_before: json['price_before'] as num?,
      price_after: json['price_after'] as num?,
      offer: json['offer'] as num?,
      quantity: (json['quantity'] as num?)?.toInt(),
      priceOfQuantity: json['price_Of_quantity'] as num?,
    );

Map<String, dynamic> _$OrderSizeDetailsToJson(OrderSizeDetails instance) =>
    <String, dynamic>{
      'size_id': instance.size_id,
      'size': instance.size,
      'price_before': instance.price_before,
      'price_after': instance.price_after,
      'offer': instance.offer,
      'quantity': instance.quantity,
      'price_Of_quantity': instance.priceOfQuantity,
    };

OrderToppingDetails _$OrderToppingDetailsFromJson(Map<String, dynamic> json) =>
    OrderToppingDetails(
      topping: json['topping'] as String?,
      price: json['price'] as num?,
      quantity: (json['quantity'] as num?)?.toInt(),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$OrderToppingDetailsToJson(
  OrderToppingDetails instance,
) => <String, dynamic>{
  'topping': instance.topping,
  'price': instance.price,
  'quantity': instance.quantity,
  '_id': instance.id,
};
