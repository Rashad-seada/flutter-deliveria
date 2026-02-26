// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_home_data_resturant_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetHomeDataResturantResponse _$GetHomeDataResturantResponseFromJson(
    Map<String, dynamic> json) {
  return _GetHomeDataResturantResponse.fromJson(json);
}

/// @nodoc
mixin _$GetHomeDataResturantResponse {
  @JsonKey(name: 'response')
  HomeDataResponse get response => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetHomeDataResturantResponseCopyWith<GetHomeDataResturantResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetHomeDataResturantResponseCopyWith<$Res> {
  factory $GetHomeDataResturantResponseCopyWith(
          GetHomeDataResturantResponse value,
          $Res Function(GetHomeDataResturantResponse) then) =
      _$GetHomeDataResturantResponseCopyWithImpl<$Res,
          GetHomeDataResturantResponse>;
  @useResult
  $Res call({@JsonKey(name: 'response') HomeDataResponse response});

  $HomeDataResponseCopyWith<$Res> get response;
}

/// @nodoc
class _$GetHomeDataResturantResponseCopyWithImpl<$Res,
        $Val extends GetHomeDataResturantResponse>
    implements $GetHomeDataResturantResponseCopyWith<$Res> {
  _$GetHomeDataResturantResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_value.copyWith(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as HomeDataResponse,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $HomeDataResponseCopyWith<$Res> get response {
    return $HomeDataResponseCopyWith<$Res>(_value.response, (value) {
      return _then(_value.copyWith(response: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetHomeDataResturantResponseImplCopyWith<$Res>
    implements $GetHomeDataResturantResponseCopyWith<$Res> {
  factory _$$GetHomeDataResturantResponseImplCopyWith(
          _$GetHomeDataResturantResponseImpl value,
          $Res Function(_$GetHomeDataResturantResponseImpl) then) =
      __$$GetHomeDataResturantResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'response') HomeDataResponse response});

  @override
  $HomeDataResponseCopyWith<$Res> get response;
}

/// @nodoc
class __$$GetHomeDataResturantResponseImplCopyWithImpl<$Res>
    extends _$GetHomeDataResturantResponseCopyWithImpl<$Res,
        _$GetHomeDataResturantResponseImpl>
    implements _$$GetHomeDataResturantResponseImplCopyWith<$Res> {
  __$$GetHomeDataResturantResponseImplCopyWithImpl(
      _$GetHomeDataResturantResponseImpl _value,
      $Res Function(_$GetHomeDataResturantResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$GetHomeDataResturantResponseImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as HomeDataResponse,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetHomeDataResturantResponseImpl
    implements _GetHomeDataResturantResponse {
  const _$GetHomeDataResturantResponseImpl(
      {@JsonKey(name: 'response') required this.response});

  factory _$GetHomeDataResturantResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetHomeDataResturantResponseImplFromJson(json);

  @override
  @JsonKey(name: 'response')
  final HomeDataResponse response;

  @override
  String toString() {
    return 'GetHomeDataResturantResponse(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetHomeDataResturantResponseImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetHomeDataResturantResponseImplCopyWith<
          _$GetHomeDataResturantResponseImpl>
      get copyWith => __$$GetHomeDataResturantResponseImplCopyWithImpl<
          _$GetHomeDataResturantResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetHomeDataResturantResponseImplToJson(
      this,
    );
  }
}

abstract class _GetHomeDataResturantResponse
    implements GetHomeDataResturantResponse {
  const factory _GetHomeDataResturantResponse(
          {@JsonKey(name: 'response')
          required final HomeDataResponse response}) =
      _$GetHomeDataResturantResponseImpl;

  factory _GetHomeDataResturantResponse.fromJson(Map<String, dynamic> json) =
      _$GetHomeDataResturantResponseImpl.fromJson;

  @override
  @JsonKey(name: 'response')
  HomeDataResponse get response;
  @override
  @JsonKey(ignore: true)
  _$$GetHomeDataResturantResponseImplCopyWith<
          _$GetHomeDataResturantResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

HomeDataResponse _$HomeDataResponseFromJson(Map<String, dynamic> json) {
  return _HomeDataResponse.fromJson(json);
}

/// @nodoc
mixin _$HomeDataResponse {
  @JsonKey(name: 'restaurant')
  RestaurantHomeInfo get restaurant =>
      throw _privateConstructorUsedError; // orders_of_last_week is likely here at the root of 'response'
  @JsonKey(name: 'orders_of_last_week')
  List<int>? get ordersOfLastWeek =>
      throw _privateConstructorUsedError; // Add these just in case, but they seem to be 0 in the log
  @JsonKey(name: 'total_orders')
  int? get totalOrders => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_revenue')
  num? get totalRevenue => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_rating')
  double? get averageRating => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeDataResponseCopyWith<HomeDataResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeDataResponseCopyWith<$Res> {
  factory $HomeDataResponseCopyWith(
          HomeDataResponse value, $Res Function(HomeDataResponse) then) =
      _$HomeDataResponseCopyWithImpl<$Res, HomeDataResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'restaurant') RestaurantHomeInfo restaurant,
      @JsonKey(name: 'orders_of_last_week') List<int>? ordersOfLastWeek,
      @JsonKey(name: 'total_orders') int? totalOrders,
      @JsonKey(name: 'total_revenue') num? totalRevenue,
      @JsonKey(name: 'average_rating') double? averageRating});

  $RestaurantHomeInfoCopyWith<$Res> get restaurant;
}

/// @nodoc
class _$HomeDataResponseCopyWithImpl<$Res, $Val extends HomeDataResponse>
    implements $HomeDataResponseCopyWith<$Res> {
  _$HomeDataResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restaurant = null,
    Object? ordersOfLastWeek = freezed,
    Object? totalOrders = freezed,
    Object? totalRevenue = freezed,
    Object? averageRating = freezed,
  }) {
    return _then(_value.copyWith(
      restaurant: null == restaurant
          ? _value.restaurant
          : restaurant // ignore: cast_nullable_to_non_nullable
              as RestaurantHomeInfo,
      ordersOfLastWeek: freezed == ordersOfLastWeek
          ? _value.ordersOfLastWeek
          : ordersOfLastWeek // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      totalOrders: freezed == totalOrders
          ? _value.totalOrders
          : totalOrders // ignore: cast_nullable_to_non_nullable
              as int?,
      totalRevenue: freezed == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as num?,
      averageRating: freezed == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RestaurantHomeInfoCopyWith<$Res> get restaurant {
    return $RestaurantHomeInfoCopyWith<$Res>(_value.restaurant, (value) {
      return _then(_value.copyWith(restaurant: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeDataResponseImplCopyWith<$Res>
    implements $HomeDataResponseCopyWith<$Res> {
  factory _$$HomeDataResponseImplCopyWith(_$HomeDataResponseImpl value,
          $Res Function(_$HomeDataResponseImpl) then) =
      __$$HomeDataResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'restaurant') RestaurantHomeInfo restaurant,
      @JsonKey(name: 'orders_of_last_week') List<int>? ordersOfLastWeek,
      @JsonKey(name: 'total_orders') int? totalOrders,
      @JsonKey(name: 'total_revenue') num? totalRevenue,
      @JsonKey(name: 'average_rating') double? averageRating});

  @override
  $RestaurantHomeInfoCopyWith<$Res> get restaurant;
}

/// @nodoc
class __$$HomeDataResponseImplCopyWithImpl<$Res>
    extends _$HomeDataResponseCopyWithImpl<$Res, _$HomeDataResponseImpl>
    implements _$$HomeDataResponseImplCopyWith<$Res> {
  __$$HomeDataResponseImplCopyWithImpl(_$HomeDataResponseImpl _value,
      $Res Function(_$HomeDataResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restaurant = null,
    Object? ordersOfLastWeek = freezed,
    Object? totalOrders = freezed,
    Object? totalRevenue = freezed,
    Object? averageRating = freezed,
  }) {
    return _then(_$HomeDataResponseImpl(
      restaurant: null == restaurant
          ? _value.restaurant
          : restaurant // ignore: cast_nullable_to_non_nullable
              as RestaurantHomeInfo,
      ordersOfLastWeek: freezed == ordersOfLastWeek
          ? _value._ordersOfLastWeek
          : ordersOfLastWeek // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      totalOrders: freezed == totalOrders
          ? _value.totalOrders
          : totalOrders // ignore: cast_nullable_to_non_nullable
              as int?,
      totalRevenue: freezed == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as num?,
      averageRating: freezed == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeDataResponseImpl implements _HomeDataResponse {
  const _$HomeDataResponseImpl(
      {@JsonKey(name: 'restaurant') required this.restaurant,
      @JsonKey(name: 'orders_of_last_week') final List<int>? ordersOfLastWeek,
      @JsonKey(name: 'total_orders') this.totalOrders,
      @JsonKey(name: 'total_revenue') this.totalRevenue,
      @JsonKey(name: 'average_rating') this.averageRating})
      : _ordersOfLastWeek = ordersOfLastWeek;

  factory _$HomeDataResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeDataResponseImplFromJson(json);

  @override
  @JsonKey(name: 'restaurant')
  final RestaurantHomeInfo restaurant;
// orders_of_last_week is likely here at the root of 'response'
  final List<int>? _ordersOfLastWeek;
// orders_of_last_week is likely here at the root of 'response'
  @override
  @JsonKey(name: 'orders_of_last_week')
  List<int>? get ordersOfLastWeek {
    final value = _ordersOfLastWeek;
    if (value == null) return null;
    if (_ordersOfLastWeek is EqualUnmodifiableListView)
      return _ordersOfLastWeek;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// Add these just in case, but they seem to be 0 in the log
  @override
  @JsonKey(name: 'total_orders')
  final int? totalOrders;
  @override
  @JsonKey(name: 'total_revenue')
  final num? totalRevenue;
  @override
  @JsonKey(name: 'average_rating')
  final double? averageRating;

  @override
  String toString() {
    return 'HomeDataResponse(restaurant: $restaurant, ordersOfLastWeek: $ordersOfLastWeek, totalOrders: $totalOrders, totalRevenue: $totalRevenue, averageRating: $averageRating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeDataResponseImpl &&
            (identical(other.restaurant, restaurant) ||
                other.restaurant == restaurant) &&
            const DeepCollectionEquality()
                .equals(other._ordersOfLastWeek, _ordersOfLastWeek) &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      restaurant,
      const DeepCollectionEquality().hash(_ordersOfLastWeek),
      totalOrders,
      totalRevenue,
      averageRating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeDataResponseImplCopyWith<_$HomeDataResponseImpl> get copyWith =>
      __$$HomeDataResponseImplCopyWithImpl<_$HomeDataResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeDataResponseImplToJson(
      this,
    );
  }
}

abstract class _HomeDataResponse implements HomeDataResponse {
  const factory _HomeDataResponse(
      {@JsonKey(name: 'restaurant')
      required final RestaurantHomeInfo restaurant,
      @JsonKey(name: 'orders_of_last_week') final List<int>? ordersOfLastWeek,
      @JsonKey(name: 'total_orders') final int? totalOrders,
      @JsonKey(name: 'total_revenue') final num? totalRevenue,
      @JsonKey(name: 'average_rating')
      final double? averageRating}) = _$HomeDataResponseImpl;

  factory _HomeDataResponse.fromJson(Map<String, dynamic> json) =
      _$HomeDataResponseImpl.fromJson;

  @override
  @JsonKey(name: 'restaurant')
  RestaurantHomeInfo get restaurant;
  @override // orders_of_last_week is likely here at the root of 'response'
  @JsonKey(name: 'orders_of_last_week')
  List<int>? get ordersOfLastWeek;
  @override // Add these just in case, but they seem to be 0 in the log
  @JsonKey(name: 'total_orders')
  int? get totalOrders;
  @override
  @JsonKey(name: 'total_revenue')
  num? get totalRevenue;
  @override
  @JsonKey(name: 'average_rating')
  double? get averageRating;
  @override
  @JsonKey(ignore: true)
  _$$HomeDataResponseImplCopyWith<_$HomeDataResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RestaurantHomeInfo _$RestaurantHomeInfoFromJson(Map<String, dynamic> json) {
  return _RestaurantHomeInfo.fromJson(json);
}

/// @nodoc
mixin _$RestaurantHomeInfo {
  @JsonKey(name: 'statistics')
  RestaurantStatistics get statistics => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RestaurantHomeInfoCopyWith<RestaurantHomeInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantHomeInfoCopyWith<$Res> {
  factory $RestaurantHomeInfoCopyWith(
          RestaurantHomeInfo value, $Res Function(RestaurantHomeInfo) then) =
      _$RestaurantHomeInfoCopyWithImpl<$Res, RestaurantHomeInfo>;
  @useResult
  $Res call({@JsonKey(name: 'statistics') RestaurantStatistics statistics});

  $RestaurantStatisticsCopyWith<$Res> get statistics;
}

/// @nodoc
class _$RestaurantHomeInfoCopyWithImpl<$Res, $Val extends RestaurantHomeInfo>
    implements $RestaurantHomeInfoCopyWith<$Res> {
  _$RestaurantHomeInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statistics = null,
  }) {
    return _then(_value.copyWith(
      statistics: null == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as RestaurantStatistics,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RestaurantStatisticsCopyWith<$Res> get statistics {
    return $RestaurantStatisticsCopyWith<$Res>(_value.statistics, (value) {
      return _then(_value.copyWith(statistics: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RestaurantHomeInfoImplCopyWith<$Res>
    implements $RestaurantHomeInfoCopyWith<$Res> {
  factory _$$RestaurantHomeInfoImplCopyWith(_$RestaurantHomeInfoImpl value,
          $Res Function(_$RestaurantHomeInfoImpl) then) =
      __$$RestaurantHomeInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'statistics') RestaurantStatistics statistics});

  @override
  $RestaurantStatisticsCopyWith<$Res> get statistics;
}

/// @nodoc
class __$$RestaurantHomeInfoImplCopyWithImpl<$Res>
    extends _$RestaurantHomeInfoCopyWithImpl<$Res, _$RestaurantHomeInfoImpl>
    implements _$$RestaurantHomeInfoImplCopyWith<$Res> {
  __$$RestaurantHomeInfoImplCopyWithImpl(_$RestaurantHomeInfoImpl _value,
      $Res Function(_$RestaurantHomeInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statistics = null,
  }) {
    return _then(_$RestaurantHomeInfoImpl(
      statistics: null == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as RestaurantStatistics,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RestaurantHomeInfoImpl implements _RestaurantHomeInfo {
  const _$RestaurantHomeInfoImpl(
      {@JsonKey(name: 'statistics') required this.statistics});

  factory _$RestaurantHomeInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RestaurantHomeInfoImplFromJson(json);

  @override
  @JsonKey(name: 'statistics')
  final RestaurantStatistics statistics;

  @override
  String toString() {
    return 'RestaurantHomeInfo(statistics: $statistics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantHomeInfoImpl &&
            (identical(other.statistics, statistics) ||
                other.statistics == statistics));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, statistics);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantHomeInfoImplCopyWith<_$RestaurantHomeInfoImpl> get copyWith =>
      __$$RestaurantHomeInfoImplCopyWithImpl<_$RestaurantHomeInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RestaurantHomeInfoImplToJson(
      this,
    );
  }
}

abstract class _RestaurantHomeInfo implements RestaurantHomeInfo {
  const factory _RestaurantHomeInfo(
          {@JsonKey(name: 'statistics')
          required final RestaurantStatistics statistics}) =
      _$RestaurantHomeInfoImpl;

  factory _RestaurantHomeInfo.fromJson(Map<String, dynamic> json) =
      _$RestaurantHomeInfoImpl.fromJson;

  @override
  @JsonKey(name: 'statistics')
  RestaurantStatistics get statistics;
  @override
  @JsonKey(ignore: true)
  _$$RestaurantHomeInfoImplCopyWith<_$RestaurantHomeInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RestaurantStatistics _$RestaurantStatisticsFromJson(Map<String, dynamic> json) {
  return _RestaurantStatistics.fromJson(json);
}

/// @nodoc
mixin _$RestaurantStatistics {
  @JsonKey(name: 'total_orders')
  int get totalOrders => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_revenue')
  num get totalRevenue => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_rating')
  num get averageRating => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RestaurantStatisticsCopyWith<RestaurantStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantStatisticsCopyWith<$Res> {
  factory $RestaurantStatisticsCopyWith(RestaurantStatistics value,
          $Res Function(RestaurantStatistics) then) =
      _$RestaurantStatisticsCopyWithImpl<$Res, RestaurantStatistics>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_orders') int totalOrders,
      @JsonKey(name: 'total_revenue') num totalRevenue,
      @JsonKey(name: 'average_rating') num averageRating});
}

/// @nodoc
class _$RestaurantStatisticsCopyWithImpl<$Res,
        $Val extends RestaurantStatistics>
    implements $RestaurantStatisticsCopyWith<$Res> {
  _$RestaurantStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalOrders = null,
    Object? totalRevenue = null,
    Object? averageRating = null,
  }) {
    return _then(_value.copyWith(
      totalOrders: null == totalOrders
          ? _value.totalOrders
          : totalOrders // ignore: cast_nullable_to_non_nullable
              as int,
      totalRevenue: null == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as num,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as num,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RestaurantStatisticsImplCopyWith<$Res>
    implements $RestaurantStatisticsCopyWith<$Res> {
  factory _$$RestaurantStatisticsImplCopyWith(_$RestaurantStatisticsImpl value,
          $Res Function(_$RestaurantStatisticsImpl) then) =
      __$$RestaurantStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_orders') int totalOrders,
      @JsonKey(name: 'total_revenue') num totalRevenue,
      @JsonKey(name: 'average_rating') num averageRating});
}

/// @nodoc
class __$$RestaurantStatisticsImplCopyWithImpl<$Res>
    extends _$RestaurantStatisticsCopyWithImpl<$Res, _$RestaurantStatisticsImpl>
    implements _$$RestaurantStatisticsImplCopyWith<$Res> {
  __$$RestaurantStatisticsImplCopyWithImpl(_$RestaurantStatisticsImpl _value,
      $Res Function(_$RestaurantStatisticsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalOrders = null,
    Object? totalRevenue = null,
    Object? averageRating = null,
  }) {
    return _then(_$RestaurantStatisticsImpl(
      totalOrders: null == totalOrders
          ? _value.totalOrders
          : totalOrders // ignore: cast_nullable_to_non_nullable
              as int,
      totalRevenue: null == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as num,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RestaurantStatisticsImpl implements _RestaurantStatistics {
  const _$RestaurantStatisticsImpl(
      {@JsonKey(name: 'total_orders') required this.totalOrders,
      @JsonKey(name: 'total_revenue') required this.totalRevenue,
      @JsonKey(name: 'average_rating') required this.averageRating});

  factory _$RestaurantStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RestaurantStatisticsImplFromJson(json);

  @override
  @JsonKey(name: 'total_orders')
  final int totalOrders;
  @override
  @JsonKey(name: 'total_revenue')
  final num totalRevenue;
  @override
  @JsonKey(name: 'average_rating')
  final num averageRating;

  @override
  String toString() {
    return 'RestaurantStatistics(totalOrders: $totalOrders, totalRevenue: $totalRevenue, averageRating: $averageRating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantStatisticsImpl &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, totalOrders, totalRevenue, averageRating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantStatisticsImplCopyWith<_$RestaurantStatisticsImpl>
      get copyWith =>
          __$$RestaurantStatisticsImplCopyWithImpl<_$RestaurantStatisticsImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RestaurantStatisticsImplToJson(
      this,
    );
  }
}

abstract class _RestaurantStatistics implements RestaurantStatistics {
  const factory _RestaurantStatistics(
          {@JsonKey(name: 'total_orders') required final int totalOrders,
          @JsonKey(name: 'total_revenue') required final num totalRevenue,
          @JsonKey(name: 'average_rating') required final num averageRating}) =
      _$RestaurantStatisticsImpl;

  factory _RestaurantStatistics.fromJson(Map<String, dynamic> json) =
      _$RestaurantStatisticsImpl.fromJson;

  @override
  @JsonKey(name: 'total_orders')
  int get totalOrders;
  @override
  @JsonKey(name: 'total_revenue')
  num get totalRevenue;
  @override
  @JsonKey(name: 'average_rating')
  num get averageRating;
  @override
  @JsonKey(ignore: true)
  _$$RestaurantStatisticsImplCopyWith<_$RestaurantStatisticsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
