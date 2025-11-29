import 'package:json_annotation/json_annotation.dart';

part 'create_slider_response.g.dart';

@JsonSerializable()
class CreateSliderResponse {
  final String? message;

  CreateSliderResponse({this.message});

  factory CreateSliderResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateSliderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSliderResponseToJson(this);
}
