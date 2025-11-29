import 'package:json_annotation/json_annotation.dart';
part 'sign_up_response.g.dart';
@JsonSerializable()
class SignUpResponse {
  final bool success;
  final String message;

  SignUpResponse({required this.success, required this.message});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);
}
