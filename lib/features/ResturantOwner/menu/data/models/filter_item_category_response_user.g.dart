// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_item_category_response_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterItemsCategoryResponseUser _$FilterItemsCategoryResponseUserFromJson(
        Map<String, dynamic> json) =>
    FilterItemsCategoryResponseUser(
      response: json['response'] == null
          ? null
          : FilterItemsCategoryResponseUserData.fromJson(
              json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FilterItemsCategoryResponseUserToJson(
        FilterItemsCategoryResponseUser instance) =>
    <String, dynamic>{
      'response': instance.response?.toJson(),
    };

FilterItemsCategoryResponseUserData
    _$FilterItemsCategoryResponseUserDataFromJson(Map<String, dynamic> json) =>
        FilterItemsCategoryResponseUserData(
          restaurant: json['restaurant'] == null
              ? null
              : RestaurantUser.fromJson(
                  json['restaurant'] as Map<String, dynamic>),
          items: (json['items'] as List<dynamic>?)
              ?.map((e) => ItemUser.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$FilterItemsCategoryResponseUserDataToJson(
        FilterItemsCategoryResponseUserData instance) =>
    <String, dynamic>{
      'restaurant': instance.restaurant?.toJson(),
      'items': instance.items?.map((e) => e.toJson()).toList(),
    };

RestaurantUser _$RestaurantUserFromJson(Map<String, dynamic> json) =>
    RestaurantUser(
      coordinates: json['coordinates'] == null
          ? null
          : CoordinatesUser.fromJson(
              json['coordinates'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      photo: json['photo'] as String?,
      logo: json['logo'] as String?,
      superCategory: (json['superCategory'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      subCategory: (json['subCategory'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      aboutUs: json['about_us'] as String?,
      rate: json['rate'] as num?,
      reviews: json['reviews'] as List<dynamic>?,
      deliveryCost: json['delivery_cost'] as num?,
      locationMap: json['loacation_map'] as String?,
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

Map<String, dynamic> _$RestaurantUserToJson(RestaurantUser instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates,
      '_id': instance.id,
      'photo': instance.photo,
      'logo': instance.logo,
      'superCategory': instance.superCategory,
      'subCategory': instance.subCategory,
      'name': instance.name,
      'phone': instance.phone,
      'about_us': instance.aboutUs,
      'rate': instance.rate,
      'reviews': instance.reviews,
      'delivery_cost': instance.deliveryCost,
      'loacation_map': instance.locationMap,
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

CoordinatesUser _$CoordinatesUserFromJson(Map<String, dynamic> json) =>
    CoordinatesUser(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CoordinatesUserToJson(CoordinatesUser instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

ItemUser _$ItemUserFromJson(Map<String, dynamic> json) => ItemUser(
      id: json['_id'] as String?,
      restaurantId: json['restaurant_id'] as String?,
      photo: json['photo'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      itemCategory: json['item_category'] as String?,
      sizes: (json['sizes'] as List<dynamic>?)
          ?.map((e) => SizeUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      toppings: json['toppings'] as List<dynamic>?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ItemUserToJson(ItemUser instance) => <String, dynamic>{
      '_id': instance.id,
      'restaurant_id': instance.restaurantId,
      'photo': instance.photo,
      'name': instance.name,
      'description': instance.description,
      'item_category': instance.itemCategory,
      'sizes': instance.sizes?.map((e) => e.toJson()).toList(),
      'toppings': instance.toppings,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };

SizeUser _$SizeUserFromJson(Map<String, dynamic> json) => SizeUser(
      size: json['size'] as String?,
      priceBefore: json['price_before'] as num?,
      priceAfter: json['price_after'] as num?,
      offer: json['offer'] as num?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$SizeUserToJson(SizeUser instance) => <String, dynamic>{
      'size': instance.size,
      'price_before': instance.priceBefore,
      'price_after': instance.priceAfter,
      'offer': instance.offer,
      '_id': instance.id,
    };
