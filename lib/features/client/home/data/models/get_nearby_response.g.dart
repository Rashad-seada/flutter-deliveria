// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_nearby_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNearbyResponse _$GetNearbyResponseFromJson(Map<String, dynamic> json) =>
    GetNearbyResponse(
      response: (json['response'] as List<dynamic>)
          .map((e) => NearbyRestaurant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetNearbyResponseToJson(GetNearbyResponse instance) =>
    <String, dynamic>{
      'response': instance.response.map((e) => e.toJson()).toList(),
    };

NearbyRestaurant _$NearbyRestaurantFromJson(Map<String, dynamic> json) =>
    NearbyRestaurant(
      coordinates:
          Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
      id: json['_id'] as String,
      photo: json['photo'] as String,
      logo: json['logo'] as String,
      superCategory: (json['super_category'] as List<dynamic>)
          .map((e) => SuperCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      subCategory: (json['sub_category'] as List<dynamic>)
          .map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String,
      phone: json['phone'] as String,
      aboutUs: json['about_us'] as String,
      rate: json['rate'] as num,
      reviews: json['reviews'] as List<dynamic>,
      deliveryCost: json['delivery_cost'] as num,
      loacationMap: json['loacation_map'] as String,
      openHour: json['open_hour'] as String,
      closeHour: json['close_hour'] as String,
      haveDelivery: json['have_delivery'] as bool,
      isShow: json['is_show'] as bool,
      isShowInHome: json['is_show_in_home'] as bool,
      estimatedTime: json['estimated_time'] as num,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: (json['__v'] as num).toInt(),
      isOpen: json['is_open'] as bool,
      isNearby: json['is_nearby'] as bool,
    );

Map<String, dynamic> _$NearbyRestaurantToJson(NearbyRestaurant instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates.toJson(),
      '_id': instance.id,
      'photo': instance.photo,
      'logo': instance.logo,
      'super_category': instance.superCategory.map((e) => e.toJson()).toList(),
      'sub_category': instance.subCategory.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'phone': instance.phone,
      'about_us': instance.aboutUs,
      'rate': instance.rate,
      'reviews': instance.reviews,
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
      'is_open': instance.isOpen,
      'is_nearby': instance.isNearby,
    };

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) => Coordinates(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

SuperCategory _$SuperCategoryFromJson(Map<String, dynamic> json) =>
    SuperCategory(
      id: json['_id'] as String,
      nameEn: json['name_en'] as String,
      nameAr: json['name_ar'] as String,
      logo: json['logo'] as String,
    );

Map<String, dynamic> _$SuperCategoryToJson(SuperCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
      'logo': instance.logo,
    };

SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) => SubCategory(
      id: json['_id'] as String,
      nameEn: json['name_en'] as String,
      nameAr: json['name_ar'] as String,
    );

Map<String, dynamic> _$SubCategoryToJson(SubCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
    };
