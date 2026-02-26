import 'package:json_annotation/json_annotation.dart';

part 'get_all_item_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetAllItemsResponse {
  final GetAllItemsResponseData? response;

  GetAllItemsResponse({this.response});

  factory GetAllItemsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllItemsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllItemsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetAllItemsResponseData {
  final RestaurantModel? restaurant;
  final List<ItemModel>? items;

  GetAllItemsResponseData({this.restaurant, this.items});

  factory GetAllItemsResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetAllItemsResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllItemsResponseDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RestaurantModel {
  final CoordinatesModel? coordinates;
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
  @JsonKey(name: 'about_us')
  final String? aboutUs;
  final num? rate;
  final List<dynamic>? reviews;
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
  @JsonKey(name: 'is_open')
  final bool? isOpen;

  RestaurantModel({
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
    this.isOpen,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
}

@JsonSerializable()
class CoordinatesModel {
  final double? latitude;
  final double? longitude;

  CoordinatesModel({this.latitude, this.longitude});

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ItemModel {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'restaurant_id')
  final String? restaurantId;
  final String? photo;
  final String? name;
  final String? description;
  final List<SizeModel>? sizes;
  final List<ToppingModel>? toppings;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'enable')
  final bool? enable;
  @JsonKey(name: 'have_option')
  final bool? haveOption;
  @JsonKey(name: 'is_best_seller')
  final bool? isBestSeller;
  @JsonKey(name: 'item_category')
  final String? itemCategory;

  ItemModel({
    this.id,
    this.restaurantId,
    this.photo,
    this.name,
    this.description,
    this.sizes,
    this.toppings,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.enable,
    this.haveOption,
    this.isBestSeller,
    this.itemCategory,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}

@JsonSerializable()
class SizeModel {
  final String? size;
  @JsonKey(name: 'price_before')
  final num? priceBefore;
  @JsonKey(name: 'price_after')
  final num? priceAfter;
  final num? offer;
  @JsonKey(name: '_id')
  final String? id;

  SizeModel({
    this.size,
    this.priceBefore,
    this.priceAfter,
    this.offer,
    this.id,
  });

  factory SizeModel.fromJson(Map<String, dynamic> json) =>
      _$SizeModelFromJson(json);

  Map<String, dynamic> toJson() => _$SizeModelToJson(this);
}

@JsonSerializable()
class ToppingModel {
  final String? topping;
  final num? price;
  @JsonKey(name: '_id')
  final String? id;

  ToppingModel({
    this.topping,
    this.price,
    this.id,
  });

  factory ToppingModel.fromJson(Map<String, dynamic> json) =>
      _$ToppingModelFromJson(json);

  Map<String, dynamic> toJson() => _$ToppingModelToJson(this);
}
