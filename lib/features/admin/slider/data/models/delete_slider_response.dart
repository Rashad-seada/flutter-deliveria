import 'package:freezed_annotation/freezed_annotation.dart';
part 'delete_slider_response.g.dart';

@JsonSerializable()
class DeleteSliderResponse {
  final String message;

  DeleteSliderResponse({required this.message});

  factory DeleteSliderResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteSliderResponseFromJson(json);
}
