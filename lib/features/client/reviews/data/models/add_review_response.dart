import 'package:json_annotation/json_annotation.dart';

part 'add_review_response.g.dart';

@JsonSerializable()
class AddReviewResponse {
  final bool success;
  final String message;

  AddReviewResponse({
    required this.success,
    required this.message,
  });

  factory AddReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$AddReviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddReviewResponseToJson(this);
}