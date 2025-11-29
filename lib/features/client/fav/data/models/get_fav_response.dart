import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_fav_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetFavResponse {
  final String? message;
  final FavResponseData? response;

  /// Was previously [List<String>? ids]. Now supports both [String] and [num] by parsing all to String.
  @JsonKey(fromJson: _idsFromJson, toJson: _idsToJson)
  final List<String>? ids;

  GetFavResponse({
    this.message,
    this.response,
    this.ids,
  });

  factory GetFavResponse.fromJson(Map<String, dynamic> json) =>
      _$GetFavResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetFavResponseToJson(this);

  static List<String>? _idsFromJson(dynamic ids) {
    if (ids == null) return null;
    if (ids is List) {
      return ids
          .map((e) =>
              // handles int, String, and any value that can be represented as string
              e?.toString() ?? '')
          .where((e) => e.isNotEmpty)
          .toList();
    }
    return null;
  }

  static dynamic _idsToJson(List<String>? ids) => ids;
}

@JsonSerializable(explicitToJson: true)
class FavResponseData {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'user_id')
  final String? userId;
  final List<FavouriteRestaurant>? favourites;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;

  FavResponseData({
    this.id,
    this.userId,
    this.favourites,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory FavResponseData.fromJson(Map<String, dynamic> json) =>
      _$FavResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$FavResponseDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FavouriteRestaurant {
  final Coordinates? coordinates;
  @JsonKey(name: '_id')
  final String? id;
  final String? photo;
  final String? logo;
  @JsonKey(name: 'super_category', fromJson: _stringOrListToListString, toJson: _listStringToJson)
  final List<String>? superCategory;
  @JsonKey(name: 'sub_category', fromJson: _stringOrListToListString, toJson: _listStringToJson)
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
  final int? rate;
  final List<Review>? reviews;
  @JsonKey(name: 'delivery_cost')
  final int? deliveryCost;
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
  final int? estimatedTime;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;

  FavouriteRestaurant({
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

  factory FavouriteRestaurant.fromJson(Map<String, dynamic> json) =>
      _$FavouriteRestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteRestaurantToJson(this);

  static List<String>? _stringOrListToListString(dynamic input) {
    if (input == null) {
      return null;
    }
    if (input is String) {
      // If the backend sends a single string instead of a list.
      return [input];
    }
    if (input is List) {
      // Handle both int and string IDs, convert all to strings.
      return input.map((e) => e?.toString() ?? '').where((e) => e.isNotEmpty).toList();
    }
    return null;
  }

  static dynamic _listStringToJson(List<String>? input) => input;
}

@JsonSerializable()
class Coordinates {
  final double? latitude;
  final double? longitude;

  Coordinates({
    this.latitude,
    this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}