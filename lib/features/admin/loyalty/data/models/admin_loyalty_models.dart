import 'package:json_annotation/json_annotation.dart';

part 'admin_loyalty_models.g.dart';

// Admin Reward Tier Response
@JsonSerializable(explicitToJson: true)
class AdminRewardTiersResponse {
  final bool? success;
  final List<AdminRewardTier>? data;

  AdminRewardTiersResponse({this.success, this.data});

  factory AdminRewardTiersResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminRewardTiersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminRewardTiersResponseToJson(this);
}

@JsonSerializable()
class AdminRewardTier {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final int? pointsRequired;
  final num? discountValue;
  final String? discountType;
  final num? maxDiscount;
  final String? description;
  final bool? isActive;
  final String? createdAt;

  AdminRewardTier({
    this.id,
    this.name,
    this.pointsRequired,
    this.discountValue,
    this.discountType,
    this.maxDiscount,
    this.description,
    this.isActive,
    this.createdAt,
  });

  factory AdminRewardTier.fromJson(Map<String, dynamic> json) =>
      _$AdminRewardTierFromJson(json);

  Map<String, dynamic> toJson() => _$AdminRewardTierToJson(this);
}

// Admin Users with Points Response
@JsonSerializable(explicitToJson: true)
class AdminLoyaltyUsersResponse {
  final bool? success;
  final List<UserPointsSummary>? data;

  AdminLoyaltyUsersResponse({this.success, this.data});

  factory AdminLoyaltyUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminLoyaltyUsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminLoyaltyUsersResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserPointsSummary {
  @JsonKey(name: '_id')
  final String? id;
  final String? name; // API sends 'name', not first_name/last_name
  final String? phone;
  final int? totalPoints; // Flat structure
  final int? legacyPoints; // Old system points
  final int? totalRewards; // Flat structure
  final int? usedRewards; // Flat structure

  UserPointsSummary({
    this.id,
    this.name,
    this.phone,
    this.totalPoints,
    this.legacyPoints,
    this.totalRewards,
    this.usedRewards,
  });

  factory UserPointsSummary.fromJson(Map<String, dynamic> json) =>
      _$UserPointsSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$UserPointsSummaryToJson(this);
  
  String get fullName => name ?? 'Unknown User';
}

// LoyaltySummary class removed as API is flat

// Generic Success Response
@JsonSerializable()
class LoyaltySuccessResponse {
  final bool? success;
  final String? message;

  LoyaltySuccessResponse({this.success, this.message});

  factory LoyaltySuccessResponse.fromJson(Map<String, dynamic> json) =>
      _$LoyaltySuccessResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoyaltySuccessResponseToJson(this);
}
