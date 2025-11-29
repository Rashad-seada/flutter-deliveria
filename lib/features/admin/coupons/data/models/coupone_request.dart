import 'package:json_annotation/json_annotation.dart';

part 'coupone_request.g.dart';

@JsonSerializable()
class CouponeRequest {
  final String restaurant;
  final String code;
  final int discount;
  @JsonKey(name: 'expired_date')
  final String expiredDate;
    @JsonKey(name: 'number_enable')

  final String numberEnable;

  CouponeRequest( {
    required this.numberEnable,
    required this.restaurant,
    required this.code,
    required this.discount,
    required this.expiredDate,
  });



  Map<String, dynamic> toJson() => _$CouponeRequestToJson(this);
}