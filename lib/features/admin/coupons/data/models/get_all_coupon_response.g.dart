// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_coupon_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCouponesResponse _$GetAllCouponesResponseFromJson(
        Map<String, dynamic> json) =>
    GetAllCouponesResponse(
      couponCodes: (json['coupon_codes'] as List<dynamic>)
          .map((e) => Coupon.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllCouponesResponseToJson(
        GetAllCouponesResponse instance) =>
    <String, dynamic>{
      'coupon_codes': instance.couponCodes,
    };
