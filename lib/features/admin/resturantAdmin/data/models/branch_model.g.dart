// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) => BranchModel(
      id: json['_id'] as String?,
      parentRestaurantId: json['parent_restaurant_id'] as String?,
      branchName: json['branch_name'] as String?,
      branchCode: json['branch_code'] as String?,
      isMainBranch: json['is_main_branch'] as bool?,
      isShow: json['is_show'] as bool?,
      isOpen: json['is_open'] as bool?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
      logo: json['logo'] as String?,
      locationMap: json['location_map'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      coordinates: json['coordinates'] == null
          ? null
          : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
      openHour: json['open_hour'] as String?,
      closeHour: json['close_hour'] as String?,
      deliveryCost: json['delivery_cost'] as num?,
      preparationTime: (json['preparation_time'] as num?)?.toInt(),
      deliveryTime: (json['delivery_time'] as num?)?.toInt(),
      commissionPercentage: json['commission_percentage'] as num?,
    );

Map<String, dynamic> _$BranchModelToJson(BranchModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'parent_restaurant_id': instance.parentRestaurantId,
      'branch_name': instance.branchName,
      'branch_code': instance.branchCode,
      'is_main_branch': instance.isMainBranch,
      'is_show': instance.isShow,
      'is_open': instance.isOpen,
      'name': instance.name,
      'phone': instance.phone,
      'photo': instance.photo,
      'logo': instance.logo,
      'location_map': instance.locationMap,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'coordinates': instance.coordinates,
      'open_hour': instance.openHour,
      'close_hour': instance.closeHour,
      'delivery_cost': instance.deliveryCost,
      'preparation_time': instance.preparationTime,
      'delivery_time': instance.deliveryTime,
      'commission_percentage': instance.commissionPercentage,
    };

BranchesResponse _$BranchesResponseFromJson(Map<String, dynamic> json) =>
    BranchesResponse(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : BranchesData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BranchesResponseToJson(BranchesResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

BranchesData _$BranchesDataFromJson(Map<String, dynamic> json) => BranchesData(
      parent: json['parent'] == null
          ? null
          : BranchModel.fromJson(json['parent'] as Map<String, dynamic>),
      branches: (json['branches'] as List<dynamic>?)
          ?.map((e) => BranchModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BranchesDataToJson(BranchesData instance) =>
    <String, dynamic>{
      'parent': instance.parent,
      'branches': instance.branches,
    };
