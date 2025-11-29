import 'package:json_annotation/json_annotation.dart';

part 'filter_item_category_response_user.g.dart';

@JsonSerializable(explicitToJson: true)
class FilterItemsCategoryResponseUser {
  final FilterItemsCategoryResponseUserData? response;

  FilterItemsCategoryResponseUser({this.response});

  factory FilterItemsCategoryResponseUser.fromJson(Map<String, dynamic> json) =>
      _$FilterItemsCategoryResponseUserFromJson(json);

  Map<String, dynamic> toJson() => _$FilterItemsCategoryResponseUserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FilterItemsCategoryResponseUserData {
  final RestaurantUser? restaurant;
  final List<ItemUser>? items;

  FilterItemsCategoryResponseUserData({this.restaurant, this.items});

  factory FilterItemsCategoryResponseUserData.fromJson(Map<String, dynamic> json) =>
      _$FilterItemsCategoryResponseUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$FilterItemsCategoryResponseUserDataToJson(this);
}

@JsonSerializable()
class RestaurantUser {
  final CoordinatesUser? coordinates;
  @JsonKey(name: '_id')
  final String? id;
  final String? photo;
  final String? logo;
  final List<String>? superCategory;
  final List<String>? subCategory;
  final String? name;
  final String? phone;
  @JsonKey(name: 'about_us')
  final String? aboutUs;
  final num? rate;
  final List<dynamic>? reviews;
  @JsonKey(name: 'delivery_cost')
  final num? deliveryCost;
  @JsonKey(name: 'loacation_map')
  final String? locationMap;
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
  @JsonKey(name: 'is_open')
  final bool? isOpen;

  RestaurantUser({
    this.coordinates,
    this.id,
    this.photo,
    this.logo,
    this.superCategory,
    this.subCategory,
    this.name,
    this.phone,
    this.aboutUs,
    this.rate,
    this.reviews,
    this.deliveryCost,
    this.locationMap,
    this.openHour,
    this.closeHour,
    this.haveDelivery,
    this.isShow,
    this.isShowInHome,
    this.estimatedTime,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isOpen,
  });

  factory RestaurantUser.fromJson(Map<String, dynamic> json) =>
      _$RestaurantUserFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantUserToJson(this);
}

@JsonSerializable()
class CoordinatesUser {
  final double? latitude;
  final double? longitude;

  CoordinatesUser({this.latitude, this.longitude});

  factory CoordinatesUser.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesUserFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesUserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ItemUser {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'restaurant_id')
  final String? restaurantId;
  final String? photo;
  final String? name;
  final String? description;
  @JsonKey(name: 'item_category')
  final String? itemCategory;
  final List<SizeUser>? sizes;
  final List<dynamic>? toppings;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;

  ItemUser({
    this.id,
    this.restaurantId,
    this.photo,
    this.name,
    this.description,
    this.itemCategory,
    this.sizes,
    this.toppings,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ItemUser.fromJson(Map<String, dynamic> json) =>
      _$ItemUserFromJson(json);

  Map<String, dynamic> toJson() => _$ItemUserToJson(this);
}

@JsonSerializable()
class SizeUser {
  final String? size;
  @JsonKey(name: 'price_before')
  final num? priceBefore;
  @JsonKey(name: 'price_after')
  final num? priceAfter;
  final num? offer;
  @JsonKey(name: '_id')
  final String? id;

  SizeUser({
    this.size,
    this.priceBefore,
    this.priceAfter,
    this.offer,
    this.id,
  });

  factory SizeUser.fromJson(Map<String, dynamic> json) =>
      _$SizeUserFromJson(json);

  Map<String, dynamic> toJson() => _$SizeUserToJson(this);
}
