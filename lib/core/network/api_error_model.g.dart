// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiErrorModel _$ApiErrorModelFromJson(Map<String, dynamic> json) =>
    ApiErrorModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      errorCode: json['error_code'] as String?,
      field: json['field'] as String?,
      missingFields: (json['missing_fields'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ApiErrorModelToJson(ApiErrorModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'error_code': instance.errorCode,
      'field': instance.field,
      'missing_fields': instance.missingFields,
    };
