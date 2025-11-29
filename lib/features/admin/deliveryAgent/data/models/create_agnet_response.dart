import 'package:json_annotation/json_annotation.dart';

part 'create_agnet_response.g.dart';

@JsonSerializable()
class CreateAgentResponse {
  final bool success;
  final String message;

  CreateAgentResponse({
    required this.success,
    required this.message,
  });

  factory CreateAgentResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateAgentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAgentResponseToJson(this);
}
