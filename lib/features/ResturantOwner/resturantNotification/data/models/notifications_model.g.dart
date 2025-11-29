// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsModel _$NotificationsModelFromJson(
  Map<String, dynamic> json,
) => NotificationsModel(
  response:
      (json['response'] as List<dynamic>)
          .map((e) => NotificationItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$NotificationsModelToJson(NotificationsModel instance) =>
    <String, dynamic>{'response': instance.response};

NotificationItemModel _$NotificationItemModelFromJson(
  Map<String, dynamic> json,
) => NotificationItemModel(
  id: json['_id'] as String,
  message: json['message'] as String,
  senderId: json['sender_id'] as String,
  userId: json['user_id'] as String,
  seen: json['seen'] as bool,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  v: (json['__v'] as num).toInt(),
  senderName: json['sender_name'] as String,
);

Map<String, dynamic> _$NotificationItemModelToJson(
  NotificationItemModel instance,
) => <String, dynamic>{
  '_id': instance.id,
  'message': instance.message,
  'sender_id': instance.senderId,
  'user_id': instance.userId,
  'seen': instance.seen,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  '__v': instance.v,
  'sender_name': instance.senderName,
};
