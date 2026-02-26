// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_loyalty_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminRewardTiersResponse _$AdminRewardTiersResponseFromJson(
        Map<String, dynamic> json) =>
    AdminRewardTiersResponse(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AdminRewardTier.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdminRewardTiersResponseToJson(
        AdminRewardTiersResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

AdminRewardTier _$AdminRewardTierFromJson(Map<String, dynamic> json) =>
    AdminRewardTier(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      pointsRequired: (json['pointsRequired'] as num?)?.toInt(),
      discountValue: json['discountValue'] as num?,
      discountType: json['discountType'] as String?,
      maxDiscount: json['maxDiscount'] as num?,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$AdminRewardTierToJson(AdminRewardTier instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'pointsRequired': instance.pointsRequired,
      'discountValue': instance.discountValue,
      'discountType': instance.discountType,
      'maxDiscount': instance.maxDiscount,
      'description': instance.description,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt,
    };

AdminLoyaltyUsersResponse _$AdminLoyaltyUsersResponseFromJson(
        Map<String, dynamic> json) =>
    AdminLoyaltyUsersResponse(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => UserPointsSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdminLoyaltyUsersResponseToJson(
        AdminLoyaltyUsersResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

UserPointsSummary _$UserPointsSummaryFromJson(Map<String, dynamic> json) =>
    UserPointsSummary(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      totalPoints: (json['totalPoints'] as num?)?.toInt(),
      legacyPoints: (json['legacyPoints'] as num?)?.toInt(),
      totalRewards: (json['totalRewards'] as num?)?.toInt(),
      usedRewards: (json['usedRewards'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserPointsSummaryToJson(UserPointsSummary instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'totalPoints': instance.totalPoints,
      'legacyPoints': instance.legacyPoints,
      'totalRewards': instance.totalRewards,
      'usedRewards': instance.usedRewards,
    };

LoyaltySuccessResponse _$LoyaltySuccessResponseFromJson(
        Map<String, dynamic> json) =>
    LoyaltySuccessResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$LoyaltySuccessResponseToJson(
        LoyaltySuccessResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
