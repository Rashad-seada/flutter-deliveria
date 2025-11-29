import 'package:json_annotation/json_annotation.dart';

part 'get_nearby_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetNearbyResponse {
  final List<NearbyRestaurant> response;

  GetNearbyResponse({required this.response});

  factory GetNearbyResponse.fromJson(Map<String, dynamic> json) =>
      _$GetNearbyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetNearbyResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NearbyRestaurant {
  final Coordinates coordinates;
  @JsonKey(name: '_id')
  final String id;
  final String photo;
  final String logo;
  @JsonKey(name: 'super_category')
  final List<SuperCategory> superCategory;
  @JsonKey(name: 'sub_category')
  final List<SubCategory> subCategory;
  final String name;
  final String phone;
  @JsonKey(name: 'about_us')
  final String aboutUs;
  final num rate;
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
  @JsonKey(name: 'is_open')
  final bool isOpen;
  @JsonKey(name: 'is_nearby')
  final bool isNearby;

  NearbyRestaurant({
    required this.coordinates,
    required this.id,
    required this.photo,
    required this.logo,
    required this.superCategory,
    required this.subCategory,
    required this.name,
    required this.phone,
    required this.aboutUs,
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
    required this.isOpen,
    required this.isNearby,
  });

  factory NearbyRestaurant.fromJson(Map<String, dynamic> json) =>
      _$NearbyRestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$NearbyRestaurantToJson(this);
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

@JsonSerializable()
class SuperCategory {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'name_en')
  final String nameEn;
  @JsonKey(name: 'name_ar')
  final String nameAr;
  final String logo;

  SuperCategory({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.logo,
  });

  factory SuperCategory.fromJson(Map<String, dynamic> json) =>
      _$SuperCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SuperCategoryToJson(this);
}

@JsonSerializable()
class SubCategory {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'name_en')
  final String nameEn;
  @JsonKey(name: 'name_ar')
  final String nameAr;

  SubCategory({
    required this.id,
    required this.nameEn,
    required this.nameAr,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}
