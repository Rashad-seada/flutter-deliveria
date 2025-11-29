import 'package:json_annotation/json_annotation.dart';

part 'get_sliders_response.g.dart';

@JsonSerializable()
class GetSlidersResponse {
  final List<SliderModel> slider;

  GetSlidersResponse({required this.slider});

  factory GetSlidersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetSlidersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetSlidersResponseToJson(this);
}

@JsonSerializable()
class SliderModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'restaurant_id')
  final String restaurantId;
  final String image;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;

  SliderModel({
    required this.id,
    required this.restaurantId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) =>
      _$SliderModelFromJson(json);

  Map<String, dynamic> toJson() => _$SliderModelToJson(this);
}
