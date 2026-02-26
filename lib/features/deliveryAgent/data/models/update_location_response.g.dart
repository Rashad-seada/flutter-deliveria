// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_location_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateLocationResponse _$UpdateLocationResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateLocationResponse(
      success: json['success'] as bool,
      location: json['location'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$UpdateLocationResponseToJson(
        UpdateLocationResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'location': instance.location,
    };
