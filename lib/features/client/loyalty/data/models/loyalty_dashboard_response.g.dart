// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyalty_dashboard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoyaltyDashboardResponse _$LoyaltyDashboardResponseFromJson(
        Map<String, dynamic> json) =>
    LoyaltyDashboardResponse(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : LoyaltyDashboard.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoyaltyDashboardResponseToJson(
        LoyaltyDashboardResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(),
    };

LoyaltyDashboard _$LoyaltyDashboardFromJson(Map<String, dynamic> json) =>
    LoyaltyDashboard(
      totalPoints: (json['totalPoints'] as num?)?.toInt(),
      nextTier: json['nextTier'] == null
          ? null
          : NextTier.fromJson(json['nextTier'] as Map<String, dynamic>),
      earnedRewards: (json['earnedRewards'] as List<dynamic>?)
          ?.map((e) => EarnedReward.fromJson(e as Map<String, dynamic>))
          .toList(),
      tiers: (json['tiers'] as List<dynamic>?)
          ?.map((e) => RewardTier.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LoyaltyDashboardToJson(LoyaltyDashboard instance) =>
    <String, dynamic>{
      'totalPoints': instance.totalPoints,
      'nextTier': instance.nextTier?.toJson(),
      'earnedRewards': instance.earnedRewards?.map((e) => e.toJson()).toList(),
      'tiers': instance.tiers?.map((e) => e.toJson()).toList(),
    };

NextTier _$NextTierFromJson(Map<String, dynamic> json) => NextTier(
      name: json['name'] as String?,
      pointsRequired: (json['pointsRequired'] as num?)?.toInt(),
      pointsNeeded: (json['pointsNeeded'] as num?)?.toInt(),
      progress: (json['progress'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NextTierToJson(NextTier instance) => <String, dynamic>{
      'name': instance.name,
      'pointsRequired': instance.pointsRequired,
      'pointsNeeded': instance.pointsNeeded,
      'progress': instance.progress,
    };

EarnedReward _$EarnedRewardFromJson(Map<String, dynamic> json) => EarnedReward(
      tierName: json['tierName'] as String?,
      code: json['code'] as String?,
      discountValue: json['discountValue'] as num?,
      discountType: json['discountType'] as String?,
      maxDiscount: json['maxDiscount'] as num?,
      isUsed: json['isUsed'] as bool?,
      earnedAt: json['earnedAt'] as String?,
      usedAt: json['usedAt'] as String?,
    );

Map<String, dynamic> _$EarnedRewardToJson(EarnedReward instance) =>
    <String, dynamic>{
      'tierName': instance.tierName,
      'code': instance.code,
      'discountValue': instance.discountValue,
      'discountType': instance.discountType,
      'maxDiscount': instance.maxDiscount,
      'isUsed': instance.isUsed,
      'earnedAt': instance.earnedAt,
      'usedAt': instance.usedAt,
    };

RewardTier _$RewardTierFromJson(Map<String, dynamic> json) => RewardTier(
      name: json['name'] as String?,
      pointsRequired: (json['pointsRequired'] as num?)?.toInt(),
      discountValue: json['discountValue'] as num?,
      discountType: json['discountType'] as String?,
      description: json['description'] as String?,
      achieved: json['achieved'] as bool?,
    );

Map<String, dynamic> _$RewardTierToJson(RewardTier instance) =>
    <String, dynamic>{
      'name': instance.name,
      'pointsRequired': instance.pointsRequired,
      'discountValue': instance.discountValue,
      'discountType': instance.discountType,
      'description': instance.description,
      'achieved': instance.achieved,
    };
