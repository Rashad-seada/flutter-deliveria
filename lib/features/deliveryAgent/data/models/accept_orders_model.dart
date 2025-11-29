import 'package:json_annotation/json_annotation.dart';

part 'accept_orders_model.g.dart';

@JsonSerializable()
class AcceptOrdersModel {
  final String? message;

  AcceptOrdersModel({this.message});

  factory AcceptOrdersModel.fromJson(Map<String, dynamic> json) =>
      _$AcceptOrdersModelFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptOrdersModelToJson(this);
}
