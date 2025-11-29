// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_addresses_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAddressesResponse _$GetAddressesResponseFromJson(
  Map<String, dynamic> json,
) => GetAddressesResponse(
  success: json['success'] as bool,
  address:
      (json['address'] as List<dynamic>)
          .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$GetAddressesResponseToJson(
  GetAddressesResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'address': instance.address.map((e) => e.toJson()).toList(),
};

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
  coordinates:
      json['coordinates'] == null
          ? null
          : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
  id: json['_id'] as String,
  userId: json['user_id'] as String,
  addressTitle: json['address_title'] as String,
  phone: json['phone'] as String,
  details: json['details'] as String,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  v: (json['__v'] as num).toInt(),
  isDefault: json['is_default'] as bool? ?? false,
);

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates?.toJson(),
      '_id': instance.id,
      'user_id': instance.userId,
      'address_title': instance.addressTitle,
      'phone': instance.phone,
      'details': instance.details,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
      'is_default': instance.isDefault,
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
