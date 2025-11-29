import 'package:json_annotation/json_annotation.dart';

part 'decrease_item_cart_response.g.dart';

@JsonSerializable(explicitToJson: true)
class DecreaseItemCartResponse {
  final bool success;
  final String message;
  final DecreaseItemCartData? data;

  DecreaseItemCartResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory DecreaseItemCartResponse.fromJson(Map<String, dynamic> json) =>
      _$DecreaseItemCartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DecreaseItemCartResponseToJson(this);
}

@JsonSerializable()
class DecreaseItemCartData {
  @JsonKey(name: 'item_id')
  final String? itemId;

  final String? size;

  final String? topping;

  @JsonKey(name: 'new_quantity')
  final int? newQuantity;

  DecreaseItemCartData({
    this.itemId,
    this.size,
    this.topping,
    this.newQuantity,
  });

  factory DecreaseItemCartData.fromJson(Map<String, dynamic> json) =>
      _$DecreaseItemCartDataFromJson(json);

  Map<String, dynamic> toJson() => _$DecreaseItemCartDataToJson(this);
}