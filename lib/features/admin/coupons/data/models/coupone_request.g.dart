// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupone_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponeRequest _$CouponeRequestFromJson(Map<String, dynamic> json) =>
    CouponeRequest(
      numberEnable: json['number_enable'] as String,
      restaurant: json['restaurant'] as String,
      code: json['code'] as String,
      discount: (json['discount'] as num).toInt(),
      expiredDate: json['expired_date'] as String,
    );

Map<String, dynamic> _$CouponeRequestToJson(CouponeRequest instance) =>
    <String, dynamic>{
      'restaurant': instance.restaurant,
      'code': instance.code,
      'discount': instance.discount,
      'expired_date': instance.expiredDate,
      'number_enable': instance.numberEnable,
    };
