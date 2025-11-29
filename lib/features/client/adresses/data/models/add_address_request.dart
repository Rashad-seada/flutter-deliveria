import 'package:json_annotation/json_annotation.dart';

part 'add_address_request.g.dart';

@JsonSerializable()
class AddAddressRequest {
  @JsonKey(name: 'address_title')
  final String addressTitle;

  final String phone;
  final String details;
  final String latitude;
  final String longitude;

  @JsonKey(name: 'default')
  final bool isDefault;

  AddAddressRequest({
    required this.addressTitle,
    required this.phone,
    required this.details,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
  });


  Map<String, dynamic> toJson() => _$AddAddressRequestToJson(this);
}

