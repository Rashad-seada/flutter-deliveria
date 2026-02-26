// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllItemsResponse _$GetAllItemsResponseFromJson(Map<String, dynamic> json) =>
    GetAllItemsResponse(
      response: json['response'] == null
          ? null
          : GetAllItemsResponseData.fromJson(
              json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetAllItemsResponseToJson(
        GetAllItemsResponse instance) =>
    <String, dynamic>{
      'response': instance.response?.toJson(),
    };

GetAllItemsResponseData _$GetAllItemsResponseDataFromJson(
        Map<String, dynamic> json) =>
    GetAllItemsResponseData(
      restaurant: json['restaurant'] == null
          ? null
          : RestaurantModel.fromJson(
              json['restaurant'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllItemsResponseDataToJson(
        GetAllItemsResponseData instance) =>
    <String, dynamic>{
      'restaurant': instance.restaurant?.toJson(),
      'items': instance.items?.map((e) => e.toJson()).toList(),
    };

RestaurantModel _$RestaurantModelFromJson(Map<String, dynamic> json) =>
    RestaurantModel(
      coordinates: json['coordinates'] == null
          ? null
          : CoordinatesModel.fromJson(
              json['coordinates'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      photo: json['photo'] as String?,
      logo: json['logo'] as String?,
      superCategory: (json['super_category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      subCategory: (json['sub_category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      aboutUs: json['about_us'] as String?,
      rate: json['rate'] as num?,
      reviews: json['reviews'] as List<dynamic>?,
      deliveryCost: json['delivery_cost'] as num?,
      loacationMap: json['loacation_map'] as String?,
      openHour: json['open_hour'] as String?,
      closeHour: json['close_hour'] as String?,
      haveDelivery: json['have_delivery'] as bool?,
      isShow: json['is_show'] as bool?,
      isShowInHome: json['is_show_in_home'] as bool?,
      estimatedTime: json['estimated_time'] as num?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
      isOpen: json['is_open'] as bool?,
    );

Map<String, dynamic> _$RestaurantModelToJson(RestaurantModel instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates?.toJson(),
      '_id': instance.id,
      'photo': instance.photo,
      'logo': instance.logo,
      'super_category': instance.superCategory,
      'sub_category': instance.subCategory,
      'name': instance.name,
      'phone': instance.phone,
      'about_us': instance.aboutUs,
      'rate': instance.rate,
      'reviews': instance.reviews,
      'delivery_cost': instance.deliveryCost,
      'loacation_map': instance.loacationMap,
      'open_hour': instance.openHour,
      'close_hour': instance.closeHour,
      'have_delivery': instance.haveDelivery,
      'is_show': instance.isShow,
      'is_show_in_home': instance.isShowInHome,
      'estimated_time': instance.estimatedTime,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
      'is_open': instance.isOpen,
    };

CoordinatesModel _$CoordinatesModelFromJson(Map<String, dynamic> json) =>
    CoordinatesModel(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CoordinatesModelToJson(CoordinatesModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      id: json['_id'] as String?,
      restaurantId: json['restaurant_id'] as String?,
      photo: json['photo'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      sizes: (json['sizes'] as List<dynamic>?)
          ?.map((e) => SizeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      toppings: (json['toppings'] as List<dynamic>?)
          ?.map((e) => ToppingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
      enable: json['enable'] as bool?,
      haveOption: json['have_option'] as bool?,
      isBestSeller: json['is_best_seller'] as bool?,
      itemCategory: json['item_category'] as String?,
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      '_id': instance.id,
      'restaurant_id': instance.restaurantId,
      'photo': instance.photo,
      'name': instance.name,
      'description': instance.description,
      'sizes': instance.sizes?.map((e) => e.toJson()).toList(),
      'toppings': instance.toppings?.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
      'enable': instance.enable,
      'have_option': instance.haveOption,
      'is_best_seller': instance.isBestSeller,
      'item_category': instance.itemCategory,
    };

SizeModel _$SizeModelFromJson(Map<String, dynamic> json) => SizeModel(
      size: json['size'] as String?,
      priceBefore: json['price_before'] as num?,
      priceAfter: json['price_after'] as num?,
      offer: json['offer'] as num?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$SizeModelToJson(SizeModel instance) => <String, dynamic>{
      'size': instance.size,
      'price_before': instance.priceBefore,
      'price_after': instance.priceAfter,
      'offer': instance.offer,
      '_id': instance.id,
    };

ToppingModel _$ToppingModelFromJson(Map<String, dynamic> json) => ToppingModel(
      topping: json['topping'] as String?,
      price: json['price'] as num?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$ToppingModelToJson(ToppingModel instance) =>
    <String, dynamic>{
      'topping': instance.topping,
      'price': instance.price,
      '_id': instance.id,
    };
