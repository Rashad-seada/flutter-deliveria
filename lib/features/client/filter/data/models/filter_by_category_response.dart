import 'package:json_annotation/json_annotation.dart';

part 'filter_by_category_response.g.dart';

@JsonSerializable(explicitToJson: true)
class FilterbyCategoryResponse {
  final List<RestaurantByCategory> response;

  FilterbyCategoryResponse({required this.response});

  factory FilterbyCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$FilterbyCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FilterbyCategoryResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RestaurantByCategory {
  final Coordinates coordinates;
  @JsonKey(name: '_id')
  final String id;
  final String photo;
  final String logo;
  @JsonKey(name: 'super_category')
  final SuperCategory superCategory;
  @JsonKey(name: 'sub_category')
  final SubCategory subCategory;
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

  RestaurantByCategory({
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

  factory RestaurantByCategory.fromJson(Map<String, dynamic> json) {
    // Defensive parsing for booleans and numbers
    bool parseBool(dynamic value) {
      if (value is bool) return value;
      if (value == null) return false;
      if (value is int) return value != 0;
      if (value is String) return value.toLowerCase() == 'true' || value == '1';
      return false;
    }

    num parseNum(dynamic value) {
      if (value is num) return value;
      if (value is String) return num.tryParse(value) ?? 0;
      if (value is int) return value;
      if (value is double) return value;
      return 0;
    }

    List<dynamic> parseReviews(dynamic value) {
      if (value is List) return value;
      return [];
    }

    return RestaurantByCategory(
      coordinates: json['coordinates'] is Map<String, dynamic>
          ? Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>)
          : Coordinates(latitude: 0, longitude: 0),
      id: json['_id']?.toString() ?? '',
      photo: json['photo']?.toString() ?? '',
      logo: json['logo']?.toString() ?? '',
      superCategory: json['super_category'] is Map<String, dynamic>
          ? SuperCategory.fromJson(json['super_category'] as Map<String, dynamic>)
          : SuperCategory(id: '', nameEn: '', nameAr: '', logo: ''),
      subCategory: json['sub_category'] is Map<String, dynamic>
          ? SubCategory.fromJson(json['sub_category'] as Map<String, dynamic>)
          : SubCategory(id: '', nameEn: '', nameAr: ''),
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      aboutUs: json['about_us']?.toString() ?? '',
      rate: parseNum(json['rate']),
      reviews: parseReviews(json['reviews']),
      deliveryCost: parseNum(json['delivery_cost']),
      loacationMap: json['loacation_map']?.toString() ?? '',
      openHour: json['open_hour']?.toString() ?? '',
      closeHour: json['close_hour']?.toString() ?? '',
      haveDelivery: parseBool(json['have_delivery']),
      isShow: parseBool(json['is_show']),
      isShowInHome: parseBool(json['is_show_in_home']),
      estimatedTime: parseNum(json['estimated_time']),
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      v: parseNum(json['__v']).toInt(),
      isOpen: parseBool(json['is_open']),
      isNearby: parseBool(json['is_nearby']),
    );
  }

  Map<String, dynamic> toJson() => _$RestaurantByCategoryToJson(this);
}

@JsonSerializable()
class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: (json['latitude'] is num)
            ? (json['latitude'] as num).toDouble()
            : double.tryParse(json['latitude']?.toString() ?? '') ?? 0.0,
        longitude: (json['longitude'] is num)
            ? (json['longitude'] as num).toDouble()
            : double.tryParse(json['longitude']?.toString() ?? '') ?? 0.0,
      );

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

  factory SuperCategory.fromJson(Map<String, dynamic> json) => SuperCategory(
        id: json['_id']?.toString() ?? '',
        nameEn: json['name_en']?.toString() ?? '',
        nameAr: json['name_ar']?.toString() ?? '',
        logo: json['logo']?.toString() ?? '',
      );

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

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json['_id']?.toString() ?? '',
        nameEn: json['name_en']?.toString() ?? '',
        nameAr: json['name_ar']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}