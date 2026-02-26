import 'package:json_annotation/json_annotation.dart';

part 'loyalty_history_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LoyaltyHistoryResponse {
  final bool? success;
  final LoyaltyHistoryData? data;

  LoyaltyHistoryResponse({this.success, this.data});

  factory LoyaltyHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoyaltyHistoryResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoyaltyHistoryData {
  final List<PointsTransaction>? transactions;
  final Pagination? pagination;

  LoyaltyHistoryData({this.transactions, this.pagination});

  factory LoyaltyHistoryData.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyHistoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoyaltyHistoryDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PointsTransaction {
  @JsonKey(name: '_id')
  final String? id;
  final String? type; // 'earn', 'redeem', 'expire', 'admin_adjust'
  final int? points;
  final int? balance;
  final String? description;
  final OrderRef? orderId;
  final String? createdAt;

  PointsTransaction({
    this.id,
    this.type,
    this.points,
    this.balance,
    this.description,
    this.orderId,
    this.createdAt,
  });

  factory PointsTransaction.fromJson(Map<String, dynamic> json) =>
      _$PointsTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$PointsTransactionToJson(this);
}

@JsonSerializable()
class OrderRef {
  @JsonKey(name: 'order_id')
  final int? orderId;

  OrderRef({this.orderId});

  factory OrderRef.fromJson(Map<String, dynamic> json) =>
      _$OrderRefFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRefToJson(this);
}

@JsonSerializable()
class Pagination {
  final int? page;
  final int? limit;
  final int? total;
  final int? pages;

  Pagination({this.page, this.limit, this.total, this.pages});

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
