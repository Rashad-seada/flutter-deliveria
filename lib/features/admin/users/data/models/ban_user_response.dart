import 'package:json_annotation/json_annotation.dart';

part 'ban_user_response.g.dart';

@JsonSerializable()
class BanUserResponse {
  final String message;
  final bool ban;

  BanUserResponse({
    required this.message,
    required this.ban,
  });

  factory BanUserResponse.fromJson(Map<String, dynamic> json) =>
      _$BanUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BanUserResponseToJson(this);
}
