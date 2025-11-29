import 'package:json_annotation/json_annotation.dart';

part 'get_all_coupon_response.g.dart';

@JsonSerializable()
class GetAllCouponesResponse {
  @JsonKey(name: 'coupon_codes')
  final List<CouponCode> couponCodes;

  GetAllCouponesResponse({required this.couponCodes});

  factory GetAllCouponesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllCouponesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCouponesResponseToJson(this);
}

@JsonSerializable()
class CouponCode {
  @JsonKey(name: '_id')
  final String id;
  final String restaurant;
  final String code;
  final int discount;
  @JsonKey(name: 'expired_date')
  final String expiredDate;
  final bool enable;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;

  CouponCode({
    required this.id,
    required this.restaurant,
    required this.code,
    required this.discount,
    required this.expiredDate,
    required this.enable,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CouponCode.fromJson(Map<String, dynamic> json) =>
      _$CouponCodeFromJson(json);

  Map<String, dynamic> toJson() => _$CouponCodeToJson(this);
}
