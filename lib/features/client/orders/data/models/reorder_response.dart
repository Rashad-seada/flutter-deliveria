import 'package:json_annotation/json_annotation.dart';

part 'reorder_response.g.dart';

@JsonSerializable()
class ReorderResponse {
  final String? message;

  ReorderResponse({this.message});

  factory ReorderResponse.fromJson(Map<String, dynamic> json) =>
      _$ReorderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReorderResponseToJson(this);
}
