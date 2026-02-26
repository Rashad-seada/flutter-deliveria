import 'package:json_annotation/json_annotation.dart';

part 'validate_code_response.g.dart';

@JsonSerializable()
class ValidateCodeResponse {
  final bool? success;
  final ValidateCodeData? data;
  final String? message;

  ValidateCodeResponse({this.success, this.data, this.message});

  factory ValidateCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$ValidateCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateCodeResponseToJson(this);
}

@JsonSerializable()
class ValidateCodeData {
  final String? code;
  final num? discountValue;
  final String? discountType;
  final num? maxDiscount;
  final String? tierName;

  ValidateCodeData({
    this.code,
    this.discountValue,
    this.discountType,
    this.maxDiscount,
    this.tierName,
  });

  factory ValidateCodeData.fromJson(Map<String, dynamic> json) =>
      _$ValidateCodeDataFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateCodeDataToJson(this);
}
