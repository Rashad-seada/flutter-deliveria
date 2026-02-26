// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'increase_item_cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncreaseItemCartResponse _$IncreaseItemCartResponseFromJson(
        Map<String, dynamic> json) =>
    IncreaseItemCartResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : IncreaseItemCartData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IncreaseItemCartResponseToJson(
        IncreaseItemCartResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

IncreaseItemCartData _$IncreaseItemCartDataFromJson(
        Map<String, dynamic> json) =>
    IncreaseItemCartData(
      itemId: json['item_id'] as String?,
      size: json['size'] as String?,
      topping: json['topping'] as String?,
      newQuantity: (json['new_quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$IncreaseItemCartDataToJson(
        IncreaseItemCartData instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'size': instance.size,
      'topping': instance.topping,
      'new_quantity': instance.newQuantity,
    };
