// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_home_data_resturant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetHomeDataResturantResponseImpl _$$GetHomeDataResturantResponseImplFromJson(
  Map<String, dynamic> json,
) => _$GetHomeDataResturantResponseImpl(
  totalOrders: (json['total_orders'] as num).toInt(),
  netRevenue: json['net_revenue'] as num,
  customerFeedback: (json['customer_feedback'] as num).toDouble(),
  ordersOfLastWeek:
      (json['oders_of_last_week'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
);

Map<String, dynamic> _$$GetHomeDataResturantResponseImplToJson(
  _$GetHomeDataResturantResponseImpl instance,
) => <String, dynamic>{
  'total_orders': instance.totalOrders,
  'net_revenue': instance.netRevenue,
  'customer_feedback': instance.customerFeedback,
  'oders_of_last_week': instance.ordersOfLastWeek,
};
