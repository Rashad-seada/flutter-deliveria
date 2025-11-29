// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_cart_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToppingRequest _$ToppingRequestFromJson(Map<String, dynamic> json) =>
    ToppingRequest(topping: json['topping'] as String);

Map<String, dynamic> _$ToppingRequestToJson(ToppingRequest instance) =>
    <String, dynamic>{'topping': instance.topping};

AddToCartRequest _$AddToCartRequestFromJson(Map<String, dynamic> json) =>
    AddToCartRequest(
      restaurantId: json['restaurant_id'] as String,
      itemId: json['item_id'] as String,
      size: json['size'] as String,
      toppings:
          (json['toppings'] as List<dynamic>)
              .map((e) => ToppingRequest.fromJson(e as Map<String, dynamic>))
              .toList(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$AddToCartRequestToJson(AddToCartRequest instance) =>
    <String, dynamic>{
      'restaurant_id': instance.restaurantId,
      'item_id': instance.itemId,
      'size': instance.size,
      'toppings': instance.toppings,
      'description': instance.description,
    };
