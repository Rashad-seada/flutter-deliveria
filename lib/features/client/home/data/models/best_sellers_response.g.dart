// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'best_sellers_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BestSellersResponse _$BestSellersResponseFromJson(Map<String, dynamic> json) =>
    BestSellersResponse(
      success: json['success'] as bool?,
      count: (json['count'] as num?)?.toInt(),
      restaurants: (json['restaurants'] as List<dynamic>?)
          ?.map((e) => BestSellerRestaurant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BestSellersResponseToJson(
        BestSellersResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'restaurants': instance.restaurants,
    };

BestSellerRestaurant _$BestSellerRestaurantFromJson(
        Map<String, dynamic> json) =>
    BestSellerRestaurant(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      logo: json['logo'] as String?,
      photo: json['photo'] as String?,
      rating: json['rating'] as num?,
      rate: json['rate'] as num?,
      openHour: json['open_hour'] as String?,
      closeHour: json['close_hour'] as String?,
      coordinates: json['coordinates'] == null
          ? null
          : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
      deliveryCost: json['delivery_cost'] as num?,
      estimatedTime: (json['estimated_time'] as num?)?.toInt(),
      haveDelivery: json['have_delivery'] as bool?,
      aboutUs: json['about_us'] as String?,
      totalOrders: (json['total_orders'] as num?)?.toInt(),
      totalRevenue: json['total_revenue'] as num?,
      isOpen: json['is_open'] as bool?,
      distance: json['distance'] as num?,
      isNearby: json['is_nearby'] as bool?,
      rank: (json['rank'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BestSellerRestaurantToJson(
        BestSellerRestaurant instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'photo': instance.photo,
      'rating': instance.rating,
      'rate': instance.rate,
      'open_hour': instance.openHour,
      'close_hour': instance.closeHour,
      'coordinates': instance.coordinates,
      'delivery_cost': instance.deliveryCost,
      'estimated_time': instance.estimatedTime,
      'have_delivery': instance.haveDelivery,
      'about_us': instance.aboutUs,
      'total_orders': instance.totalOrders,
      'total_revenue': instance.totalRevenue,
      'is_open': instance.isOpen,
      'distance': instance.distance,
      'is_nearby': instance.isNearby,
      'rank': instance.rank,
    };

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) => Coordinates(
      latitude: json['latitude'] as num?,
      longitude: json['longitude'] as num?,
    );

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
