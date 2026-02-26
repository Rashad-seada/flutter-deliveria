// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) => BranchModel(
      id: json['_id'] as String?,
      branchName: json['branch_name'] as String?,
      branchCode: json['branch_code'] as String?,
      phone: json['phone'] as String?,
      coordinates: json['coordinates'] == null
          ? null
          : BranchCoordinates.fromJson(
              json['coordinates'] as Map<String, dynamic>),
      isOpen: json['is_open'] as bool?,
      status: json['status'] as String?,
      address: json['address'] as String?,
      locationMap: json['location_map'] as String?,
      openHour: json['open_hour'] as String?,
      closeHour: json['close_hour'] as String?,
      deliveryCost: json['delivery_cost'] as num?,
      preparationTime: (json['preparation_time'] as num?)?.toInt(),
      deliveryTime: (json['delivery_time'] as num?)?.toInt(),
      isShow: json['is_show'] as bool?,
    );

Map<String, dynamic> _$BranchModelToJson(BranchModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'branch_name': instance.branchName,
      'branch_code': instance.branchCode,
      'phone': instance.phone,
      'coordinates': instance.coordinates,
      'is_open': instance.isOpen,
      'status': instance.status,
      'address': instance.address,
      'location_map': instance.locationMap,
      'open_hour': instance.openHour,
      'close_hour': instance.closeHour,
      'delivery_cost': instance.deliveryCost,
      'preparation_time': instance.preparationTime,
      'delivery_time': instance.deliveryTime,
      'is_show': instance.isShow,
    };

BranchCoordinates _$BranchCoordinatesFromJson(Map<String, dynamic> json) =>
    BranchCoordinates(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BranchCoordinatesToJson(BranchCoordinates instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

GetBranchesResponse _$GetBranchesResponseFromJson(Map<String, dynamic> json) =>
    GetBranchesResponse(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : BranchData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetBranchesResponseToJson(
        GetBranchesResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

BranchData _$BranchDataFromJson(Map<String, dynamic> json) => BranchData(
      parent: json['parent'] == null
          ? null
          : ParentRestaurant.fromJson(json['parent'] as Map<String, dynamic>),
      branches: (json['branches'] as List<dynamic>?)
          ?.map((e) => BranchModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BranchDataToJson(BranchData instance) =>
    <String, dynamic>{
      'parent': instance.parent,
      'branches': instance.branches,
    };

ParentRestaurant _$ParentRestaurantFromJson(Map<String, dynamic> json) =>
    ParentRestaurant(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      logo: json['logo'] as String?,
      isMainBranch: json['is_main_branch'] as bool?,
      branchesCount: (json['branches_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ParentRestaurantToJson(ParentRestaurant instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'is_main_branch': instance.isMainBranch,
      'branches_count': instance.branchesCount,
    };
