import 'package:json_annotation/json_annotation.dart';

part 'get_user_data_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetUserDataResponse {
  final UserModel? user;

  GetUserDataResponse({required this.user});

  factory GetUserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserDataResponseToJson(this);
}

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String phone;
  final String email;
  final String password;
  // coordinates is not present in the response, so make it optional
  final Coordinates? coordinates;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;
  final bool ban;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
    this.coordinates,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.ban,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class Coordinates {
  final String? latitude;
  final String? longitude;

  Coordinates({
    this.latitude,
    this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}
