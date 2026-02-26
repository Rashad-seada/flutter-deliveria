// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyalty_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoyaltyHistoryResponse _$LoyaltyHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    LoyaltyHistoryResponse(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : LoyaltyHistoryData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoyaltyHistoryResponseToJson(
        LoyaltyHistoryResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(),
    };

LoyaltyHistoryData _$LoyaltyHistoryDataFromJson(Map<String, dynamic> json) =>
    LoyaltyHistoryData(
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => PointsTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoyaltyHistoryDataToJson(LoyaltyHistoryData instance) =>
    <String, dynamic>{
      'transactions': instance.transactions?.map((e) => e.toJson()).toList(),
      'pagination': instance.pagination?.toJson(),
    };

PointsTransaction _$PointsTransactionFromJson(Map<String, dynamic> json) =>
    PointsTransaction(
      id: json['_id'] as String?,
      type: json['type'] as String?,
      points: (json['points'] as num?)?.toInt(),
      balance: (json['balance'] as num?)?.toInt(),
      description: json['description'] as String?,
      orderId: json['orderId'] == null
          ? null
          : OrderRef.fromJson(json['orderId'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$PointsTransactionToJson(PointsTransaction instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'points': instance.points,
      'balance': instance.balance,
      'description': instance.description,
      'orderId': instance.orderId?.toJson(),
      'createdAt': instance.createdAt,
    };

OrderRef _$OrderRefFromJson(Map<String, dynamic> json) => OrderRef(
      orderId: (json['order_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderRefToJson(OrderRef instance) => <String, dynamic>{
      'order_id': instance.orderId,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      page: (json['page'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      pages: (json['pages'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
      'pages': instance.pages,
    };
