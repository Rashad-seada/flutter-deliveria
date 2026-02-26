// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_system_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSystemDataResponse _$GetSystemDataResponseFromJson(
        Map<String, dynamic> json) =>
    GetSystemDataResponse(
      response: json['response'] == null
          ? null
          : SystemDataResponse.fromJson(
              json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetSystemDataResponseToJson(
        GetSystemDataResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
    };

SystemDataResponse _$SystemDataResponseFromJson(Map<String, dynamic> json) =>
    SystemDataResponse(
      id: json['_id'] as String?,
      isUploaded: json['is_uploaded'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SystemDataResponseToJson(SystemDataResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'is_uploaded': instance.isUploaded,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };
