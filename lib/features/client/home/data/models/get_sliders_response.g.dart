// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_sliders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSlidersResponse _$GetSlidersResponseFromJson(Map<String, dynamic> json) =>
    GetSlidersResponse(
      slider:
          (json['slider'] as List<dynamic>)
              .map((e) => SliderModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$GetSlidersResponseToJson(GetSlidersResponse instance) =>
    <String, dynamic>{'slider': instance.slider};

SliderModel _$SliderModelFromJson(Map<String, dynamic> json) => SliderModel(
  id: json['_id'] as String,
  restaurantId: json['restaurant_id'] as String,
  image: json['image'] as String,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  v: (json['__v'] as num).toInt(),
);

Map<String, dynamic> _$SliderModelToJson(SliderModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'restaurant_id': instance.restaurantId,
      'image': instance.image,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };
