import 'package:json_annotation/json_annotation.dart';

part 'add_to_fav_res.g.dart';

@JsonSerializable()
class AddToFavRes {
  final String message;
  final String favourite;

  AddToFavRes({
    required this.message,
    required this.favourite,
  });

  factory AddToFavRes.fromJson(Map<String, dynamic> json) =>
      _$AddToFavResFromJson(json);

  Map<String, dynamic> toJson() => _$AddToFavResToJson(this);
}