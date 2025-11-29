// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_coupon_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCouponesResponse _$GetAllCouponesResponseFromJson(
  Map<String, dynamic> json,
) => GetAllCouponesResponse(
  couponCodes:
      (json['coupon_codes'] as List<dynamic>)
          .map((e) => CouponCode.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$GetAllCouponesResponseToJson(
  GetAllCouponesResponse instance,
) => <String, dynamic>{'coupon_codes': instance.couponCodes};

CouponCode _$CouponCodeFromJson(Map<String, dynamic> json) => CouponCode(
  id: json['_id'] as String,
  restaurant: json['restaurant'] as String,
  code: json['code'] as String,
  discount: (json['discount'] as num).toInt(),
  expiredDate: json['expired_date'] as String,
  enable: json['enable'] as bool,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  v: (json['__v'] as num).toInt(),
);

Map<String, dynamic> _$CouponCodeToJson(CouponCode instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'restaurant': instance.restaurant,
      'code': instance.code,
      'discount': instance.discount,
      'expired_date': instance.expiredDate,
      'enable': instance.enable,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };
