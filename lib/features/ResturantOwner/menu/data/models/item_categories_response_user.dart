import 'package:json_annotation/json_annotation.dart';

part 'item_categories_response_user.g.dart';

@JsonSerializable(explicitToJson: true)
class ItemsCategoryResponseUser {
  @JsonKey(name: 'itemCategories')
  final List<ItemCategoryUser> itemCategories;

  ItemsCategoryResponseUser({required this.itemCategories});

  factory ItemsCategoryResponseUser.fromJson(Map<String, dynamic> json) =>
      _$ItemsCategoryResponseUserFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsCategoryResponseUserToJson(this);
}

@JsonSerializable()
class ItemCategoryUser {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name_en')
  final String nameEn;
  @JsonKey(name: 'name_ar')
  final String nameAr;
  @JsonKey(name: 'restaurant_id')
  final String restaurantId;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;

  ItemCategoryUser({
    this.id,
    required this.nameEn,
    required this.nameAr,
    required this.restaurantId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ItemCategoryUser.fromJson(Map<String, dynamic> json) =>
      _$ItemCategoryUserFromJson(json);

  Map<String, dynamic> toJson() => _$ItemCategoryUserToJson(this);
}
