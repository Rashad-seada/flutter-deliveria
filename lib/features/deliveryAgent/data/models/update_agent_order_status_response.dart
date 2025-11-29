import 'package:json_annotation/json_annotation.dart';
part 'update_agent_order_status_response.g.dart';

@JsonSerializable()
class UpdateAgentOrderStatusResponse {
  final String message;

  UpdateAgentOrderStatusResponse({required this.message});

  factory UpdateAgentOrderStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateAgentOrderStatusResponseFromJson(json);
}
