// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'super_categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperCategoriesResponse _$SuperCategoriesResponseFromJson(
        Map<String, dynamic> json) =>
    SuperCategoriesResponse(
      response: (json['response'] as List<dynamic>)
          .map((e) => SuperCategoryInSuper.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuperCategoriesResponseToJson(
        SuperCategoriesResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
    };

SuperCategoryInSuper _$SuperCategoryInSuperFromJson(
        Map<String, dynamic> json) =>
    SuperCategoryInSuper(
      id: json['_id'] as String,
      nameEn: json['name_en'] as String,
      nameAr: json['name_ar'] as String,
      logo: json['logo'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: (json['__v'] as num).toInt(),
      subCategories: (json['subCategories'] as List<dynamic>)
          .map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuperCategoryInSuperToJson(
        SuperCategoryInSuper instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
      'logo': instance.logo,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
      'subCategories': instance.subCategories,
    };

SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) => SubCategory(
      id: json['_id'] as String?,
      nameEn: json['name_en'] as String,
      nameAr: json['name_ar'] as String,
      superCategoryId: json['super_category_id'] as String,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SubCategoryToJson(SubCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
      'super_category_id': instance.superCategoryId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };
