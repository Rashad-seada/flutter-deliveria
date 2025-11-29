import 'package:json_annotation/json_annotation.dart';
part 'create_resturant_response.g.dart';
@JsonSerializable()
class CreateResturantResponse {
  final String message;

  CreateResturantResponse({required this.message});

  factory CreateResturantResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateResturantResponseFromJson(json);
}
