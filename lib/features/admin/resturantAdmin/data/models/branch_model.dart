import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_model.g.dart';

@JsonSerializable()
class BranchModel {
  @JsonKey(name: '_id')
  final String? id;
  
  @JsonKey(name: 'parent_restaurant_id')
  final String? parentRestaurantId;
  
  @JsonKey(name: 'branch_name')
  final String? branchName;
  
  @JsonKey(name: 'branch_code')
  final String? branchCode;
  
  @JsonKey(name: 'is_main_branch')
  final bool? isMainBranch;
  
  @JsonKey(name: 'is_show')
  final bool? isShow;
  
  @JsonKey(name: 'is_open')
  final bool? isOpen;
  
  final String? name;
  final String? phone;
  final String? photo;
  final String? logo;
  
  @JsonKey(name: 'location_map')
  final String? locationMap;
  
  final double? latitude;
  final double? longitude;
  final Coordinates? coordinates;
  
  @JsonKey(name: 'open_hour')
  final String? openHour;
  
  @JsonKey(name: 'close_hour')
  final String? closeHour;
  
  @JsonKey(name: 'delivery_cost')
  final num? deliveryCost;
  
  @JsonKey(name: 'preparation_time')
  final int? preparationTime;
  
  @JsonKey(name: 'delivery_time')
  final int? deliveryTime;
  
  @JsonKey(name: 'commission_percentage')
  final num? commissionPercentage;

  BranchModel({
    this.id,
    this.parentRestaurantId,
    this.branchName,
    this.branchCode,
    this.isMainBranch,
    this.isShow,
    this.isOpen,
    this.name,
    this.phone,
    this.photo,
    this.logo,
    this.locationMap,
    this.latitude,
    this.longitude,
    this.coordinates,
    this.openHour,
    this.closeHour,
    this.deliveryCost,
    this.preparationTime,
    this.deliveryTime,
    this.commissionPercentage,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);

  Map<String, dynamic> toJson() => _$BranchModelToJson(this);
}

@JsonSerializable()
class BranchesResponse {
  final bool? success;
  final BranchesData? data;

  BranchesResponse({this.success, this.data});

  factory BranchesResponse.fromJson(Map<String, dynamic> json) =>
      _$BranchesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BranchesResponseToJson(this);
}

@JsonSerializable()
class BranchesData {
  final BranchModel? parent;
  final List<BranchModel>? branches;

  BranchesData({this.parent, this.branches});

  factory BranchesData.fromJson(Map<String, dynamic> json) =>
      _$BranchesDataFromJson(json);

  Map<String, dynamic> toJson() => _$BranchesDataToJson(this);
}
