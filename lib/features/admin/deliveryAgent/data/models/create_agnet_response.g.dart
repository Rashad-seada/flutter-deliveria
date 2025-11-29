// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_agnet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAgentResponse _$CreateAgentResponseFromJson(Map<String, dynamic> json) =>
    CreateAgentResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$CreateAgentResponseToJson(
  CreateAgentResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
};
