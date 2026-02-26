// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponseItem _$SearchResponseItemFromJson(Map<String, dynamic> json) =>
    SearchResponseItem(
      items: (json['items'] as List<dynamic>)
          .map((e) => ItemModelSearch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchResponseItemToJson(SearchResponseItem instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

ItemModelSearch _$ItemModelSearchFromJson(Map<String, dynamic> json) =>
    ItemModelSearch(
      id: json['_id'] as String?,
      restaurantId: json['restaurant_id'] as String?,
      photo: json['photo'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      enable: json['enable'] as bool?,
      itemCategory: json['item_category'] as String?,
      haveOption: json['have_option'] as bool?,
      sizes: (json['sizes'] as List<dynamic>?)
          ?.map((e) => SizeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      toppings: (json['toppings'] as List<dynamic>?)
          ?.map((e) => ToppingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ItemModelSearchToJson(ItemModelSearch instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'restaurant_id': instance.restaurantId,
      'photo': instance.photo,
      'name': instance.name,
      'description': instance.description,
      'enable': instance.enable,
      'item_category': instance.itemCategory,
      'have_option': instance.haveOption,
      'sizes': instance.sizes?.map((e) => e.toJson()).toList(),
      'toppings': instance.toppings?.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };
