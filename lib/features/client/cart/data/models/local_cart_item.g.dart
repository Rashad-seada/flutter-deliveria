// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalCartItem _$LocalCartItemFromJson(Map<String, dynamic> json) =>
    LocalCartItem(
      addRequest:
          AddToCartRequest.fromJson(json['addRequest'] as Map<String, dynamic>),
      itemName: json['itemName'] as String,
      itemImage: json['itemImage'] as String,
      itemPrice: (json['itemPrice'] as num).toDouble(),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      sizeName: json['sizeName'] as String?,
      toppingNames: (json['toppingNames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      restaurantName: json['restaurantName'] as String?,
      restaurantImage: json['restaurantImage'] as String?,
    );

Map<String, dynamic> _$LocalCartItemToJson(LocalCartItem instance) =>
    <String, dynamic>{
      'addRequest': instance.addRequest,
      'itemName': instance.itemName,
      'itemImage': instance.itemImage,
      'itemPrice': instance.itemPrice,
      'quantity': instance.quantity,
      'sizeName': instance.sizeName,
      'toppingNames': instance.toppingNames,
      'restaurantName': instance.restaurantName,
      'restaurantImage': instance.restaurantImage,
    };
