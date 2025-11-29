import 'package:json_annotation/json_annotation.dart';

part 'delete_address_response.g.dart';

@JsonSerializable()
class DeleteAddressResponse {
  final bool success;
  final String message;

  DeleteAddressResponse({
    required this.success,
    required this.message,
  });

  factory DeleteAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteAddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteAddressResponseToJson(this);
}