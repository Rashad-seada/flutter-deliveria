// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymobOrderResponse _$PaymobOrderResponseFromJson(Map<String, dynamic> json) =>
    PaymobOrderResponse(
      orderId: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$PaymobOrderResponseToJson(
  PaymobOrderResponse instance,
) => <String, dynamic>{'id': instance.orderId, 'status': instance.status};
