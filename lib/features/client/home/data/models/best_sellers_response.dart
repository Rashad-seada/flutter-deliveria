import 'package:json_annotation/json_annotation.dart';

part 'best_sellers_response.g.dart';

/// Response model for Best Sellers API
@JsonSerializable()
class BestSellersResponse {
  @JsonKey(name: 'success')
  final bool? success;
  
  @JsonKey(name: 'count')
  final int? count;
  
  @JsonKey(name: 'restaurants')
  final List<BestSellerRestaurant>? restaurants;

  BestSellersResponse({
    this.success,
    this.count,
    this.restaurants,
  });

  factory BestSellersResponse.fromJson(Map<String, dynamic> json) =>
      _$BestSellersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BestSellersResponseToJson(this);
}

/// Model for a Best Seller Restaurant
@JsonSerializable()
class BestSellerRestaurant {
  @JsonKey(name: '_id')
  final String? id;
  
  @JsonKey(name: 'name')
  final String? name;
  
  @JsonKey(name: 'logo')
  final String? logo;
  
  @JsonKey(name: 'photo')
  final String? photo;
  
  // Accept both 'rate' and 'rating' from API
  @JsonKey(name: 'rating')
  final num? rating;
  
  @JsonKey(name: 'rate')
  final num? rate;
  
  @JsonKey(name: 'open_hour')
  final String? openHour;
  
  @JsonKey(name: 'close_hour')
  final String? closeHour;
  
  @JsonKey(name: 'coordinates')
  final Coordinates? coordinates;
  
  @JsonKey(name: 'delivery_cost')
  final num? deliveryCost;
  
  @JsonKey(name: 'estimated_time')
  final int? estimatedTime;
  
  @JsonKey(name: 'have_delivery')
  final bool? haveDelivery;
  
  @JsonKey(name: 'about_us')
  final String? aboutUs;
  
  @JsonKey(name: 'total_orders')
  final int? totalOrders;
  
  @JsonKey(name: 'total_revenue')
  final num? totalRevenue;
  
  @JsonKey(name: 'is_open')
  final bool? isOpen;
  
  @JsonKey(name: 'distance')
  final num? distance;
  
  @JsonKey(name: 'is_nearby')
  final bool? isNearby;
  
  @JsonKey(name: 'rank')
  final int? rank;

  BestSellerRestaurant({
    this.id,
    this.name,
    this.logo,
    this.photo,
    this.rating,
    this.rate,
    this.openHour,
    this.closeHour,
    this.coordinates,
    this.deliveryCost,
    this.estimatedTime,
    this.haveDelivery,
    this.aboutUs,
    this.totalOrders,
    this.totalRevenue,
    this.isOpen,
    this.distance,
    this.isNearby,
    this.rank,
  });

  /// Returns the effective rating (prefers 'rating' over 'rate')
  double get effectiveRating => (rating ?? rate ?? 0).toDouble();

  factory BestSellerRestaurant.fromJson(Map<String, dynamic> json) =>
      _$BestSellerRestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$BestSellerRestaurantToJson(this);
}

/// Coordinates model
@JsonSerializable()
class Coordinates {
  @JsonKey(name: 'latitude')
  final num? latitude;
  
  @JsonKey(name: 'longitude')
  final num? longitude;

  Coordinates({this.latitude, this.longitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}
