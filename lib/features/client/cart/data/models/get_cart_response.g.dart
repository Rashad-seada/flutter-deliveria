// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCartResponse _$GetCartResponseFromJson(Map<String, dynamic> json) =>
    GetCartResponse(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : CartData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCartResponseToJson(GetCartResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(),
    };

CartData _$CartDataFromJson(Map<String, dynamic> json) => CartData(
      id: json['_id'] as String?,
      user_id: json['user_id'] as String?,
      carts: (json['carts'] as List<dynamic>?)
          ?.map((e) => Cart.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
      final_price_without_delivery_cost:
          json['final_price_without_delivery_cost'] as num?,
      final_delivery_cost: json['final_delivery_cost'] as num?,
      final_price: json['final_price'] as num?,
    );

Map<String, dynamic> _$CartDataToJson(CartData instance) => <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.user_id,
      'carts': instance.carts?.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
      'final_price_without_delivery_cost':
          instance.final_price_without_delivery_cost,
      'final_delivery_cost': instance.final_delivery_cost,
      'final_price': instance.final_price,
    };

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      restaurant_details: json['restaurant_details'] == null
          ? null
          : RestaurantDetails.fromJson(
              json['restaurant_details'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      price_of_restaurant: json['price_of_restaurant'] as num?,
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'restaurant_details': instance.restaurant_details?.toJson(),
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'price_of_restaurant': instance.price_of_restaurant,
    };

RestaurantDetails _$RestaurantDetailsFromJson(Map<String, dynamic> json) =>
    RestaurantDetails(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      delivery_cost: json['delivery_cost'] as num?,
    );

Map<String, dynamic> _$RestaurantDetailsToJson(RestaurantDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'delivery_cost': instance.delivery_cost,
    };

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      item_details: json['item_details'] == null
          ? null
          : ItemDetails.fromJson(json['item_details'] as Map<String, dynamic>),
      size_details: json['size_details'] == null
          ? null
          : SizeDetails.fromJson(json['size_details'] as Map<String, dynamic>),
      topping_details: (json['topping_details'] as List<dynamic>?)
              ?.map((e) => ToppingDetails.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      description: json['description'] as String?,
      total_price: json['total_price'] as num?,
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'item_details': instance.item_details?.toJson(),
      'size_details': instance.size_details?.toJson(),
      'topping_details':
          instance.topping_details?.map((e) => e.toJson()).toList(),
      'description': instance.description,
      'total_price': instance.total_price,
    };

ItemDetails _$ItemDetailsFromJson(Map<String, dynamic> json) => ItemDetails(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$ItemDetailsToJson(ItemDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'photo': instance.photo,
    };

SizeDetails _$SizeDetailsFromJson(Map<String, dynamic> json) => SizeDetails(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      price_before: json['price_before'] as num?,
      price_after: json['price_after'] as num?,
      quantity: (json['quantity'] as num?)?.toInt(),
      price_of_quantity: json['price_of_quantity'] as num?,
    );

Map<String, dynamic> _$SizeDetailsToJson(SizeDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'price_before': instance.price_before,
      'price_after': instance.price_after,
      'quantity': instance.quantity,
      'price_of_quantity': instance.price_of_quantity,
    };

ToppingDetails _$ToppingDetailsFromJson(Map<String, dynamic> json) =>
    ToppingDetails(
      id: json['_id'] as String?,
      topping: json['topping'] as String?,
      price: json['price'] as num?,
      quantity: (json['quantity'] as num?)?.toInt(),
      price_of_quantity: json['price_of_quantity'] as num?,
    );

Map<String, dynamic> _$ToppingDetailsToJson(ToppingDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'topping': instance.topping,
      'price': instance.price,
      'quantity': instance.quantity,
      'price_of_quantity': instance.price_of_quantity,
    };
