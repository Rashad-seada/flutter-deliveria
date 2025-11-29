import 'package:json_annotation/json_annotation.dart';

part 'get_resturant_data_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetResturantDataResponseHome {
  final RestaurantModel restaurant;

  GetResturantDataResponseHome({required this.restaurant});

  factory GetResturantDataResponseHome.fromJson(Map<String, dynamic> json) =>
      _$GetResturantDataResponseHomeFromJson(json);

  Map<String, dynamic> toJson() => _$GetResturantDataResponseHomeToJson(this);
}

@JsonSerializable()
class RestaurantModel {
  final Coordinates coordinates;
  @JsonKey(name: '_id')
  final String id;
  final String photo;
  // logo is not present in the sample, so remove it
  @JsonKey(name: 'super_category')
  final List<String> superCategory;
  @JsonKey(name: 'sub_category')
  final List<String> subCategory;
  final String name;
  final String phone;
  @JsonKey(name: 'user_name')
  final String userName;
  final String password;
  @JsonKey(name: 'about_us')
  final String aboutUs;
  @JsonKey(name: 'rate_number')
  final int rateNumber;
  @JsonKey(name: 'user_rated')
  final int userRated;
  final int rate;
  final List<dynamic> reviews;
  @JsonKey(name: 'delivery_cost')
  final num deliveryCost;
  @JsonKey(name: 'loacation_map')
  final String loacationMap;
  @JsonKey(name: 'open_hour')
  final String openHour;
  @JsonKey(name: 'close_hour')
  final String closeHour;
  @JsonKey(name: 'have_delivery')
  final bool haveDelivery;
  @JsonKey(name: 'is_show')
  final bool isShow;
  @JsonKey(name: 'is_show_in_home')
  final bool isShowInHome;
  @JsonKey(name: 'estimated_time')
  final num estimatedTime;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;

  RestaurantModel({
    required this.coordinates,
    required this.id,
    required this.photo,
    required this.superCategory,
    required this.subCategory,
    required this.name,
    required this.phone,
    required this.userName,
    required this.password,
    required this.aboutUs,
    required this.rateNumber,
    required this.userRated,
    required this.rate,
    required this.reviews,
    required this.deliveryCost,
    required this.loacationMap,
    required this.openHour,
    required this.closeHour,
    required this.haveDelivery,
    required this.isShow,
    required this.isShowInHome,
    required this.estimatedTime,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
}

@JsonSerializable()
class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}
