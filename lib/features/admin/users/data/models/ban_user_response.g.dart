// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ban_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BanUserResponse _$BanUserResponseFromJson(Map<String, dynamic> json) =>
    BanUserResponse(
      message: json['message'] as String,
      ban: json['ban'] as bool,
    );

Map<String, dynamic> _$BanUserResponseToJson(BanUserResponse instance) =>
    <String, dynamic>{'message': instance.message, 'ban': instance.ban};
