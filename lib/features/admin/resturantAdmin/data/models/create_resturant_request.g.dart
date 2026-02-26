// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_resturant_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatResturantRequest _$CreatResturantRequestFromJson(
        Map<String, dynamic> json) =>
    CreatResturantRequest(
      name: json['name'] as String?,
      password: json['password'] as String?,
      aboutUs: json['about_us'] as String?,
      superCategory: (json['super_category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      deliveryCost: json['delivery_cost'] as String?,
      locationMap: json['location_map'] as String?,
      openHour: json['open_hour'] as String?,
      closeHour: json['close_hour'] as String?,
      phone: json['phone'] as String?,
      estimatedTime: json['estimated_time'] as String?,
      subCategory: (json['sub_category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      commissionPercentage: (json['commission_percentage'] as num?)?.toDouble(),
      preparationTime: (json['preparation_time'] as num?)?.toInt(),
      deliveryTime: (json['delivery_time'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CreatResturantRequestToJson(
        CreatResturantRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'password': instance.password,
      'about_us': instance.aboutUs,
      'super_category': instance.superCategory,
      'delivery_cost': instance.deliveryCost,
      'location_map': instance.locationMap,
      'open_hour': instance.openHour,
      'close_hour': instance.closeHour,
      'phone': instance.phone,
      'estimated_time': instance.estimatedTime,
      'sub_category': instance.subCategory,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'commission_percentage': instance.commissionPercentage,
      'preparation_time': instance.preparationTime,
      'delivery_time': instance.deliveryTime,
    };
