import 'package:json_annotation/json_annotation.dart';

part 'items_category_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ItemsCategoryResponse {
  @JsonKey(name: 'itemCategories')
  final List<ItemCategory> itemCategories;

  ItemsCategoryResponse({required this.itemCategories});

  factory ItemsCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemsCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsCategoryResponseToJson(this);
}

@JsonSerializable()
class ItemCategory {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'name_en')
  final String nameEn;
  @JsonKey(name: 'name_ar')
  final String nameAr;
  @JsonKey(name: 'restaurant_id')
  final String restaurantId;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;

  ItemCategory({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.restaurantId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ItemCategory.fromJson(Map<String, dynamic> json) =>
      _$ItemCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ItemCategoryToJson(this);
}
