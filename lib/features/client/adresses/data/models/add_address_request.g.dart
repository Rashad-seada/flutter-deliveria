// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_address_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAddressRequest _$AddAddressRequestFromJson(Map<String, dynamic> json) =>
    AddAddressRequest(
      addressTitle: json['address_title'] as String,
      phone: json['phone'] as String,
      details: json['details'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      isDefault: json['default'] as bool,
    );

Map<String, dynamic> _$AddAddressRequestToJson(AddAddressRequest instance) =>
    <String, dynamic>{
      'address_title': instance.addressTitle,
      'phone': instance.phone,
      'details': instance.details,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'default': instance.isDefault,
    };
