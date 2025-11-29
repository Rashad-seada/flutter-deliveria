import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_resturant_data_response_for_profile.g.dart';

@JsonSerializable(explicitToJson: true)
class GetResturantDataResponseProfile {
  final RestaurantModel? restaurant;

  GetResturantDataResponseProfile({this.restaurant});

  factory GetResturantDataResponseProfile.fromJson(Map<String, dynamic> json) =>
      _$GetResturantDataResponseProfileFromJson(json);

  Map<String, dynamic> toJson() => _$GetResturantDataResponseProfileToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RestaurantModel {
  final Coordinates? coordinates;
  @JsonKey(name: '_id')
  final String? id;
  final String? photo;
  final String? logo;
  @JsonKey(name: 'super_category')
  final List<String>? superCategory;
  @JsonKey(name: 'sub_category')
  final List<String>? subCategory;
  final String? name;
  final String? phone;
  @JsonKey(name: 'user_name')
  final String? userName;
  final String? password;
  @JsonKey(name: 'about_us')
  final String? aboutUs;
  @JsonKey(name: 'rate_number')
  final int? rateNumber;
  @JsonKey(name: 'user_rated')
  final int? userRated;
  final num? rate;
  final List<Review>? reviews;
  @JsonKey(name: 'delivery_cost')
  final num? deliveryCost;
  @JsonKey(name: 'loacation_map')
  final String? loacationMap;
  @JsonKey(name: 'open_hour')
  final String? openHour;
  @JsonKey(name: 'close_hour')
  final String? closeHour;
  @JsonKey(name: 'have_delivery')
  final bool? haveDelivery;
  @JsonKey(name: 'is_show')
  final bool? isShow;
  @JsonKey(name: 'is_show_in_home')
  final bool? isShowInHome;
  @JsonKey(name: 'estimated_time')
  final num? estimatedTime;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;

  RestaurantModel({
    this.coordinates,
    this.id,
    this.photo,
    this.logo,
    this.superCategory,
    this.subCategory,
    this.name,
    this.phone,
    this.userName,
    this.password,
    this.aboutUs,
    this.rateNumber,
    this.userRated,
    this.rate,
    this.reviews,
    this.deliveryCost,
    this.loacationMap,
    this.openHour,
    this.closeHour,
    this.haveDelivery,
    this.isShow,
    this.isShowInHome,
    this.estimatedTime,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
}

@JsonSerializable()
class Coordinates {
  final double? latitude;
  final double? longitude;

  Coordinates({this.latitude, this.longitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}
