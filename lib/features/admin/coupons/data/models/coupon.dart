import 'package:json_annotation/json_annotation.dart';

part 'coupon.g.dart';

@JsonSerializable(explicitToJson: true)
class Coupon {
  @JsonKey(name: '_id')
  final String id;
  final String code;
  @JsonKey(name: 'discount_type')
  final String discountType; // "bill" or "delivery"
  final int value; // 1-100 (percentage) or fixed amount
  @JsonKey(name: 'expired_date')
  final DateTime expiredDate;
  @JsonKey(name: 'is_active', defaultValue: true)
  final bool isActive;
  @JsonKey(name: 'usage_limit')
  final int? usageLimit; // null = unlimited
  @JsonKey(name: 'usage_per_user_limit', defaultValue: 1)
  final int usagePerUserLimit;
  @JsonKey(name: 'minimum_order_value', defaultValue: 0)
  final double minimumOrderValue;
  @JsonKey(name: 'applicable_restaurants', defaultValue: [])
  final List<String> applicableRestaurants; // Empty = all
  @JsonKey(name: 'coupon_type', defaultValue: 'promotional')
  final String couponType; // promotional, points_reward, loyalty, seasonal
  @JsonKey(name: 'description', defaultValue: '')
  final String description;
  @JsonKey(name: 'users_used', defaultValue: [])
  final List<String> usersUsed;
  final String? createdAt;

  Coupon({
    required this.id,
    required this.code,
    required this.discountType,
    required this.value,
    required this.expiredDate,
    required this.isActive,
    this.usageLimit,
    required this.usagePerUserLimit,
    required this.minimumOrderValue,
    required this.applicableRestaurants,
    required this.couponType,
    required this.description,
    required this.usersUsed,
    this.createdAt,
  });

  bool get isExpired => DateTime.now().isAfter(expiredDate);

  factory Coupon.fromJson(Map<String, dynamic> json) {
    // Backward compatibility for old records
    // Map 'discount' to 'value' if 'value' is missing
    if (json['value'] == null && json['discount'] != null) {
      json['value'] = json['discount'];
    }
    
    // Default 'discount_type' if missing
    if (json['discount_type'] == null) {
      json['discount_type'] = 'bill'; // Default to 'bill' (Percentage) for old coupons
    }

    // Default 'expired_date' if missing
    if (json['expired_date'] == null) {
      // Set to 1 year from now as fallback
      json['expired_date'] = DateTime.now().add(const Duration(days: 365)).toIso8601String();
    }

    return _$CouponFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CouponToJson(this);
}
