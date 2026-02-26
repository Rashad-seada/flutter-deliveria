// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantsWithOffersResponse _$RestaurantsWithOffersResponseFromJson(
        Map<String, dynamic> json) =>
    RestaurantsWithOffersResponse(
      success: json['success'] as bool?,
      restaurants: (json['restaurants'] as List<dynamic>?)
          ?.map((e) => RestaurantWithOffers.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestaurantsWithOffersResponseToJson(
        RestaurantsWithOffersResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'restaurants': instance.restaurants?.map((e) => e.toJson()).toList(),
    };

RestaurantWithOffers _$RestaurantWithOffersFromJson(
        Map<String, dynamic> json) =>
    RestaurantWithOffers(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      nameAr: json['name_ar'] as String?,
      logo: json['logo'] as String?,
      cover: json['cover'] as String?,
      rating: json['rating'] as num?,
      isClosed: json['is_closed'] as bool?,
      isOpen: json['is_open'] as bool?,
      hasOffers: json['has_offers'] as bool?,
      offersCount: (json['offers_count'] as num?)?.toInt(),
      maxDiscount: json['max_discount'] as num?,
      distance: json['distance'] as num?,
    );

Map<String, dynamic> _$RestaurantWithOffersToJson(
        RestaurantWithOffers instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'name_ar': instance.nameAr,
      'logo': instance.logo,
      'cover': instance.cover,
      'rating': instance.rating,
      'is_closed': instance.isClosed,
      'is_open': instance.isOpen,
      'has_offers': instance.hasOffers,
      'offers_count': instance.offersCount,
      'max_discount': instance.maxDiscount,
      'distance': instance.distance,
    };

RestaurantOffersResponse _$RestaurantOffersResponseFromJson(
        Map<String, dynamic> json) =>
    RestaurantOffersResponse(
      success: json['success'] as bool?,
      restaurant: json['restaurant'] == null
          ? null
          : RestaurantOfferInfo.fromJson(
              json['restaurant'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OfferItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestaurantOffersResponseToJson(
        RestaurantOffersResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'restaurant': instance.restaurant?.toJson(),
      'items': instance.items?.map((e) => e.toJson()).toList(),
    };

RestaurantOfferInfo _$RestaurantOfferInfoFromJson(Map<String, dynamic> json) =>
    RestaurantOfferInfo(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      hasOffers: json['has_offers'] as bool?,
    );

Map<String, dynamic> _$RestaurantOfferInfoToJson(
        RestaurantOfferInfo instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'has_offers': instance.hasOffers,
    };

OfferItem _$OfferItemFromJson(Map<String, dynamic> json) => OfferItem(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      photo: json['photo'] as String?,
      sizes: (json['sizes'] as List<dynamic>?)
          ?.map((e) => OfferItemSize.fromJson(e as Map<String, dynamic>))
          .toList(),
      toppings: json['toppings'] as List<dynamic>?,
      enable: json['enable'] as bool?,
    );

Map<String, dynamic> _$OfferItemToJson(OfferItem instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'photo': instance.photo,
      'sizes': instance.sizes?.map((e) => e.toJson()).toList(),
      'toppings': instance.toppings,
      'enable': instance.enable,
    };

OfferItemSize _$OfferItemSizeFromJson(Map<String, dynamic> json) =>
    OfferItemSize(
      size: json['size'] as String?,
      priceBefore: json['price_before'] as num?,
      priceAfter: json['price_after'] as num?,
      offer: json['offer'] as num?,
      hasOffer: json['has_offer'] as bool?,
    );

Map<String, dynamic> _$OfferItemSizeToJson(OfferItemSize instance) =>
    <String, dynamic>{
      'size': instance.size,
      'price_before': instance.priceBefore,
      'price_after': instance.priceAfter,
      'offer': instance.offer,
      'has_offer': instance.hasOffer,
    };

RestaurantDetailsResponse _$RestaurantDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    RestaurantDetailsResponse(
      success: json['success'] as bool?,
      restaurant: json['restaurant'] == null
          ? null
          : RestaurantDetails.fromJson(
              json['restaurant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RestaurantDetailsResponseToJson(
        RestaurantDetailsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'restaurant': instance.restaurant?.toJson(),
    };

RestaurantDetails _$RestaurantDetailsFromJson(Map<String, dynamic> json) =>
    RestaurantDetails(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      nameAr: json['name_ar'] as String?,
      logo: json['logo'] as String?,
      cover: json['cover'] as String?,
      rating: json['rating'] as num?,
      isClosed: json['is_closed'] as bool?,
      hasOffers: json['has_offers'] as bool?,
      offersCount: (json['offers_count'] as num?)?.toInt(),
      maxDiscount: json['max_discount'] as num?,
    );

Map<String, dynamic> _$RestaurantDetailsToJson(RestaurantDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'name_ar': instance.nameAr,
      'logo': instance.logo,
      'cover': instance.cover,
      'rating': instance.rating,
      'is_closed': instance.isClosed,
      'has_offers': instance.hasOffers,
      'offers_count': instance.offersCount,
      'max_discount': instance.maxDiscount,
    };
