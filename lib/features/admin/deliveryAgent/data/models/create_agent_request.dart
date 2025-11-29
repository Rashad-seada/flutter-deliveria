import 'package:freezed_annotation/freezed_annotation.dart';
part 'create_agent_request.g.dart';
@JsonSerializable()
class CreateAgentRequest {
  final String name;
  final String phone;
  final String password;

  CreateAgentRequest({
    required this.name,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$CreateAgentRequestToJson(this);
}
