// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_categories_response_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemsCategoryResponseUser _$ItemsCategoryResponseUserFromJson(
        Map<String, dynamic> json) =>
    ItemsCategoryResponseUser(
      itemCategories: (json['itemCategories'] as List<dynamic>)
          .map((e) => ItemCategoryUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemsCategoryResponseUserToJson(
        ItemsCategoryResponseUser instance) =>
    <String, dynamic>{
      'itemCategories': instance.itemCategories.map((e) => e.toJson()).toList(),
    };

ItemCategoryUser _$ItemCategoryUserFromJson(Map<String, dynamic> json) =>
    ItemCategoryUser(
      id: json['_id'] as String?,
      nameEn: json['name_en'] as String,
      nameAr: json['name_ar'] as String,
      restaurantId: json['restaurant_id'] as String,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ItemCategoryUserToJson(ItemCategoryUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
      'restaurant_id': instance.restaurantId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };
