import 'package:json_annotation/json_annotation.dart';

part 'sort_by_price.g.dart';

@JsonSerializable(explicitToJson: true)
class SortByPriceResponse {
  final List<SortByPriceItem> response;

  SortByPriceResponse({required this.response});

  factory SortByPriceResponse.fromJson(Map<String, dynamic> json) =>
      _$SortByPriceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SortByPriceResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SortByPriceItem {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'restaurant_id')
  final String restaurantId;
  final String photo;
  final String name;
  final String description;
  final List<ItemSize> sizes;
  final List<ItemTopping> toppings;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;

  SortByPriceItem({
    required this.id,
    required this.restaurantId,
    required this.photo,
    required this.name,
    required this.description,
    required this.sizes,
    required this.toppings,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SortByPriceItem.fromJson(Map<String, dynamic> json) =>
      _$SortByPriceItemFromJson(json);

  Map<String, dynamic> toJson() => _$SortByPriceItemToJson(this);
}

@JsonSerializable()
class ItemSize {
  final String size;
  @JsonKey(name: 'price_before', fromJson: _numFromJson, toJson: _numToJson)
  final num priceBefore;
  @JsonKey(name: 'price_after', fromJson: _numFromJson, toJson: _numToJson)
  final num priceAfter;
  @JsonKey(fromJson: _numFromJson, toJson: _numToJson)
  final num offer;
  @JsonKey(name: '_id')
  final String id;

  ItemSize({
    required this.size,
    required this.priceBefore,
    required this.priceAfter,
    required this.offer,
    required this.id,
  });

  factory ItemSize.fromJson(Map<String, dynamic> json) =>
      _$ItemSizeFromJson(json);

  Map<String, dynamic> toJson() => _$ItemSizeToJson(this);

  static num _numFromJson(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value;
    if (value is String) return num.tryParse(value) ?? 0;
    return 0;
  }

  static dynamic _numToJson(num value) => value;
}

@JsonSerializable()
class ItemTopping {
  final String topping;
  @JsonKey(fromJson: ItemSize._numFromJson, toJson: ItemSize._numToJson)
  final num price;
  @JsonKey(name: '_id')
  final String id;

  ItemTopping({
    required this.topping,
    required this.price,
    required this.id,
  });

  factory ItemTopping.fromJson(Map<String, dynamic> json) =>
      _$ItemToppingFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToppingToJson(this);
}