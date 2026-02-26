// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decrease_item_cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DecreaseItemCartResponse _$DecreaseItemCartResponseFromJson(
        Map<String, dynamic> json) =>
    DecreaseItemCartResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : DecreaseItemCartData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DecreaseItemCartResponseToJson(
        DecreaseItemCartResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data?.toJson(),
    };

DecreaseItemCartData _$DecreaseItemCartDataFromJson(
        Map<String, dynamic> json) =>
    DecreaseItemCartData(
      itemId: json['item_id'] as String?,
      size: json['size'] as String?,
      topping: json['topping'] as String?,
      newQuantity: (json['new_quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DecreaseItemCartDataToJson(
        DecreaseItemCartData instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'size': instance.size,
      'topping': instance.topping,
      'new_quantity': instance.newQuantity,
    };
