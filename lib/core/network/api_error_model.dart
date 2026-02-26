import 'package:json_annotation/json_annotation.dart';

part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final bool success;
  final String message;

  @JsonKey(name: 'error_code')
  final String? errorCode;

  final String? field;

  @JsonKey(name: 'missing_fields')
  final List<String>? missingFields;

  ApiErrorModel({
    required this.success,
    required this.message,
    this.errorCode,
    this.field,
    this.missingFields,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);
}
