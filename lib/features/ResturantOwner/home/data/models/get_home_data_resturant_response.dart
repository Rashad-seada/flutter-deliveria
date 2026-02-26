import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_home_data_resturant_response.freezed.dart';
part 'get_home_data_resturant_response.g.dart';

@freezed
class GetHomeDataResturantResponse with _$GetHomeDataResturantResponse {
  const factory GetHomeDataResturantResponse({
    @JsonKey(name: 'response') required HomeDataResponse response,
  }) = _GetHomeDataResturantResponse;

  factory GetHomeDataResturantResponse.fromJson(Map<String, dynamic> json) =>
      _$GetHomeDataResturantResponseFromJson(json);
}

@freezed
class HomeDataResponse with _$HomeDataResponse {
  const factory HomeDataResponse({
    @JsonKey(name: 'restaurant') required RestaurantHomeInfo restaurant,
    // orders_of_last_week is likely here at the root of 'response'
    @JsonKey(name: 'orders_of_last_week') List<int>? ordersOfLastWeek,
    // Add these just in case, but they seem to be 0 in the log
    @JsonKey(name: 'total_orders') int? totalOrders,
    @JsonKey(name: 'total_revenue') num? totalRevenue,
    @JsonKey(name: 'average_rating') double? averageRating,
  }) = _HomeDataResponse;

  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);
}

@freezed
class RestaurantHomeInfo with _$RestaurantHomeInfo {
  const factory RestaurantHomeInfo({
    @JsonKey(name: 'statistics') required RestaurantStatistics statistics,
    // We can add other fields if needed, but statistics is what we need for now
  }) = _RestaurantHomeInfo;

  factory RestaurantHomeInfo.fromJson(Map<String, dynamic> json) =>
      _$RestaurantHomeInfoFromJson(json);
}

@freezed
class RestaurantStatistics with _$RestaurantStatistics {
  const factory RestaurantStatistics({
    @JsonKey(name: 'total_orders') required int totalOrders,
    @JsonKey(name: 'total_revenue') required num totalRevenue,
    @JsonKey(name: 'average_rating') required num averageRating,
  }) = _RestaurantStatistics;

  factory RestaurantStatistics.fromJson(Map<String, dynamic> json) =>
      _$RestaurantStatisticsFromJson(json);
}