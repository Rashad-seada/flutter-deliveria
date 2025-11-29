// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      message: json['message'] as String,
      token: json['token'] as String,
      user:
          json['user'] == null
              ? null
              : LoginUser.fromJson(json['user'] as Map<String, dynamic>),
      restaurant:
          json['restaurant'] == null
              ? null
              : LoginRestaurant.fromJson(
                json['restaurant'] as Map<String, dynamic>,
              ),
      agent:
          json['agent'] == null
              ? null
              : LoginAgent.fromJson(json['agent'] as Map<String, dynamic>),
      userType: json['userType'] as String,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'token': instance.token,
      'user': instance.user?.toJson(),
      'restaurant': instance.restaurant?.toJson(),
      'agent': instance.agent?.toJson(),
      'userType': instance.userType,
    };

LoginUser _$LoginUserFromJson(Map<String, dynamic> json) => LoginUser(
  coordinates:
      json['coordinates'] == null
          ? null
          : LoginCoordinates.fromJson(
            json['coordinates'] as Map<String, dynamic>,
          ),
  id: json['_id'] as String,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  phone: json['phone'] as String,
  email: json['email'] as String,
  ban: json['ban'] as bool,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  v: (json['__v'] as num).toInt(),
  addressId: json['address_id'] as String?,
);

Map<String, dynamic> _$LoginUserToJson(LoginUser instance) => <String, dynamic>{
  'coordinates': instance.coordinates?.toJson(),
  '_id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'phone': instance.phone,
  'email': instance.email,
  'ban': instance.ban,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  '__v': instance.v,
  'address_id': instance.addressId,
};

LoginRestaurant _$LoginRestaurantFromJson(Map<String, dynamic> json) =>
    LoginRestaurant(
      coordinates:
          json['coordinates'] == null
              ? null
              : LoginCoordinates.fromJson(
                json['coordinates'] as Map<String, dynamic>,
              ),
      id: json['_id'] as String,
      photo: json['photo'] as String,
      logo: json['logo'] as String,
      superCategory:
          (json['super_category'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      subCategory:
          (json['sub_category'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      name: json['name'] as String,
      phone: json['phone'] as String,
      userName: json['user_name'] as String,
      aboutUs: json['about_us'] as String,
      rateNumber: (json['rate_number'] as num).toInt(),
      userRated: (json['user_rated'] as num).toInt(),
      rate: (json['rate'] as num).toInt(),
      reviews: json['reviews'] as List<dynamic>,
      deliveryCost: (json['delivery_cost'] as num).toInt(),
      loacationMap: json['loacation_map'] as String,
      openHour: json['open_hour'] as String,
      closeHour: json['close_hour'] as String,
      haveDelivery: json['have_delivery'] as bool,
      isShow: json['is_show'] as bool,
      isShowInHome: json['is_show_in_home'] as bool,
      estimatedTime: (json['estimated_time'] as num).toInt(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$LoginRestaurantToJson(LoginRestaurant instance) =>
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
      'about_us': instance.aboutUs,
      'rate_number': instance.rateNumber,
      'user_rated': instance.userRated,
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
    };

LoginAgent _$LoginAgentFromJson(Map<String, dynamic> json) => LoginAgent(
  id: json['_id'] as String,
  name: json['name'] as String,
  phone: json['phone'] as String,
  userName: json['user_name'] as String,
  ban: json['ban'] as bool,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  v: (json['__v'] as num).toInt(),
);

Map<String, dynamic> _$LoginAgentToJson(LoginAgent instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'user_name': instance.userName,
      'ban': instance.ban,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };

LoginCoordinates _$LoginCoordinatesFromJson(Map<String, dynamic> json) =>
    LoginCoordinates(
      latitude: LoginCoordinates._toDouble(json['latitude']),
      longitude: LoginCoordinates._toDouble(json['longitude']),
    );

Map<String, dynamic> _$LoginCoordinatesToJson(LoginCoordinates instance) =>
    <String, dynamic>{
      'latitude': LoginCoordinates._fromDouble(instance.latitude),
      'longitude': LoginCoordinates._fromDouble(instance.longitude),
    };
