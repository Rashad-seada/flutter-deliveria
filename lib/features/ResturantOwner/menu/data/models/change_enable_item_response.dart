import 'package:json_annotation/json_annotation.dart';

part 'change_enable_item_response.g.dart';

@JsonSerializable()
class ChangeEnableItemResponse {
  @JsonKey(name: 'message')
  final String? message;

  ChangeEnableItemResponse({this.message});

  factory ChangeEnableItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangeEnableItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeEnableItemResponseToJson(this);
}
