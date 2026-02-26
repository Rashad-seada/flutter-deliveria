import 'package:json_annotation/json_annotation.dart';

part 'update_restaurant_request.g.dart';

@JsonSerializable()
class UpdateRestaurantRequest {
  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "about_us")
  final String? aboutUs;

  @JsonKey(name: "super_category")
  final List<String>? superCategory;

  @JsonKey(name: "sub_category")
  final List<String>? subCategory;

  @JsonKey(name: "delivery_cost")
  final String? deliveryCost;

  @JsonKey(name: "loacation_map")
  final String? locationMap;

  @JsonKey(name: "open_hour")
  final String? openHour;

  @JsonKey(name: "close_hour")
  final String? closeHour;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "estimated_time")
  final String? estimatedTime;

  @JsonKey(name: "latitude")
  final String? latitude;

  @JsonKey(name: "longitude")
  final String? longitude;

  @JsonKey(name: "commission_percentage")
  final double? commissionPercentage;

  @JsonKey(name: "preparation_time")
  final int? preparationTime;

  @JsonKey(name: "delivery_time")
  final int? deliveryTime;

  @JsonKey(name: "is_show")
  final bool? isShow;

  UpdateRestaurantRequest({
    this.name,
    this.aboutUs,
    this.superCategory,
    this.subCategory,
    this.deliveryCost,
    this.locationMap,
    this.openHour,
    this.closeHour,
    this.phone,
    this.estimatedTime,
    this.latitude,
    this.longitude,
    this.commissionPercentage,
    this.preparationTime,
    this.deliveryTime,
    this.isShow,
  });

  factory UpdateRestaurantRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateRestaurantRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateRestaurantRequestToJson(this);
}
