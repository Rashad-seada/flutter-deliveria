import 'package:json_annotation/json_annotation.dart';
part 'edit_item_response.g.dart';
@JsonSerializable(explicitToJson: true)
class EditItemResponse {
  final String? message;

  EditItemResponse({this.message});

  factory EditItemResponse.fromJson(Map<String, dynamic> json) =>
      _$EditItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EditItemResponseToJson(this);
}
