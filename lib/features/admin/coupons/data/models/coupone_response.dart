import 'package:json_annotation/json_annotation.dart';
part 'coupone_response.g.dart';
@JsonSerializable()
class CouponeResponse {
  final String message;

  CouponeResponse({required this.message});

  factory CouponeResponse.fromJson(Map<String, dynamic> json) =>
      _$CouponeResponseFromJson(json);
}
