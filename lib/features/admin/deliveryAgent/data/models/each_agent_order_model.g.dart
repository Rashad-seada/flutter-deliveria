// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'each_agent_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EachAgentOrderResponse _$EachAgentOrderResponseFromJson(
  Map<String, dynamic> json,
) => EachAgentOrderResponse(
  orders:
      (json['orders'] as List<dynamic>)
          .map((e) => EachAgentOrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$EachAgentOrderResponseToJson(
  EachAgentOrderResponse instance,
) => <String, dynamic>{
  'orders': instance.orders.map((e) => e.toJson()).toList(),
};

EachAgentOrderModel _$EachAgentOrderModelFromJson(Map<String, dynamic> json) =>
    EachAgentOrderModel(
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      id: json['_id'] as String,
      userId: UserModel.fromJson(json['user_id'] as Map<String, dynamic>),
      orders:
          (json['orders'] as List<dynamic>)
              .map((e) => EachOrderModel.fromJson(e as Map<String, dynamic>))
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
    );

Map<String, dynamic> _$EachAgentOrderModelToJson(
  EachAgentOrderModel instance,
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
};

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
  coordinates: CoordinatesModel.fromJson(
    json['coordinates'] as Map<String, dynamic>,
  ),
  addressTitle: json['address_title'] as String,
  phone: json['phone'] as String,
  details: json['details'] as String,
);

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates.toJson(),
      'address_title': instance.addressTitle,
      'phone': instance.phone,
      'details': instance.details,
    };

CoordinatesModel _$CoordinatesModelFromJson(Map<String, dynamic> json) =>
    CoordinatesModel(
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
    );

Map<String, dynamic> _$CoordinatesModelToJson(CoordinatesModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['_id'] as String,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  '_id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
};

EachOrderModel _$EachOrderModelFromJson(Map<String, dynamic> json) =>
    EachOrderModel(
      restaurantId:
          json['restaurant_id'] == null
              ? null
              : RestaurantModel.fromJson(
                json['restaurant_id'] as Map<String, dynamic>,
              ),
      items:
          (json['items'] as List<dynamic>)
              .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      priceOfRestaurant: json['price_of_restaurant'] as num,
      status: json['status'] as String,
      cancelMe: json['cancel_me'] as bool,
      id: json['_id'] as String,
    );

Map<String, dynamic> _$EachOrderModelToJson(EachOrderModel instance) =>
    <String, dynamic>{
      'restaurant_id': instance.restaurantId?.toJson(),
      'items': instance.items.map((e) => e.toJson()).toList(),
      'price_of_restaurant': instance.priceOfRestaurant,
      'status': instance.status,
      'cancel_me': instance.cancelMe,
      '_id': instance.id,
    };

RestaurantModel _$RestaurantModelFromJson(Map<String, dynamic> json) =>
    RestaurantModel(
      id: json['_id'] as String,
      logo: json['logo'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$RestaurantModelToJson(RestaurantModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'logo': instance.logo,
      'name': instance.name,
      'phone': instance.phone,
    };

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      itemDetails: ItemDetailsModel.fromJson(
        json['item_details'] as Map<String, dynamic>,
      ),
      sizeDetails: SizeDetailsModel.fromJson(
        json['size_details'] as Map<String, dynamic>,
      ),
      toppingDetails:
          (json['topping_details'] as List<dynamic>)
              .map(
                (e) => ToppingDetailsModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      description: json['description'] as String?,
      totalPrice: json['total_price'] as num,
      id: json['_id'] as String,
    );

Map<String, dynamic> _$OrderItemModelToJson(
  OrderItemModel instance,
) => <String, dynamic>{
  'item_details': instance.itemDetails.toJson(),
  'size_details': instance.sizeDetails.toJson(),
  'topping_details': instance.toppingDetails.map((e) => e.toJson()).toList(),
  'description': instance.description,
  'total_price': instance.totalPrice,
  '_id': instance.id,
};

ItemDetailsModel _$ItemDetailsModelFromJson(Map<String, dynamic> json) =>
    ItemDetailsModel(
      itemId: json['item_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      photo: json['photo'] as String,
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
      sizeId: json['size_id'] as String,
      size: json['size'] as String,
      priceBefore: json['price_before'] as num,
      priceAfter: json['price_after'] as num,
      offer: json['offer'] as num,
      quantity: (json['quantity'] as num).toInt(),
      priceOfQuantity: json['price_Of_quantity'] as num,
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

ToppingDetailsModel _$ToppingDetailsModelFromJson(Map<String, dynamic> json) =>
    ToppingDetailsModel(
      topping: json['topping'] as String,
      price: json['price'] as num,
      quantity: (json['quantity'] as num).toInt(),
      id: json['_id'] as String,
    );

Map<String, dynamic> _$ToppingDetailsModelToJson(
  ToppingDetailsModel instance,
) => <String, dynamic>{
  'topping': instance.topping,
  'price': instance.price,
  'quantity': instance.quantity,
  '_id': instance.id,
};
