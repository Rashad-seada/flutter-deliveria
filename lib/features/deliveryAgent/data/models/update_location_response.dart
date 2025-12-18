import 'package:json_annotation/json_annotation.dart';

part 'update_location_response.g.dart';

@JsonSerializable()
class UpdateLocationResponse {
  final bool success;
  final Map<String, dynamic>? location;

  UpdateLocationResponse({
    required this.success,
    this.location,
  });

  factory UpdateLocationResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateLocationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateLocationResponseToJson(this);
}
