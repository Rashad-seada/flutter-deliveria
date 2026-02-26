// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_item_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateItemRequest _$UpdateItemRequestFromJson(Map<String, dynamic> json) =>
    UpdateItemRequest(
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      categoryId: json['category_id'] as String?,
      isAvailable: json['is_available'] as bool?,
      discountPercentage: (json['discount_percentage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UpdateItemRequestToJson(UpdateItemRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'category_id': instance.categoryId,
      'is_available': instance.isAvailable,
      'discount_percentage': instance.discountPercentage,
    };
