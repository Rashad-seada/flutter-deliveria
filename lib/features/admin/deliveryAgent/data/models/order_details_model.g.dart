// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailsResponse _$OrderDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    OrderDetailsResponse(
      order: OrderDetailsModel.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderDetailsResponseToJson(
        OrderDetailsResponse instance) =>
    <String, dynamic>{
      'order': instance.order.toJson(),
    };

OrderDetailsModel _$OrderDetailsModelFromJson(Map<String, dynamic> json) =>
    OrderDetailsModel(
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      id: json['_id'] as String,
      userId: OrderDetailsModel._userFromJson(json['user_id']),
      orders: (json['orders'] as List<dynamic>)
          .map((e) => RestaurantOrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      finalPriceWithoutDeliveryCost:
          json['final_price_without_delivery_cost'] as num,
      finalDeliveryCost: json['final_delivery_cost'] as num,
      finalPrice: json['final_price'] as num,
      deliveryType: json['delivery_type'] as String?,
      paymentType: json['payment_type'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: (json['__v'] as num).toInt(),
      deliveryId: json['delivery_id'] as String?,
    );

Map<String, dynamic> _$OrderDetailsModelToJson(OrderDetailsModel instance) =>
    <String, dynamic>{
      'address': instance.address.toJson(),
      '_id': instance.id,
      'user_id': instance.userId,
      'orders': instance.orders.map((e) => e.toJson()).toList(),
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
    };

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      coordinates: CoordinatesModel.fromJson(
          json['coordinates'] as Map<String, dynamic>),
      addressTitle: json['address_title'] as String,
      phone: json['phone'] as String,
      details: json['details'] as String,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates,
      'address_title': instance.addressTitle,
      'phone': instance.phone,
      'details': instance.details,
    };

CoordinatesModel _$CoordinatesModelFromJson(Map<String, dynamic> json) =>
    CoordinatesModel(
      latitude: CoordinatesModel._asString(json['latitude']),
      longitude: CoordinatesModel._asString(json['longitude']),
    );

Map<String, dynamic> _$CoordinatesModelToJson(CoordinatesModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

RestaurantOrderModel _$RestaurantOrderModelFromJson(
        Map<String, dynamic> json) =>
    RestaurantOrderModel(
      restaurantId: RestaurantOrderModel._extractIdFromJson(json['restaurant_id']),
      branch: _orderDetailsBranchFromJson(json['branch_id']),
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      priceOfRestaurant: json['price_of_restaurant'] as num,
      status: json['status'] as String,
      cancelMe: json['cancel_me'] as bool,
      id: json['_id'] as String,
    );

Map<String, dynamic> _$RestaurantOrderModelToJson(
        RestaurantOrderModel instance) =>
    <String, dynamic>{
      'restaurant_id': instance.restaurantId,
      'branch_id': instance.branch?.toJson(),
      'items': instance.items.map((e) => e.toJson()).toList(),
      'price_of_restaurant': instance.priceOfRestaurant,
      'status': instance.status,
      'cancel_me': instance.cancelMe,
      '_id': instance.id,
    };

OrderDetailsBranchInfo _$OrderDetailsBranchInfoFromJson(
        Map<String, dynamic> json) =>
    OrderDetailsBranchInfo(
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

Map<String, dynamic> _$OrderDetailsBranchInfoToJson(
        OrderDetailsBranchInfo instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'branch_name': instance.branchName,
      'address': instance.address,
      'phone': instance.phone,
      'coordinates': instance.coordinates,
      'location_map': instance.locationMap,
    };

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      itemDetails: ItemDetailsModel.fromJson(
          json['item_details'] as Map<String, dynamic>),
      sizeDetails: SizeDetailsModel.fromJson(
          json['size_details'] as Map<String, dynamic>),
      toppingDetails: (json['topping_details'] as List<dynamic>)
          .map((e) => ToppingDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['total_price'] as num,
      id: json['_id'] as String,
    );

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'item_details': instance.itemDetails.toJson(),
      'size_details': instance.sizeDetails.toJson(),
      'topping_details':
          instance.toppingDetails.map((e) => e.toJson()).toList(),
      'total_price': instance.totalPrice,
      '_id': instance.id,
    };

ItemDetailsModel _$ItemDetailsModelFromJson(Map<String, dynamic> json) =>
    ItemDetailsModel(
      itemId: json['item_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      photo: json['photo'] as String,
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
      sizeId: json['size_id'] as String,
      size: json['size'] as String,
      priceBefore: json['price_before'] as num,
      priceAfter: json['price_after'] as num,
      offer: json['offer'] as num,
      quantity: (json['quantity'] as num).toInt(),
      priceOfQuantity: json['price_Of_quantity'] as num,
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
      topping: json['topping'] as String,
      price: json['price'] as num,
      quantity: (json['quantity'] as num).toInt(),
      id: json['_id'] as String,
    );

Map<String, dynamic> _$ToppingDetailsModelToJson(
        ToppingDetailsModel instance) =>
    <String, dynamic>{
      'topping': instance.topping,
      'price': instance.price,
      'quantity': instance.quantity,
      '_id': instance.id,
    };
