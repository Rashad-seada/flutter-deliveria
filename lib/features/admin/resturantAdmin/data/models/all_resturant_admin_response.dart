import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_resturant_admin_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AllResturantAdminResponse {
  final List<ResturantAdmin> response;

  AllResturantAdminResponse({required this.response});

  factory AllResturantAdminResponse.fromJson(Map<String, dynamic> json) {
    final responseList = json['response'];
    return AllResturantAdminResponse(
      response: responseList == null
          ? []
          : (responseList as List)
              .map((e) => ResturantAdmin.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => _$AllResturantAdminResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResturantAdmin {
  final Coordinates coordinates;
  @JsonKey(name: '_id')
  final String id;
  final String photo;
  final String logo;
  @JsonKey(name: 'super_category')
  final List<SuperCategory> superCategory;
  @JsonKey(name: 'sub_category')
  final List<SubCategoryGetRes> subCategory;
  final String name;
  final String phone;
  @JsonKey(name: 'about_us')
  final String aboutUs;
  final num rate;
  final List<Review> reviews;
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
  final num? estimatedTime;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;
  @JsonKey(name: 'is_open')
  final bool isOpen;

  ResturantAdmin({
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
    this.estimatedTime,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isOpen,
  });

  factory ResturantAdmin.fromJson(Map<String, dynamic> json) =>
      _$ResturantAdminFromJson(json);

  Map<String, dynamic> toJson() => _$ResturantAdminToJson(this);
}

@JsonSerializable()
class Coordinates {
  final dynamic latitude;
  final dynamic longitude;

  Coordinates({
    this.latitude,
    this.longitude,
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
  final String? nameEn;
  @JsonKey(name: 'name_ar')
  final String? nameAr;
  final String logo;

  SuperCategory({
    required this.id,
    this.nameEn,
    this.nameAr,
    required this.logo,
  });

  factory SuperCategory.fromJson(Map<String, dynamic> json) =>
      _$SuperCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SuperCategoryToJson(this);
}

@JsonSerializable()
class SubCategoryGetRes {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'name_en')
  final String? nameEn;
  @JsonKey(name: 'name_ar')
  final String? nameAr;

  SubCategoryGetRes({
    required this.id,
    this.nameEn,
    this.nameAr,
  });

  factory SubCategoryGetRes.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryGetResFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryGetResToJson(this);
}

@JsonSerializable()
class Review {
  @JsonKey(name: 'user_id')
  final String userId;
  final String message;
  final num rate;
  @JsonKey(name: '_id')
  final String id;

  Review({
    required this.userId,
    required this.message,
    required this.rate,
    required this.id,
  });

  factory Review.fromJson(Map<String, dynamic> json) =>
      _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}