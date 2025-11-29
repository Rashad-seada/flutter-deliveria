// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddReviewResponse _$AddReviewResponseFromJson(Map<String, dynamic> json) =>
    AddReviewResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$AddReviewResponseToJson(AddReviewResponse instance) =>
    <String, dynamic>{'success': instance.success, 'message': instance.message};
