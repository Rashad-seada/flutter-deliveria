// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_fav_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFavResponse _$GetFavResponseFromJson(Map<String, dynamic> json) =>
    GetFavResponse(
      message: json['message'] as String?,
      response: json['response'] == null
          ? null
          : FavResponseData.fromJson(json['response'] as Map<String, dynamic>),
      ids: GetFavResponse._idsFromJson(json['ids']),
    );

Map<String, dynamic> _$GetFavResponseToJson(GetFavResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'response': instance.response?.toJson(),
      'ids': GetFavResponse._idsToJson(instance.ids),
    };

FavResponseData _$FavResponseDataFromJson(Map<String, dynamic> json) =>
    FavResponseData(
      id: json['_id'] as String?,
      userId: json['user_id'] as String?,
      favourites: (json['favourites'] as List<dynamic>?)
          ?.map((e) => FavouriteRestaurant.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FavResponseDataToJson(FavResponseData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.userId,
      'favourites': instance.favourites?.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };

FavouriteRestaurant _$FavouriteRestaurantFromJson(Map<String, dynamic> json) =>
    FavouriteRestaurant(
      coordinates: json['coordinates'] == null
          ? null
          : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      photo: json['photo'] as String?,
      logo: json['logo'] as String?,
      superCategory:
          FavouriteRestaurant._stringOrListToListString(json['super_category']),
      subCategory:
          FavouriteRestaurant._stringOrListToListString(json['sub_category']),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      userName: json['user_name'] as String?,
      password: json['password'] as String?,
      aboutUs: json['about_us'] as String?,
      rateNumber: (json['rate_number'] as num?)?.toInt(),
      userRated: (json['user_rated'] as num?)?.toInt(),
      rate: (json['rate'] as num?)?.toInt(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      deliveryCost: (json['delivery_cost'] as num?)?.toInt(),
      loacationMap: json['loacation_map'] as String?,
      openHour: json['open_hour'] as String?,
      closeHour: json['close_hour'] as String?,
      haveDelivery: json['have_delivery'] as bool?,
      isShow: json['is_show'] as bool?,
      isShowInHome: json['is_show_in_home'] as bool?,
      estimatedTime: (json['estimated_time'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FavouriteRestaurantToJson(
        FavouriteRestaurant instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates?.toJson(),
      '_id': instance.id,
      'photo': instance.photo,
      'logo': instance.logo,
      'super_category':
          FavouriteRestaurant._listStringToJson(instance.superCategory),
      'sub_category':
          FavouriteRestaurant._listStringToJson(instance.subCategory),
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
