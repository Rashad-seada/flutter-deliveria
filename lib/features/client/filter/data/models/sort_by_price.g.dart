// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_by_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SortByPriceResponse _$SortByPriceResponseFromJson(Map<String, dynamic> json) =>
    SortByPriceResponse(
      response:
          (json['response'] as List<dynamic>)
              .map((e) => SortByPriceItem.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$SortByPriceResponseToJson(
  SortByPriceResponse instance,
) => <String, dynamic>{
  'response': instance.response.map((e) => e.toJson()).toList(),
};

SortByPriceItem _$SortByPriceItemFromJson(Map<String, dynamic> json) =>
    SortByPriceItem(
      id: json['_id'] as String,
      restaurantId: json['restaurant_id'] as String,
      photo: json['photo'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      sizes:
          (json['sizes'] as List<dynamic>)
              .map((e) => ItemSize.fromJson(e as Map<String, dynamic>))
              .toList(),
      toppings:
          (json['toppings'] as List<dynamic>)
              .map((e) => ItemTopping.fromJson(e as Map<String, dynamic>))
              .toList(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$SortByPriceItemToJson(SortByPriceItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'restaurant_id': instance.restaurantId,
      'photo': instance.photo,
      'name': instance.name,
      'description': instance.description,
      'sizes': instance.sizes.map((e) => e.toJson()).toList(),
      'toppings': instance.toppings.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };

ItemSize _$ItemSizeFromJson(Map<String, dynamic> json) => ItemSize(
  size: json['size'] as String,
  priceBefore: ItemSize._numFromJson(json['price_before']),
  priceAfter: ItemSize._numFromJson(json['price_after']),
  offer: ItemSize._numFromJson(json['offer']),
  id: json['_id'] as String,
);

Map<String, dynamic> _$ItemSizeToJson(ItemSize instance) => <String, dynamic>{
  'size': instance.size,
  'price_before': ItemSize._numToJson(instance.priceBefore),
  'price_after': ItemSize._numToJson(instance.priceAfter),
  'offer': ItemSize._numToJson(instance.offer),
  '_id': instance.id,
};

ItemTopping _$ItemToppingFromJson(Map<String, dynamic> json) => ItemTopping(
  topping: json['topping'] as String,
  price: ItemSize._numFromJson(json['price']),
  id: json['_id'] as String,
);

Map<String, dynamic> _$ItemToppingToJson(ItemTopping instance) =>
    <String, dynamic>{
      'topping': instance.topping,
      'price': ItemSize._numToJson(instance.price),
      '_id': instance.id,
    };
