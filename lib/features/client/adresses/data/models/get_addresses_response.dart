import 'package:json_annotation/json_annotation.dart';

part 'get_addresses_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetAddressesResponse {
  final bool success;
  final List<AddressModel> address;

  GetAddressesResponse({
    required this.success,
    required this.address,
  });

  factory GetAddressesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAddressesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAddressesResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AddressModel {
  final Coordinates? coordinates;
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'address_title')
  final String addressTitle;
  final String phone;
  final String details;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;
  @JsonKey(name: 'is_default')
  final bool isDefault;

  AddressModel({
    this.coordinates,
    required this.id,
    required this.userId,
    required this.addressTitle,
    required this.phone,
    required this.details,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.isDefault = false,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}

@JsonSerializable()
class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}
