import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request_body.g.dart';

@JsonSerializable()
class SignUpRequestBody {
  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  final String email;
  final String password;
  final String phone;

  SignUpRequestBody({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
  });


  Map<String, dynamic> toJson() => _$SignUpRequestBodyToJson(this);
}