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
  final String? id;
  final String? message;
  @JsonKey(name: 'sender_id')
  final String? senderId;
  @JsonKey(name: 'user_id')
  final String? userId;
  final bool? seen;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'sender_name')
  final String? senderName;

  NotificationItemModel({
    this.id,
    this.message,
    this.senderId,
    this.userId,
    this.seen,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.senderName,
  });

  factory NotificationItemModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationItemModelToJson(this);
}
