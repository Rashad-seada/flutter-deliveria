// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_not_accepted_order_agent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNotAcceptedOrderAgentResponse _$GetNotAcceptedOrderAgentResponseFromJson(
        Map<String, dynamic> json) =>
    GetNotAcceptedOrderAgentResponse(
      orders: (json['orders'] as List<dynamic>)
          .map((e) => AgentOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetNotAcceptedOrderAgentResponseToJson(
        GetNotAcceptedOrderAgentResponse instance) =>
    <String, dynamic>{
      'orders': instance.orders.map((e) => e.toJson()).toList(),
    };

AgentOrder _$AgentOrderFromJson(Map<String, dynamic> json) => AgentOrder(
      address:
          AgentOrderAddress.fromJson(json['address'] as Map<String, dynamic>),
      id: json['_id'] as String,
      user: AgentOrderUser.fromJson(json['user_id'] as Map<String, dynamic>),
      orders: (json['orders'] as List<dynamic>)
          .map((e) => AgentOrderRestaurant.fromJson(e as Map<String, dynamic>))
          .toList(),
      finalPriceWithoutDeliveryCost:
          _safeNumFromJson(json['final_price_without_delivery_cost']),
      finalDeliveryCost: _safeNumFromJson(json['final_delivery_cost']),
      finalPrice: _safeNumFromJson(json['final_price']),
      deliveryType: json['delivery_type'] as String,
      paymentType: json['payment_type'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: _safeIntFromJson(json['__v']),
      orderId: (json['order_id'] as num?)?.toInt(),
      acceptanceStatus: json['acceptance_status'] == null
          ? null
          : AcceptanceStatus.fromJson(
              json['acceptance_status'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AgentOrderToJson(AgentOrder instance) =>
    <String, dynamic>{
      'address': instance.address.toJson(),
      '_id': instance.id,
      'user_id': instance.user.toJson(),
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
      'order_id': instance.orderId,
      'acceptance_status': instance.acceptanceStatus?.toJson(),
    };

AcceptanceStatus _$AcceptanceStatusFromJson(Map<String, dynamic> json) =>
    AcceptanceStatus(
      acceptedByDeliveryAgents:
          (json['accepted_by_delivery_agents'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$AcceptanceStatusToJson(AcceptanceStatus instance) =>
    <String, dynamic>{
      'accepted_by_delivery_agents': instance.acceptedByDeliveryAgents,
    };

AgentOrderAddress _$AgentOrderAddressFromJson(Map<String, dynamic> json) =>
    AgentOrderAddress(
      coordinates: AgentOrderCoordinates.fromJson(
          json['coordinates'] as Map<String, dynamic>),
      addressTitle: json['address_title'] as String,
      phone: json['phone'] as String,
      details: json['details'] as String,
    );

Map<String, dynamic> _$AgentOrderAddressToJson(AgentOrderAddress instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates,
      'address_title': instance.addressTitle,
      'phone': instance.phone,
      'details': instance.details,
    };

AgentOrderCoordinates _$AgentOrderCoordinatesFromJson(
        Map<String, dynamic> json) =>
    AgentOrderCoordinates(
      latitude: _safeDoubleFromJson(json['latitude']),
      longitude: _safeDoubleFromJson(json['longitude']),
    );

Map<String, dynamic> _$AgentOrderCoordinatesToJson(
        AgentOrderCoordinates instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

AgentOrderUser _$AgentOrderUserFromJson(Map<String, dynamic> json) =>
    AgentOrderUser(
      id: json['_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
    );

Map<String, dynamic> _$AgentOrderUserToJson(AgentOrderUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
    };

AgentOrderRestaurant _$AgentOrderRestaurantFromJson(
        Map<String, dynamic> json) =>
    AgentOrderRestaurant(
      restaurantId: AgentOrderRestaurantInfo.fromJson(
          json['restaurant_id'] as Map<String, dynamic>),
      branch: _branchInfoFromJson(json['branch_id']),
      items: (json['items'] as List<dynamic>)
          .map((e) => AgentOrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      priceOfRestaurant: _safeNumFromJson(json['price_of_restaurant']),
      status: json['status'] as String,
      cancelMe: json['cancel_me'] as bool?,
      id: json['_id'] as String,
    );

Map<String, dynamic> _$AgentOrderRestaurantToJson(
        AgentOrderRestaurant instance) =>
    <String, dynamic>{
      'restaurant_id': instance.restaurantId.toJson(),
      'branch_id': instance.branch?.toJson(),
      'items': instance.items.map((e) => e.toJson()).toList(),
      'price_of_restaurant': instance.priceOfRestaurant,
      'status': instance.status,
      'cancel_me': instance.cancelMe,
      '_id': instance.id,
    };

AgentOrderBranchInfo _$AgentOrderBranchInfoFromJson(
        Map<String, dynamic> json) =>
    AgentOrderBranchInfo(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      branchName: json['branch_name'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      coordinates: json['coordinates'] == null
          ? null
          : AgentOrderCoordinates.fromJson(
              json['coordinates'] as Map<String, dynamic>),
      locationMap: json['location_map'] as String?,
    );

Map<String, dynamic> _$AgentOrderBranchInfoToJson(
        AgentOrderBranchInfo instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'branch_name': instance.branchName,
      'address': instance.address,
      'phone': instance.phone,
      'coordinates': instance.coordinates?.toJson(),
      'location_map': instance.locationMap,
    };

AgentOrderRestaurantInfo _$AgentOrderRestaurantInfoFromJson(
        Map<String, dynamic> json) =>
    AgentOrderRestaurantInfo(
      id: json['_id'] as String,
      logo: json['logo'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$AgentOrderRestaurantInfoToJson(
        AgentOrderRestaurantInfo instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'logo': instance.logo,
      'name': instance.name,
      'phone': instance.phone,
    };

AgentOrderItem _$AgentOrderItemFromJson(Map<String, dynamic> json) =>
    AgentOrderItem(
      itemDetails: AgentOrderItemDetails.fromJson(
          json['item_details'] as Map<String, dynamic>),
      sizeDetails: _sizeDetailsFromJson(json['size_details']),
      toppingDetails: _toppingDetailsFromJson(json['topping_details']),
      description: json['description'] as String?,
      totalPrice: _safeNumFromJson(json['total_price']),
      id: json['_id'] as String,
    );

Map<String, dynamic> _$AgentOrderItemToJson(AgentOrderItem instance) =>
    <String, dynamic>{
      'item_details': instance.itemDetails.toJson(),
      'size_details': instance.sizeDetails?.toJson(),
      'topping_details': _toppingDetailsToJson(instance.toppingDetails),
      'description': instance.description,
      'total_price': instance.totalPrice,
      '_id': instance.id,
    };

AgentOrderItemDetails _$AgentOrderItemDetailsFromJson(
        Map<String, dynamic> json) =>
    AgentOrderItemDetails(
      itemId: json['item_id'] as String,
      name: json['name'] as String,
      description: json['description'],
      photo: json['photo'] as String,
    );

Map<String, dynamic> _$AgentOrderItemDetailsToJson(
        AgentOrderItemDetails instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'name': instance.name,
      'description': instance.description,
      'photo': instance.photo,
    };

AgentOrderSizeDetails _$AgentOrderSizeDetailsFromJson(
        Map<String, dynamic> json) =>
    AgentOrderSizeDetails(
      sizeId: json['size_id'] as String,
      size: json['size'] as String,
      priceBefore: _safeNumFromJson(json['price_before']),
      priceAfter: _safeNumFromJson(json['price_after']),
      offer: _safeNumFromJson(json['offer']),
      quantity: _safeIntFromJson(json['quantity']),
      priceOfQuantity: _safeNumFromJson(json['price_Of_quantity']),
    );

Map<String, dynamic> _$AgentOrderSizeDetailsToJson(
        AgentOrderSizeDetails instance) =>
    <String, dynamic>{
      'size_id': instance.sizeId,
      'size': instance.size,
      'price_before': instance.priceBefore,
      'price_after': instance.priceAfter,
      'offer': instance.offer,
      'quantity': instance.quantity,
      'price_Of_quantity': instance.priceOfQuantity,
    };

AgentOrderToppingDetails _$AgentOrderToppingDetailsFromJson(
        Map<String, dynamic> json) =>
    AgentOrderToppingDetails(
      toppingId: json['topping_id'] as String?,
      topping: json['topping'] as String?,
      price: _safeNumFromJson(json['price']),
      quantity: _safeIntFromJson(json['quantity']),
      priceOfQuantity: _safeNumFromJson(json['price_Of_quantity']),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$AgentOrderToppingDetailsToJson(
        AgentOrderToppingDetails instance) =>
    <String, dynamic>{
      'topping_id': instance.toppingId,
      'topping': instance.topping,
      'price': instance.price,
      'quantity': instance.quantity,
      'price_Of_quantity': instance.priceOfQuantity,
      '_id': instance.id,
    };
