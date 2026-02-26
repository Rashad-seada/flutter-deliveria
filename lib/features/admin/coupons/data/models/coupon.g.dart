// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) => Coupon(
      id: json['_id'] as String,
      code: json['code'] as String,
      discountType: json['discount_type'] as String,
      value: (json['value'] as num).toInt(),
      expiredDate: DateTime.parse(json['expired_date'] as String),
      isActive: json['is_active'] as bool? ?? true,
      usageLimit: (json['usage_limit'] as num?)?.toInt(),
      usagePerUserLimit: (json['usage_per_user_limit'] as num?)?.toInt() ?? 1,
      minimumOrderValue: (json['minimum_order_value'] as num?)?.toDouble() ?? 0,
      applicableRestaurants: (json['applicable_restaurants'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      couponType: json['coupon_type'] as String? ?? 'promotional',
      description: json['description'] as String? ?? '',
      usersUsed: (json['users_used'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      '_id': instance.id,
      'code': instance.code,
      'discount_type': instance.discountType,
      'value': instance.value,
      'expired_date': instance.expiredDate.toIso8601String(),
      'is_active': instance.isActive,
      'usage_limit': instance.usageLimit,
      'usage_per_user_limit': instance.usagePerUserLimit,
      'minimum_order_value': instance.minimumOrderValue,
      'applicable_restaurants': instance.applicableRestaurants,
      'coupon_type': instance.couponType,
      'description': instance.description,
      'users_used': instance.usersUsed,
      'createdAt': instance.createdAt,
    };
