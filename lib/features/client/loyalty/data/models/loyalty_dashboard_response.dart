import 'package:json_annotation/json_annotation.dart';

part 'loyalty_dashboard_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LoyaltyDashboardResponse {
  final bool? success;
  final LoyaltyDashboard? data;

  LoyaltyDashboardResponse({this.success, this.data});

  factory LoyaltyDashboardResponse.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyDashboardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoyaltyDashboardResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoyaltyDashboard {
  final int? totalPoints;
  final NextTier? nextTier;
  final List<EarnedReward>? earnedRewards;
  final List<RewardTier>? tiers;

  LoyaltyDashboard({
    this.totalPoints,
    this.nextTier,
    this.earnedRewards,
    this.tiers,
  });

  factory LoyaltyDashboard.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyDashboardFromJson(json);

  Map<String, dynamic> toJson() => _$LoyaltyDashboardToJson(this);
}

@JsonSerializable()
class NextTier {
  final String? name;
  final int? pointsRequired;
  final int? pointsNeeded;
  final int? progress; // 0-100

  NextTier({
    this.name,
    this.pointsRequired,
    this.pointsNeeded,
    this.progress,
  });

  factory NextTier.fromJson(Map<String, dynamic> json) =>
      _$NextTierFromJson(json);

  Map<String, dynamic> toJson() => _$NextTierToJson(this);
}

@JsonSerializable()
class EarnedReward {
  final String? tierName;
  final String? code;
  final num? discountValue;
  final String? discountType; // 'percentage' or 'fixed'
  final num? maxDiscount;
  final bool? isUsed;
  final String? earnedAt;
  final String? usedAt;

  EarnedReward({
    this.tierName,
    this.code,
    this.discountValue,
    this.discountType,
    this.maxDiscount,
    this.isUsed,
    this.earnedAt,
    this.usedAt,
  });

  factory EarnedReward.fromJson(Map<String, dynamic> json) =>
      _$EarnedRewardFromJson(json);

  Map<String, dynamic> toJson() => _$EarnedRewardToJson(this);
}

@JsonSerializable()
class RewardTier {
  final String? name;
  final int? pointsRequired;
  final num? discountValue;
  final String? discountType;
  final String? description;
  final bool? achieved;

  RewardTier({
    this.name,
    this.pointsRequired,
    this.discountValue,
    this.discountType,
    this.description,
    this.achieved,
  });

  factory RewardTier.fromJson(Map<String, dynamic> json) =>
      _$RewardTierFromJson(json);

  Map<String, dynamic> toJson() => _$RewardTierToJson(this);
}
