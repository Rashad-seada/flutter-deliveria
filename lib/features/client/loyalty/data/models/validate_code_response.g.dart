// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_code_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateCodeResponse _$ValidateCodeResponseFromJson(
        Map<String, dynamic> json) =>
    ValidateCodeResponse(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : ValidateCodeData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ValidateCodeResponseToJson(
        ValidateCodeResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

ValidateCodeData _$ValidateCodeDataFromJson(Map<String, dynamic> json) =>
    ValidateCodeData(
      code: json['code'] as String?,
      discountValue: json['discountValue'] as num?,
      discountType: json['discountType'] as String?,
      maxDiscount: json['maxDiscount'] as num?,
      tierName: json['tierName'] as String?,
    );

Map<String, dynamic> _$ValidateCodeDataToJson(ValidateCodeData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'discountValue': instance.discountValue,
      'discountType': instance.discountType,
      'maxDiscount': instance.maxDiscount,
      'tierName': instance.tierName,
    };
