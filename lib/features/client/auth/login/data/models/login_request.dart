import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_request.g.dart';

@JsonSerializable()
class LoginRequestBody {
  final String phone;
  final String password;
  @JsonKey(name: "FBtoken")
  final String fbToken;

  LoginRequestBody( {required this.phone, required this.password , required this.fbToken});

  Map<String, dynamic> toJson() => _$LoginRequestBodyToJson(this);
}
