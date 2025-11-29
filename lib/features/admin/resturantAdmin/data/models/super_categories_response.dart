
import 'package:json_annotation/json_annotation.dart';

part 'super_categories_response.g.dart';

@JsonSerializable()
class SuperCategoriesResponse {
  final List<SuperCategoryInSuper> response;

  SuperCategoriesResponse({required this.response});

  factory SuperCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$SuperCategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SuperCategoriesResponseToJson(this);
}

@JsonSerializable()
class SuperCategoryInSuper {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'name_en')
  final String nameEn;
  @JsonKey(name: 'name_ar')
  final String nameAr;
  final String logo;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;
  final List<SubCategory> subCategories;

  SuperCategoryInSuper({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.logo,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.subCategories,
  });

  factory SuperCategoryInSuper.fromJson(Map<String, dynamic> json) =>
      _$SuperCategoryInSuperFromJson(json);

  Map<String, dynamic> toJson() => _$SuperCategoryInSuperToJson(this);
}

@JsonSerializable()
class SubCategory {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name_en')
  final String nameEn;
  @JsonKey(name: 'name_ar')
  final String nameAr;
  @JsonKey(name: 'super_category_id')
  final String superCategoryId;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;

  SubCategory({
    this.id,
    required this.nameEn,
    required this.nameAr,
    required this.superCategoryId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}