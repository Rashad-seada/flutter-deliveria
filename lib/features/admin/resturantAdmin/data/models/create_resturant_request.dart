import 'package:json_annotation/json_annotation.dart';

part 'create_resturant_request.g.dart';

@JsonSerializable()
class CreatResturantRequest {
  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "password")
  final String? password;

  @JsonKey(name: "about_us")
  final String? aboutUs;

  @JsonKey(name: "super_category")
  final List<String>? superCategory; // Changed from String to List<String>

  @JsonKey(name: "delivery_cost")
  final String? deliveryCost;

  @JsonKey(name: "loacation_map")
  final String? locationMap;

  @JsonKey(name: "open_hour")
  final String? openHour;

  @JsonKey(name: "close_hour")
  final String? closeHour;

  // @JsonKey(name: "have_delivery")
  // final String? haveDelivery;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "estimated_time")
  final String? estimatedTime;

  @JsonKey(name: "sub_category")
  final List<String>? subCategory; // Changed from String to List<String>

  @JsonKey(name: "latitude")
  final String? latitude;

  @JsonKey(name: "longitude")
  final String? longitude;

  CreatResturantRequest({
    this.name,
    this.password,
    this.aboutUs,
    this.superCategory,
    this.deliveryCost,
    this.locationMap,
    this.openHour,
    this.closeHour,
    // this.haveDelivery,
    this.phone,
    this.estimatedTime,
    this.subCategory,
    this.latitude,
    this.longitude,
  });

  factory CreatResturantRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatResturantRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatResturantRequestToJson(this);
}
