import 'package:json_annotation/json_annotation.dart';

part 'coupone_request.g.dart';

@JsonSerializable()
class CouponeRequest {
  final String code;
  @JsonKey(name: 'discount_type')
  final String discountType;
  final int value;
  @JsonKey(name: 'expired_date')
  final String expiredDate;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'usage_limit')
  final int? usageLimit;
  @JsonKey(name: 'usage_per_user_limit')
  final int? usagePerUserLimit;
  @JsonKey(name: 'minimum_order_value')
  final double? minimumOrderValue;
  @JsonKey(name: 'applicable_restaurants')
  final List<String>? applicableRestaurants;
  @JsonKey(name: 'coupon_type')
  final String? couponType;

  CouponeRequest({
    required this.code,
    required this.discountType,
    required this.value,
    required this.expiredDate,
    this.description,
    this.usageLimit,
    this.usagePerUserLimit,
    this.minimumOrderValue,
    this.applicableRestaurants,
    this.couponType,
  });

  Map<String, dynamic> toJson() => _$CouponeRequestToJson(this);
}