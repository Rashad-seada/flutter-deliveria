 import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_home_data_resturant_response.freezed.dart';
part 'get_home_data_resturant_response.g.dart';

@freezed
class GetHomeDataResturantResponse with _$GetHomeDataResturantResponse {
  const factory GetHomeDataResturantResponse({
    @JsonKey(name: 'total_orders') required int totalOrders,
    @JsonKey(name: 'net_revenue') required num netRevenue,
    @JsonKey(name: 'customer_feedback') required double customerFeedback,
    @JsonKey(name: 'oders_of_last_week') required List<int> ordersOfLastWeek,
  }) = _GetHomeDataResturantResponse;

  factory GetHomeDataResturantResponse.fromJson(Map<String, dynamic> json) =>
      _$GetHomeDataResturantResponseFromJson(json);
}