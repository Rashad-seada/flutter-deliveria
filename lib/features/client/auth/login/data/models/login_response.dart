import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResponse {
  final String message;
  final String token;
  @JsonKey(name: 'user')
  final LoginUser? user;
  @JsonKey(name: 'restaurant')
  final LoginRestaurant? restaurant;
  @JsonKey(name: 'agent')
  final LoginAgent? agent;
  final String userType;

  LoginResponse({
    required this.message,
    required this.token,
    this.user,
    this.restaurant,
    this.agent,
    required this.userType,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginUser {
  final LoginCoordinates? coordinates;
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String phone;
  final String email;
  final bool ban;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;
  @JsonKey(name: 'address_id')
  final String? addressId;

  LoginUser({
    required this.coordinates,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.ban,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.addressId,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) =>
      _$LoginUserFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginRestaurant {
  final LoginCoordinates? coordinates;
  @JsonKey(name: '_id')
  final String id;
  final String photo;
  final String logo;
  @JsonKey(name: 'super_category')
  final List<String> superCategory;
  @JsonKey(name: 'sub_category')
  final List<String> subCategory;
  final String name;
  final String phone;
  @JsonKey(name: 'user_name')
  final String userName;
  @JsonKey(name: 'about_us')
  final String aboutUs;
  @JsonKey(name: 'rate_number')
  final int rateNumber;
  @JsonKey(name: 'user_rated')
  final int userRated;
  final int rate;
  final List<dynamic> reviews;
  @JsonKey(name: 'delivery_cost')
  final int deliveryCost;
  @JsonKey(name: 'loacation_map')
  final String loacationMap;
  @JsonKey(name: 'open_hour')
  final String openHour;
  @JsonKey(name: 'close_hour')
  final String closeHour;
  @JsonKey(name: 'have_delivery')
  final bool haveDelivery;
  @JsonKey(name: 'is_show')
  final bool isShow;
  @JsonKey(name: 'is_show_in_home')
  final bool isShowInHome;
  @JsonKey(name: 'estimated_time')
  final int estimatedTime;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;

  LoginRestaurant({
    required this.coordinates,
    required this.id,
    required this.photo,
    required this.logo,
    required this.superCategory,
    required this.subCategory,
    required this.name,
    required this.phone,
    required this.userName,
    required this.aboutUs,
    required this.rateNumber,
    required this.userRated,
    required this.rate,
    required this.reviews,
    required this.deliveryCost,
    required this.loacationMap,
    required this.openHour,
    required this.closeHour,
    required this.haveDelivery,
    required this.isShow,
    required this.isShowInHome,
    required this.estimatedTime,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory LoginRestaurant.fromJson(Map<String, dynamic> json) =>
      _$LoginRestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRestaurantToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginAgent {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String phone;
  @JsonKey(name: 'user_name')
  final String userName;
  final bool ban;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;

  LoginAgent({
    required this.id,
    required this.name,
    required this.phone,
    required this.userName,
    required this.ban,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory LoginAgent.fromJson(Map<String, dynamic> json) =>
      _$LoginAgentFromJson(json);

  Map<String, dynamic> toJson() => _$LoginAgentToJson(this);
}

@JsonSerializable()
class LoginCoordinates {
  @JsonKey(fromJson: _toDouble, toJson: _fromDouble)
  final double? latitude;
  @JsonKey(fromJson: _toDouble, toJson: _fromDouble)
  final double? longitude;

  LoginCoordinates({
    this.latitude,
    this.longitude,
  });

  factory LoginCoordinates.fromJson(Map<String, dynamic> json) {
    return LoginCoordinates(
      latitude: _toDouble(json['latitude']),
      longitude: _toDouble(json['longitude']),
    );
  }

  Map<String, dynamic> toJson() => _$LoginCoordinatesToJson(this);

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      if (value.trim().isEmpty) return null;
      return double.tryParse(value);
    }
    return null;
  }

  static dynamic _fromDouble(double? value) => value;
}
