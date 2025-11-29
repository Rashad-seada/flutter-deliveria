import 'package:json_annotation/json_annotation.dart';

part 'get_all_users_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GetAllUsersModel {
  final List<UserModelAdmin> users;

  GetAllUsersModel({required this.users});

  factory GetAllUsersModel.fromJson(Map<String, dynamic> json) =>
      _$GetAllUsersModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllUsersModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserModelAdmin {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String phone;
  final String email;
  final String password;
  final Coordinates? coordinates;
  @JsonKey(name: 'createdAt')
  final String createdAt;
  @JsonKey(name: 'updatedAt')
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;
  final bool ban;
  @JsonKey(name: 'address_id')
  final String? addressId;
  @JsonKey(
    name: 'number_of_orders',
    fromJson: _numberOfOrdersFromJson,
    toJson: _numberOfOrdersToJson,
  )
  final int numberOfOrders;

  UserModelAdmin({
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
    this.addressId,
    required this.numberOfOrders,
  });

  factory UserModelAdmin.fromJson(Map<String, dynamic> json) =>
      _$UserModelAdminFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelAdminToJson(this);

  static int _numberOfOrdersFromJson(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  static dynamic _numberOfOrdersToJson(int value) => value;
}

@JsonSerializable()
class Coordinates {
  final String latitude;
  final String longitude;

  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}
