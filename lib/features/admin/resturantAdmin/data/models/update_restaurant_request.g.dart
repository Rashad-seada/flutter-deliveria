// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_restaurant_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateRestaurantRequest _$UpdateRestaurantRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateRestaurantRequest(
      name: json['name'] as String?,
      aboutUs: json['about_us'] as String?,
      superCategory: (json['super_category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      subCategory: (json['sub_category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      deliveryCost: json['delivery_cost'] as String?,
      locationMap: json['loacation_map'] as String?,
      openHour: json['open_hour'] as String?,
      closeHour: json['close_hour'] as String?,
      phone: json['phone'] as String?,
      estimatedTime: json['estimated_time'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      commissionPercentage: (json['commission_percentage'] as num?)?.toDouble(),
      preparationTime: (json['preparation_time'] as num?)?.toInt(),
      deliveryTime: (json['delivery_time'] as num?)?.toInt(),
      isShow: json['is_show'] as bool?,
    );

Map<String, dynamic> _$UpdateRestaurantRequestToJson(
        UpdateRestaurantRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'about_us': instance.aboutUs,
      'super_category': instance.superCategory,
      'sub_category': instance.subCategory,
      'delivery_cost': instance.deliveryCost,
      'loacation_map': instance.locationMap,
      'open_hour': instance.openHour,
      'close_hour': instance.closeHour,
      'phone': instance.phone,
      'estimated_time': instance.estimatedTime,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'commission_percentage': instance.commissionPercentage,
      'preparation_time': instance.preparationTime,
      'delivery_time': instance.deliveryTime,
      'is_show': instance.isShow,
    };
