// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemsCategoryResponse _$ItemsCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    ItemsCategoryResponse(
      itemCategories: (json['itemCategories'] as List<dynamic>)
          .map((e) => ItemCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemsCategoryResponseToJson(
        ItemsCategoryResponse instance) =>
    <String, dynamic>{
      'itemCategories': instance.itemCategories.map((e) => e.toJson()).toList(),
    };

ItemCategory _$ItemCategoryFromJson(Map<String, dynamic> json) => ItemCategory(
      id: json['_id'] as String,
      nameEn: json['name_en'] as String,
      nameAr: json['name_ar'] as String,
      restaurantId: json['restaurant_id'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$ItemCategoryToJson(ItemCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
      'restaurant_id': instance.restaurantId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };
