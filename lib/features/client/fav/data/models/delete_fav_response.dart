import 'package:json_annotation/json_annotation.dart';

part 'delete_fav_response.g.dart';

@JsonSerializable()
class DeleteFavResponse {
  final String? message;
  final String? favourite;

  DeleteFavResponse({
    this.message,
    this.favourite,
  });

  factory DeleteFavResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteFavResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteFavResponseToJson(this);
}