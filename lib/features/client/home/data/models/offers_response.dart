import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'offers_response.g.dart';

/// Response model for GET /restaurants/with_offers/:lat/:long
@JsonSerializable(explicitToJson: true)
class RestaurantsWithOffersResponse {
  final bool? success;
  final List<RestaurantWithOffers>? restaurants;

  RestaurantsWithOffersResponse({this.success, this.restaurants});

  factory RestaurantsWithOffersResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantsWithOffersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantsWithOffersResponseToJson(this);
}

@JsonSerializable()
class RestaurantWithOffers {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  @JsonKey(name: 'name_ar')
  final String? nameAr;
  final String? logo;
  final String? cover;
  final num? rating;
  @JsonKey(name: 'is_closed')
  final bool? isClosed;
  @JsonKey(name: 'is_open')
  final bool? isOpen;
  @JsonKey(name: 'has_offers')
  final bool? hasOffers;
  @JsonKey(name: 'offers_count')
  final int? offersCount;
  @JsonKey(name: 'max_discount')
  final num? maxDiscount;
  final num? distance;

  RestaurantWithOffers({
    this.id,
    this.name,
    this.nameAr,
    this.logo,
    this.cover,
    this.rating,
    this.isClosed,
    this.isOpen,
    this.hasOffers,
    this.offersCount,
    this.maxDiscount,
    this.distance,
  });

  factory RestaurantWithOffers.fromJson(Map<String, dynamic> json) =>
      _$RestaurantWithOffersFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantWithOffersToJson(this);

  /// Convert to ResturantAdmin for use with generic screens
  ResturantAdmin toResturantAdmin() {
    return ResturantAdmin(
      id: id ?? "",
      name: name ?? "",
      phone: "",
      aboutUs: "",
      rate: (rating ?? 4.5).toDouble(),
      deliveryCost: 0,
      locationMap: "",
      openHour: "",
      closeHour: "",
      haveDelivery: true,
      isShow: true,
      isShowInHome: true,
      createdAt: "",
      updatedAt: "",
      v: 0,
      isOpen: isOpen ?? true,
      photo: cover ?? logo ?? "",
      logo: logo ?? "",
      coordinates: Coordinates(latitude: 0.0, longitude: 0.0),
      superCategory: [],
      subCategory: [],
      reviews: [],
    );
  }
}

/// Response model for GET /restaurants/:id/offers
@JsonSerializable(explicitToJson: true)
class RestaurantOffersResponse {
  final bool? success;
  final RestaurantOfferInfo? restaurant;
  final List<OfferItem>? items;

  RestaurantOffersResponse({this.success, this.restaurant, this.items});

  factory RestaurantOffersResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantOffersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantOffersResponseToJson(this);
}

@JsonSerializable()
class RestaurantOfferInfo {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  @JsonKey(name: 'has_offers')
  final bool? hasOffers;

  RestaurantOfferInfo({this.id, this.name, this.hasOffers});

  factory RestaurantOfferInfo.fromJson(Map<String, dynamic> json) =>
      _$RestaurantOfferInfoFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantOfferInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OfferItem {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? description;
  final String? photo;
  final List<OfferItemSize>? sizes;
  final List<dynamic>? toppings;
  final bool? enable;

  OfferItem({
    this.id,
    this.name,
    this.description,
    this.photo,
    this.sizes,
    this.toppings,
    this.enable,
  });

  factory OfferItem.fromJson(Map<String, dynamic> json) =>
      _$OfferItemFromJson(json);

  Map<String, dynamic> toJson() => _$OfferItemToJson(this);
}

@JsonSerializable()
class OfferItemSize {
  final String? size;
  @JsonKey(name: 'price_before')
  final num? priceBefore;
  @JsonKey(name: 'price_after')
  final num? priceAfter;
  final num? offer;
  @JsonKey(name: 'has_offer')
  final bool? hasOffer;

  OfferItemSize({
    this.size,
    this.priceBefore,
    this.priceAfter,
    this.offer,
    this.hasOffer,
  });

  factory OfferItemSize.fromJson(Map<String, dynamic> json) =>
      _$OfferItemSizeFromJson(json);

  Map<String, dynamic> toJson() => _$OfferItemSizeToJson(this);
}

/// Response model for GET /restaurants/details/:id
@JsonSerializable(explicitToJson: true)
class RestaurantDetailsResponse {
  final bool? success;
  final RestaurantDetails? restaurant;

  RestaurantDetailsResponse({this.success, this.restaurant});

  factory RestaurantDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantDetailsResponseToJson(this);
}

@JsonSerializable()
class RestaurantDetails {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  @JsonKey(name: 'name_ar')
  final String? nameAr;
  final String? logo;
  final String? cover;
  final num? rating;
  @JsonKey(name: 'is_closed')
  final bool? isClosed;
  @JsonKey(name: 'has_offers')
  final bool? hasOffers;
  @JsonKey(name: 'offers_count')
  final int? offersCount;
  @JsonKey(name: 'max_discount')
  final num? maxDiscount;

  RestaurantDetails({
    this.id,
    this.name,
    this.nameAr,
    this.logo,
    this.cover,
    this.rating,
    this.isClosed,
    this.hasOffers,
    this.offersCount,
    this.maxDiscount,
  });

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantDetailsToJson(this);
}
