// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_resturant_data_response_for_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetResturantDataResponseProfile _$GetResturantDataResponseProfileFromJson(
        Map<String, dynamic> json) =>
    GetResturantDataResponseProfile(
      restaurant: json['restaurant'] == null
          ? null
          : RestaurantModel.fromJson(
              json['restaurant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetResturantDataResponseProfileToJson(
        GetResturantDataResponseProfile instance) =>
    <String, dynamic>{
      'restaurant': instance.restaurant?.toJson(),
    };

RestaurantModel _$RestaurantModelFromJson(Map<String, dynamic> json) =>
    RestaurantModel(
      coordinates: json['coordinates'] == null
          ? null
          : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      photo: json['photo'] as String?,
      logo: json['logo'] as String?,
      superCategory: (json['super_category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      subCategory: (json['sub_category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      userName: json['user_name'] as String?,
      password: json['password'] as String?,
      aboutUs: json['about_us'] as String?,
      rateNumber: (json['rate_number'] as num?)?.toInt(),
      userRated: (json['user_rated'] as num?)?.toInt(),
      rate: json['rate'] as num?,
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      deliveryCost: json['delivery_cost'] as num?,
      loacationMap: json['loacation_map'] as String?,
      openHour: json['open_hour'] as String?,
      closeHour: json['close_hour'] as String?,
      haveDelivery: json['have_delivery'] as bool?,
      isShow: json['is_show'] as bool?,
      isShowInHome: json['is_show_in_home'] as bool?,
      estimatedTime: json['estimated_time'] as num?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RestaurantModelToJson(RestaurantModel instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates?.toJson(),
      '_id': instance.id,
      'photo': instance.photo,
      'logo': instance.logo,
      'super_category': instance.superCategory,
      'sub_category': instance.subCategory,
      'name': instance.name,
      'phone': instance.phone,
      'user_name': instance.userName,
      'password': instance.password,
      'about_us': instance.aboutUs,
      'rate_number': instance.rateNumber,
      'user_rated': instance.userRated,
      'rate': instance.rate,
      'reviews': instance.reviews?.map((e) => e.toJson()).toList(),
      'delivery_cost': instance.deliveryCost,
      'loacation_map': instance.loacationMap,
      'open_hour': instance.openHour,
      'close_hour': instance.closeHour,
      'have_delivery': instance.haveDelivery,
      'is_show': instance.isShow,
      'is_show_in_home': instance.isShowInHome,
      'estimated_time': instance.estimatedTime,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) => Coordinates(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
