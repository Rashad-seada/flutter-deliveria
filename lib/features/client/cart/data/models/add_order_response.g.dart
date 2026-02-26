// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddOrderResponse _$AddOrderResponseFromJson(Map<String, dynamic> json) =>
    AddOrderResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$AddOrderResponseToJson(AddOrderResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
