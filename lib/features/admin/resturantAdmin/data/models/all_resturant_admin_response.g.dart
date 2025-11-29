// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_resturant_admin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllResturantAdminResponse _$AllResturantAdminResponseFromJson(
  Map<String, dynamic> json,
) => AllResturantAdminResponse(
  response:
      (json['response'] as List<dynamic>)
          .map((e) => ResturantAdmin.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$AllResturantAdminResponseToJson(
  AllResturantAdminResponse instance,
) => <String, dynamic>{
  'response': instance.response.map((e) => e.toJson()).toList(),
};

ResturantAdmin _$ResturantAdminFromJson(Map<String, dynamic> json) =>
    ResturantAdmin(
      coordinates: Coordinates.fromJson(
        json['coordinates'] as Map<String, dynamic>,
      ),
      id: json['_id'] as String,
      photo: json['photo'] as String,
      logo: json['logo'] as String,
      superCategory:
          (json['super_category'] as List<dynamic>)
              .map((e) => SuperCategory.fromJson(e as Map<String, dynamic>))
              .toList(),
      subCategory:
          (json['sub_category'] as List<dynamic>)
              .map((e) => SubCategoryGetRes.fromJson(e as Map<String, dynamic>))
              .toList(),
      name: json['name'] as String,
      phone: json['phone'] as String,
      aboutUs: json['about_us'] as String,
      rate: json['rate'] as num,
      reviews:
          (json['reviews'] as List<dynamic>)
              .map((e) => Review.fromJson(e as Map<String, dynamic>))
              .toList(),
      deliveryCost: json['delivery_cost'] as num,
      loacationMap: json['loacation_map'] as String,
      openHour: json['open_hour'] as String,
      closeHour: json['close_hour'] as String,
      haveDelivery: json['have_delivery'] as bool,
      isShow: json['is_show'] as bool,
      isShowInHome: json['is_show_in_home'] as bool,
      estimatedTime: json['estimated_time'] as num?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: (json['__v'] as num).toInt(),
      isOpen: json['is_open'] as bool,
    );

Map<String, dynamic> _$ResturantAdminToJson(ResturantAdmin instance) =>
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
      'reviews': instance.reviews.map((e) => e.toJson()).toList(),
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
    };

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) =>
    Coordinates(latitude: json['latitude'], longitude: json['longitude']);

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

SuperCategory _$SuperCategoryFromJson(Map<String, dynamic> json) =>
    SuperCategory(
      id: json['_id'] as String,
      nameEn: json['name_en'] as String?,
      nameAr: json['name_ar'] as String?,
      logo: json['logo'] as String,
    );

Map<String, dynamic> _$SuperCategoryToJson(SuperCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
      'logo': instance.logo,
    };

SubCategoryGetRes _$SubCategoryGetResFromJson(Map<String, dynamic> json) =>
    SubCategoryGetRes(
      id: json['_id'] as String,
      nameEn: json['name_en'] as String?,
      nameAr: json['name_ar'] as String?,
    );

Map<String, dynamic> _$SubCategoryGetResToJson(SubCategoryGetRes instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
    };

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
  userId: json['user_id'] as String,
  message: json['message'] as String,
  rate: json['rate'] as num,
  id: json['_id'] as String,
);

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
  'user_id': instance.userId,
  'message': instance.message,
  'rate': instance.rate,
  '_id': instance.id,
};
