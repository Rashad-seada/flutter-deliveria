// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_orders_resturant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOrdersResturantResponse _$GetOrdersResturantResponseFromJson(
        Map<String, dynamic> json) =>
    GetOrdersResturantResponse(
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => OrderResturantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetOrdersResturantResponseToJson(
        GetOrdersResturantResponse instance) =>
    <String, dynamic>{
      'orders': instance.orders?.map((e) => e.toJson()).toList(),
    };

OrderResturantModel _$OrderResturantModelFromJson(Map<String, dynamic> json) =>
    OrderResturantModel(
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      user: json['user_id'] == null
          ? null
          : UserModel.fromJson(json['user_id'] as Map<String, dynamic>),
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => ResturantOrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      finalPriceWithoutDeliveryCost:
          _numFromJson(json['final_price_without_delivery_cost']),
      finalDeliveryCost: _numFromJson(json['final_delivery_cost']),
      finalPrice: _numFromJson(json['final_price']),
      deliveryType: json['delivery_type'] as String?,
      paymentType: json['payment_type'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
      deliveryId: json['delivery_id'] as String?,
      orderId: (json['order_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderResturantModelToJson(
        OrderResturantModel instance) =>
    <String, dynamic>{
      'address': instance.address?.toJson(),
      '_id': instance.id,
      'user_id': instance.user?.toJson(),
      'orders': instance.orders?.map((e) => e.toJson()).toList(),
      'final_price_without_delivery_cost':
          instance.finalPriceWithoutDeliveryCost,
      'final_delivery_cost': instance.finalDeliveryCost,
      'final_price': instance.finalPrice,
      'delivery_type': instance.deliveryType,
      'payment_type': instance.paymentType,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
      'delivery_id': instance.deliveryId,
      'order_id': instance.orderId,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['_id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
    };

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      coordinates: json['coordinates'] == null
          ? null
          : CoordinatesModel.fromJson(
              json['coordinates'] as Map<String, dynamic>),
      addressTitle: json['address_title'] as String?,
      phone: json['phone'] as String?,
      details: json['details'] as String?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates?.toJson(),
      'address_title': instance.addressTitle,
      'phone': instance.phone,
      'details': instance.details,
    };

CoordinatesModel _$CoordinatesModelFromJson(Map<String, dynamic> json) =>
    CoordinatesModel(
      latitude: _numFromJson(json['latitude']),
      longitude: _numFromJson(json['longitude']),
    );

Map<String, dynamic> _$CoordinatesModelToJson(CoordinatesModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

ResturantOrderModel _$ResturantOrderModelFromJson(Map<String, dynamic> json) =>
    ResturantOrderModel(
      restaurant: json['restaurant_id'] == null
          ? null
          : OrderRestaurantInfo.fromJson(
              json['restaurant_id'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      priceOfRestaurant: _numFromJson(json['price_of_restaurant']),
      status: json['status'] as String?,
      cancelMe: json['cancel_me'] as bool?,
      id: json['_id'] as String?,
      branchId: _orderBranchInfoFromJson(json['branch_id']),
    );

Map<String, dynamic> _$ResturantOrderModelToJson(
        ResturantOrderModel instance) =>
    <String, dynamic>{
      'restaurant_id': instance.restaurant?.toJson(),
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'price_of_restaurant': instance.priceOfRestaurant,
      'status': instance.status,
      'cancel_me': instance.cancelMe,
      '_id': instance.id,
      'branch_id': instance.branchId?.toJson(),
    };

OrderBranchInfo _$OrderBranchInfoFromJson(Map<String, dynamic> json) =>
    OrderBranchInfo(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      branchName: json['branch_name'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      coordinates: json['coordinates'] == null
          ? null
          : CoordinatesModel.fromJson(
              json['coordinates'] as Map<String, dynamic>),
      locationMap: json['location_map'] as String?,
    );

Map<String, dynamic> _$OrderBranchInfoToJson(OrderBranchInfo instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'branch_name': instance.branchName,
      'address': instance.address,
      'phone': instance.phone,
      'coordinates': instance.coordinates?.toJson(),
      'location_map': instance.locationMap,
    };

OrderRestaurantInfo _$OrderRestaurantInfoFromJson(Map<String, dynamic> json) =>
    OrderRestaurantInfo(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$OrderRestaurantInfoToJson(
        OrderRestaurantInfo instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
    };

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      itemDetails: json['item_details'] == null
          ? null
          : ItemDetailsModel.fromJson(
              json['item_details'] as Map<String, dynamic>),
      sizeDetails: json['size_details'] == null
          ? null
          : SizeDetailsModel.fromJson(
              json['size_details'] as Map<String, dynamic>),
      toppingDetails: (json['topping_details'] as List<dynamic>?)
          ?.map((e) => ToppingDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      totalPrice: _numFromJson(json['total_price']),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'item_details': instance.itemDetails?.toJson(),
      'size_details': instance.sizeDetails?.toJson(),
      'topping_details':
          instance.toppingDetails?.map((e) => e.toJson()).toList(),
      'description': instance.description,
      'total_price': instance.totalPrice,
      '_id': instance.id,
    };

ItemDetailsModel _$ItemDetailsModelFromJson(Map<String, dynamic> json) =>
    ItemDetailsModel(
      itemId: json['item_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$ItemDetailsModelToJson(ItemDetailsModel instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'name': instance.name,
      'description': instance.description,
      'photo': instance.photo,
    };

SizeDetailsModel _$SizeDetailsModelFromJson(Map<String, dynamic> json) =>
    SizeDetailsModel(
      sizeId: json['size_id'] as String?,
      size: json['size'] as String?,
      priceBefore: _numFromJson(json['price_before']),
      priceAfter: _numFromJson(json['price_after']),
      offer: _numFromJson(json['offer']),
      quantity: (json['quantity'] as num?)?.toInt(),
      priceOfQuantity: _numFromJson(json['price_Of_quantity']),
    );

Map<String, dynamic> _$SizeDetailsModelToJson(SizeDetailsModel instance) =>
    <String, dynamic>{
      'size_id': instance.sizeId,
      'size': instance.size,
      'price_before': instance.priceBefore,
      'price_after': instance.priceAfter,
      'offer': instance.offer,
      'quantity': instance.quantity,
      'price_Of_quantity': instance.priceOfQuantity,
    };

ToppingDetailsModel _$ToppingDetailsModelFromJson(Map<String, dynamic> json) =>
    ToppingDetailsModel(
      toppingId: json['topping_id'] as String?,
      price: _numFromJson(json['price']),
      quantity: (json['quantity'] as num?)?.toInt(),
      topping: json['topping'] as String?,
      priceOfQuantity: _numFromJson(json['price_Of_quantity']),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$ToppingDetailsModelToJson(
        ToppingDetailsModel instance) =>
    <String, dynamic>{
      'topping_id': instance.toppingId,
      'price': instance.price,
      'quantity': instance.quantity,
      'topping': instance.topping,
      'price_Of_quantity': instance.priceOfQuantity,
      '_id': instance.id,
    };
