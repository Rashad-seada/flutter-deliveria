import 'package:json_annotation/json_annotation.dart';

part 'branch_model.g.dart';

@JsonSerializable()
class BranchModel {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'branch_name')
  final String? branchName;
  @JsonKey(name: 'branch_code')
  final String? branchCode;
  final String? phone;
  final BranchCoordinates? coordinates;
  @JsonKey(name: 'is_open')
  final bool? isOpen;
  final String? status;
  final String? address;
  @JsonKey(name: 'location_map')
  final String? locationMap;
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
  @JsonKey(name: 'is_show')
  final bool? isShow;

  BranchModel({
    this.id,
    this.branchName,
    this.branchCode,
    this.phone,
    this.coordinates,
    this.isOpen,
    this.status,
    this.address,
    this.locationMap,
    this.openHour,
    this.closeHour,
    this.deliveryCost,
    this.preparationTime,
    this.deliveryTime,
    this.isShow,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);

  Map<String, dynamic> toJson() => _$BranchModelToJson(this);
}

@JsonSerializable()
class BranchCoordinates {
  final double? latitude;
  final double? longitude;

  BranchCoordinates({this.latitude, this.longitude});

  factory BranchCoordinates.fromJson(Map<String, dynamic> json) =>
      _$BranchCoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$BranchCoordinatesToJson(this);
}

@JsonSerializable()
class GetBranchesResponse {
  final bool? success;
  final BranchData? data;

  GetBranchesResponse({this.success, this.data});

  factory GetBranchesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBranchesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBranchesResponseToJson(this);
}

@JsonSerializable()
class BranchData {
  // We can use dynamic or a specific ParentRestaurant model. 
  // Given the fields, it looks like a simplified Restaurant model.
  // For now, let's use Map<String, dynamic> or a simple class if needed.
  // Actually, let's use a specific class to be safe.
  final ParentRestaurant? parent;
  final List<BranchModel>? branches;

  BranchData({this.parent, this.branches});

  factory BranchData.fromJson(Map<String, dynamic> json) =>
      _$BranchDataFromJson(json);

  Map<String, dynamic> toJson() => _$BranchDataToJson(this);
}

@JsonSerializable()
class ParentRestaurant {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? logo;
  @JsonKey(name: 'is_main_branch')
  final bool? isMainBranch;
  @JsonKey(name: 'branches_count')
  final int? branchesCount;

  ParentRestaurant({
    this.id,
    this.name,
    this.logo,
    this.isMainBranch,
    this.branchesCount,
  });

  factory ParentRestaurant.fromJson(Map<String, dynamic> json) =>
      _$ParentRestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$ParentRestaurantToJson(this);
}
