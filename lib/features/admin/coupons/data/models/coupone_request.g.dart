// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupone_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponeRequest _$CouponeRequestFromJson(Map<String, dynamic> json) =>
    CouponeRequest(
      code: json['code'] as String,
      discountType: json['discount_type'] as String,
      value: (json['value'] as num).toInt(),
      expiredDate: json['expired_date'] as String,
      description: json['description'] as String?,
      usageLimit: (json['usage_limit'] as num?)?.toInt(),
      usagePerUserLimit: (json['usage_per_user_limit'] as num?)?.toInt(),
      minimumOrderValue: (json['minimum_order_value'] as num?)?.toDouble(),
      applicableRestaurants: (json['applicable_restaurants'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      couponType: json['coupon_type'] as String?,
    );

Map<String, dynamic> _$CouponeRequestToJson(CouponeRequest instance) =>
    <String, dynamic>{
      'code': instance.code,
      'discount_type': instance.discountType,
      'value': instance.value,
      'expired_date': instance.expiredDate,
      'description': instance.description,
      'usage_limit': instance.usageLimit,
      'usage_per_user_limit': instance.usagePerUserLimit,
      'minimum_order_value': instance.minimumOrderValue,
      'applicable_restaurants': instance.applicableRestaurants,
      'coupon_type': instance.couponType,
    };
