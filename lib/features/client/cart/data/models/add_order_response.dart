import 'package:json_annotation/json_annotation.dart';
part 'add_order_response.g.dart';

@JsonSerializable()
class AddOrderResponse {
  final bool success;
  final String message;

  AddOrderResponse({required this.success, required this.message});

  factory AddOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$AddOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddOrderResponseToJson(this);
}
