// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_home_data_admin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetHomeDataAdminResponse _$GetHomeDataAdminResponseFromJson(
        Map<String, dynamic> json) =>
    GetHomeDataAdminResponse(
      totalOrders: (json['total_orders'] as num?)?.toInt(),
      netRevenue: json['net_revenue'] as num?,
      activeUsers: (json['active_users'] as num?)?.toInt(),
      activeRestaurants: (json['active_restaurants'] as num?)?.toInt(),
      totalAmount: json['total_amount'] as num?,
      ordersToday: (json['orders_today'] as num?)?.toInt(),
      ordersOfLastWeek: (json['oders_of_last_week'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$GetHomeDataAdminResponseToJson(
        GetHomeDataAdminResponse instance) =>
    <String, dynamic>{
      'total_orders': instance.totalOrders,
      'net_revenue': instance.netRevenue,
      'active_users': instance.activeUsers,
      'active_restaurants': instance.activeRestaurants,
      'total_amount': instance.totalAmount,
      'orders_today': instance.ordersToday,
      'oders_of_last_week': instance.ordersOfLastWeek,
    };
