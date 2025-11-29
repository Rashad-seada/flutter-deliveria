import 'package:json_annotation/json_annotation.dart';

part 'increase_item_cart_response.g.dart';

@JsonSerializable()
class IncreaseItemCartResponse {
  final bool? success;
  final String? message;
  final IncreaseItemCartData? data;

  IncreaseItemCartResponse({
    this.success,
    this.message,
    this.data,
  });

  factory IncreaseItemCartResponse.fromJson(Map<String, dynamic> json) =>
      _$IncreaseItemCartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IncreaseItemCartResponseToJson(this);
}

@JsonSerializable()
class IncreaseItemCartData {
  @JsonKey(name: 'item_id')
  final String? itemId;
  final String? size;
  final String? topping;
  @JsonKey(name: 'new_quantity')
  final int? newQuantity;

  IncreaseItemCartData({
    this.itemId,
    this.size,
    this.topping,
    this.newQuantity,
  });

  factory IncreaseItemCartData.fromJson(Map<String, dynamic> json) =>
      _$IncreaseItemCartDataFromJson(json);

  Map<String, dynamic> toJson() => _$IncreaseItemCartDataToJson(this);
}