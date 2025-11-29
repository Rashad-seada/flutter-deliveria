import 'package:json_annotation/json_annotation.dart';

part 'remove_cart_response.g.dart';

@JsonSerializable()
class RemoveCartResponse {
  final String? message;

  RemoveCartResponse({this.message});

  factory RemoveCartResponse.fromJson(Map<String, dynamic> json) =>
      _$RemoveCartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveCartResponseToJson(this);
}