import 'package:json_annotation/json_annotation.dart';

part 'get_home_data_admin_response.g.dart';

@JsonSerializable()
class GetHomeDataAdminResponse {
  @JsonKey(name: 'total_orders')
  final int? totalOrders;

  @JsonKey(name: 'net_revenue')
  final num? netRevenue;

  @JsonKey(name: 'active_users')
  final int? activeUsers;

  @JsonKey(name: 'active_restaurants')
  final int? activeRestaurants;

  @JsonKey(name: 'total_amount')
  final num? totalAmount;

  @JsonKey(name: 'orders_today')
  final int? ordersToday;

  @JsonKey(name: 'oders_of_last_week')
  final List<int>? ordersOfLastWeek;

  GetHomeDataAdminResponse({
    this.totalOrders,
    this.netRevenue,
    this.activeUsers,
    this.activeRestaurants,
    this.totalAmount,
    this.ordersToday,
    this.ordersOfLastWeek,
  });

  factory GetHomeDataAdminResponse.fromJson(Map<String, dynamic> json) =>
      _$GetHomeDataAdminResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetHomeDataAdminResponseToJson(this);
}
