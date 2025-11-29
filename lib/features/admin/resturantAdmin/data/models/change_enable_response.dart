import 'package:json_annotation/json_annotation.dart';
part 'change_enable_response.g.dart';
@JsonSerializable()
class ChangeEnableResponse {
  final String message;

  ChangeEnableResponse({required this.message});

  factory ChangeEnableResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangeEnableResponseFromJson(json);
}
