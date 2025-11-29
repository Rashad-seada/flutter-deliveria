import 'package:json_annotation/json_annotation.dart';

part 'notifications_model.g.dart';

@JsonSerializable()
class NotificationsModel {
  final List<NotificationItemModel> response;

  NotificationsModel({required this.response});

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsModelToJson(this);
}

@JsonSerializable()
class NotificationItemModel {
  @JsonKey(name: '_id')
  final String id;
  final String message;
  @JsonKey(name: 'sender_id')
  final String senderId;
  @JsonKey(name: 'user_id')
  final String userId;
  final bool seen;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;
  @JsonKey(name: 'sender_name')
  final String senderName;

  NotificationItemModel({
    required this.id,
    required this.message,
    required this.senderId,
    required this.userId,
    required this.seen,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.senderName,
  });

  factory NotificationItemModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationItemModelToJson(this);
}
