// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_home_data_resturant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetHomeDataResturantResponseImpl _$$GetHomeDataResturantResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetHomeDataResturantResponseImpl(
      response:
          HomeDataResponse.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GetHomeDataResturantResponseImplToJson(
        _$GetHomeDataResturantResponseImpl instance) =>
    <String, dynamic>{
      'response': instance.response,
    };

_$HomeDataResponseImpl _$$HomeDataResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$HomeDataResponseImpl(
      restaurant: RestaurantHomeInfo.fromJson(
          json['restaurant'] as Map<String, dynamic>),
      ordersOfLastWeek: (json['orders_of_last_week'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      totalOrders: (json['total_orders'] as num?)?.toInt(),
      totalRevenue: json['total_revenue'] as num?,
      averageRating: (json['average_rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$HomeDataResponseImplToJson(
        _$HomeDataResponseImpl instance) =>
    <String, dynamic>{
      'restaurant': instance.restaurant,
      'orders_of_last_week': instance.ordersOfLastWeek,
      'total_orders': instance.totalOrders,
      'total_revenue': instance.totalRevenue,
      'average_rating': instance.averageRating,
    };

_$RestaurantHomeInfoImpl _$$RestaurantHomeInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$RestaurantHomeInfoImpl(
      statistics: RestaurantStatistics.fromJson(
          json['statistics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RestaurantHomeInfoImplToJson(
        _$RestaurantHomeInfoImpl instance) =>
    <String, dynamic>{
      'statistics': instance.statistics,
    };

_$RestaurantStatisticsImpl _$$RestaurantStatisticsImplFromJson(
        Map<String, dynamic> json) =>
    _$RestaurantStatisticsImpl(
      totalOrders: (json['total_orders'] as num).toInt(),
      totalRevenue: json['total_revenue'] as num,
      averageRating: json['average_rating'] as num,
    );

Map<String, dynamic> _$$RestaurantStatisticsImplToJson(
        _$RestaurantStatisticsImpl instance) =>
    <String, dynamic>{
      'total_orders': instance.totalOrders,
      'total_revenue': instance.totalRevenue,
      'average_rating': instance.averageRating,
    };
