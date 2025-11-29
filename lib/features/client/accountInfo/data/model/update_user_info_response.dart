import 'package:freezed_annotation/freezed_annotation.dart';
part 'update_user_info_response.g.dart';
@JsonSerializable()
class UpdateUserInfoResponse {
  final String message;

  UpdateUserInfoResponse({required this.message});

  factory UpdateUserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserInfoResponseFromJson(json);
}
