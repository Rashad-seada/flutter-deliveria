import 'package:delveria/features/ResturantOwner/menu/data/models/get_all_item_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchResponseItem {
  final List<ItemModelSearch> items;

  SearchResponseItem({required this.items});

  factory SearchResponseItem.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseItemFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResponseItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ItemModelSearch {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'restaurant_id')
  final String? restaurantId;

  final String? photo;
  final String name;
  final String? description;
  final bool? enable;

  @JsonKey(name: 'item_category')
  final String? itemCategory;

  @JsonKey(name: 'have_option')
  final bool? haveOption;

  final List<SizeModel>? sizes;
  final List<ToppingModel>? toppings;

  final String? createdAt;
  final String? updatedAt;

  @JsonKey(name: '__v')
  final int? v;

  ItemModelSearch({
    this.id,
    this.restaurantId,
    this.photo,
    required this.name,
    this.description,
    this.enable,
    this.itemCategory,
    this.haveOption,
    this.sizes,
    this.toppings,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ItemModelSearch.fromJson(Map<String, dynamic> json) =>
      _$ItemModelSearchFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelSearchToJson(this);
}

