import 'package:json_annotation/json_annotation.dart';

part 'payment_order_response.g.dart';

@JsonSerializable()
class PaymobOrderResponse {
  @JsonKey(name: 'id')
  final int? orderId;
  final String? status;

  PaymobOrderResponse({this.orderId, this.status});

  factory PaymobOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymobOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymobOrderResponseToJson(this);
}
