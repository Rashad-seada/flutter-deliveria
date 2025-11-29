// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_agent_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAgentRequest _$CreateAgentRequestFromJson(Map<String, dynamic> json) =>
    CreateAgentRequest(
      name: json['name'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$CreateAgentRequestToJson(CreateAgentRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'password': instance.password,
    };
