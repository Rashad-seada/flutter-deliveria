 import 'package:json_annotation/json_annotation.dart';

part 'add_cart_response.g.dart';

@JsonSerializable()
class AddCartResponse {
  final String? message;

  AddCartResponse({this.message});

  factory AddCartResponse.fromJson(Map<String, dynamic> json) =>
      _$AddCartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddCartResponseToJson(this);
}