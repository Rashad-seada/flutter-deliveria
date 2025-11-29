// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserDataResponse _$GetUserDataResponseFromJson(Map<String, dynamic> json) =>
    GetUserDataResponse(
      user:
          json['user'] == null
              ? null
              : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetUserDataResponseToJson(
  GetUserDataResponse instance,
) => <String, dynamic>{'user': instance.user?.toJson()};

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['_id'] as String,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  phone: json['phone'] as String,
  email: json['email'] as String,
  password: json['password'] as String,
  coordinates:
      json['coordinates'] == null
          ? null
          : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  v: (json['__v'] as num).toInt(),
  ban: json['ban'] as bool,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  '_id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'phone': instance.phone,
  'email': instance.email,
  'password': instance.password,
  'coordinates': instance.coordinates,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  '__v': instance.v,
  'ban': instance.ban,
};

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) => Coordinates(
  latitude: json['latitude'] as String?,
  longitude: json['longitude'] as String?,
);

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
