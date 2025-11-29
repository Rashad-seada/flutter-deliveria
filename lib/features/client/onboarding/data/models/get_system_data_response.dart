import 'package:json_annotation/json_annotation.dart';

part 'get_system_data_response.g.dart';

@JsonSerializable()
class GetSystemDataResponse {
  final SystemDataResponse? response;

  GetSystemDataResponse({this.response});

  factory GetSystemDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GetSystemDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetSystemDataResponseToJson(this);
}

@JsonSerializable()
class SystemDataResponse {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'is_uploaded')
  final bool? isUploaded;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;

  SystemDataResponse({
    this.id,
    this.isUploaded,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SystemDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SystemDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SystemDataResponseToJson(this);
}
