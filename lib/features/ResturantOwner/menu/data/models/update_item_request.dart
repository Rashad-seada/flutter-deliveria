import 'package:json_annotation/json_annotation.dart';

part 'update_item_request.g.dart';

@JsonSerializable()
class UpdateItemRequest {
  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "description")
  final String? description;

  @JsonKey(name: "price")
  final double? price;

  @JsonKey(name: "category_id")
  final String? categoryId;

  @JsonKey(name: "is_available")
  final bool? isAvailable;

  @JsonKey(name: "discount_percentage")
  final double? discountPercentage;

  UpdateItemRequest({
    this.name,
    this.description,
    this.price,
    this.categoryId,
    this.isAvailable,
    this.discountPercentage,
  });

  factory UpdateItemRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateItemRequestToJson(this);
}
