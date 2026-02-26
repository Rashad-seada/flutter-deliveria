import 'package:delveria/features/admin/coupons/data/models/coupon.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_coupon_response.g.dart';

@JsonSerializable()
class GetAllCouponesResponse {
  @JsonKey(name: 'coupon_codes')
  final List<Coupon> couponCodes;

  GetAllCouponesResponse({required this.couponCodes});

  factory GetAllCouponesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllCouponesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCouponesResponseToJson(this);
}
