// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_users_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllUsersModel _$GetAllUsersModelFromJson(Map<String, dynamic> json) =>
    GetAllUsersModel(
      users:
          (json['users'] as List<dynamic>)
              .map((e) => UserModelAdmin.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$GetAllUsersModelToJson(GetAllUsersModel instance) =>
    <String, dynamic>{'users': instance.users.map((e) => e.toJson()).toList()};

UserModelAdmin _$UserModelAdminFromJson(Map<String, dynamic> json) =>
    UserModelAdmin(
      id: json['_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      coordinates:
          json['coordinates'] == null
              ? null
              : Coordinates.fromJson(
                json['coordinates'] as Map<String, dynamic>,
              ),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: (json['__v'] as num).toInt(),
      ban: json['ban'] as bool,
      addressId: json['address_id'] as String?,
      numberOfOrders: UserModelAdmin._numberOfOrdersFromJson(
        json['number_of_orders'],
      ),
    );

Map<String, dynamic> _$UserModelAdminToJson(UserModelAdmin instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'password': instance.password,
      'coordinates': instance.coordinates?.toJson(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
      'ban': instance.ban,
      'address_id': instance.addressId,
      'number_of_orders': UserModelAdmin._numberOfOrdersToJson(
        instance.numberOfOrders,
      ),
    };

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) => Coordinates(
  latitude: json['latitude'] as String,
  longitude: json['longitude'] as String,
);

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
