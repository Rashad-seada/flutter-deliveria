// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_address_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteAddressResponse _$DeleteAddressResponseFromJson(
        Map<String, dynamic> json) =>
    DeleteAddressResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$DeleteAddressResponseToJson(
        DeleteAddressResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
