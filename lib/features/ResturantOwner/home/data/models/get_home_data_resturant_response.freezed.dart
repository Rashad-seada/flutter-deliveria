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
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GetHomeDataResturantResponse _$GetHomeDataResturantResponseFromJson(
  Map<String, dynamic> json,
) {
  return _GetHomeDataResturantResponse.fromJson(json);
}

/// @nodoc
mixin _$GetHomeDataResturantResponse {
  @JsonKey(name: 'total_orders')
  int get totalOrders => throw _privateConstructorUsedError;
  @JsonKey(name: 'net_revenue')
  num get netRevenue => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_feedback')
  double get customerFeedback => throw _privateConstructorUsedError;
  @JsonKey(name: 'oders_of_last_week')
  List<int> get ordersOfLastWeek => throw _privateConstructorUsedError;

  /// Serializes this GetHomeDataResturantResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetHomeDataResturantResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetHomeDataResturantResponseCopyWith<GetHomeDataResturantResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetHomeDataResturantResponseCopyWith<$Res> {
  factory $GetHomeDataResturantResponseCopyWith(
    GetHomeDataResturantResponse value,
    $Res Function(GetHomeDataResturantResponse) then,
  ) =
      _$GetHomeDataResturantResponseCopyWithImpl<
        $Res,
        GetHomeDataResturantResponse
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'total_orders') int totalOrders,
    @JsonKey(name: 'net_revenue') num netRevenue,
    @JsonKey(name: 'customer_feedback') double customerFeedback,
    @JsonKey(name: 'oders_of_last_week') List<int> ordersOfLastWeek,
  });
}

/// @nodoc
class _$GetHomeDataResturantResponseCopyWithImpl<
  $Res,
  $Val extends GetHomeDataResturantResponse
>
    implements $GetHomeDataResturantResponseCopyWith<$Res> {
  _$GetHomeDataResturantResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetHomeDataResturantResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalOrders = null,
    Object? netRevenue = null,
    Object? customerFeedback = null,
    Object? ordersOfLastWeek = null,
  }) {
    return _then(
      _value.copyWith(
            totalOrders:
                null == totalOrders
                    ? _value.totalOrders
                    : totalOrders // ignore: cast_nullable_to_non_nullable
                        as int,
            netRevenue:
                null == netRevenue
                    ? _value.netRevenue
                    : netRevenue // ignore: cast_nullable_to_non_nullable
                        as num,
            customerFeedback:
                null == customerFeedback
                    ? _value.customerFeedback
                    : customerFeedback // ignore: cast_nullable_to_non_nullable
                        as double,
            ordersOfLastWeek:
                null == ordersOfLastWeek
                    ? _value.ordersOfLastWeek
                    : ordersOfLastWeek // ignore: cast_nullable_to_non_nullable
                        as List<int>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GetHomeDataResturantResponseImplCopyWith<$Res>
    implements $GetHomeDataResturantResponseCopyWith<$Res> {
  factory _$$GetHomeDataResturantResponseImplCopyWith(
    _$GetHomeDataResturantResponseImpl value,
    $Res Function(_$GetHomeDataResturantResponseImpl) then,
  ) = __$$GetHomeDataResturantResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'total_orders') int totalOrders,
    @JsonKey(name: 'net_revenue') num netRevenue,
    @JsonKey(name: 'customer_feedback') double customerFeedback,
    @JsonKey(name: 'oders_of_last_week') List<int> ordersOfLastWeek,
  });
}

/// @nodoc
class __$$GetHomeDataResturantResponseImplCopyWithImpl<$Res>
    extends
        _$GetHomeDataResturantResponseCopyWithImpl<
          $Res,
          _$GetHomeDataResturantResponseImpl
        >
    implements _$$GetHomeDataResturantResponseImplCopyWith<$Res> {
  __$$GetHomeDataResturantResponseImplCopyWithImpl(
    _$GetHomeDataResturantResponseImpl _value,
    $Res Function(_$GetHomeDataResturantResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GetHomeDataResturantResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalOrders = null,
    Object? netRevenue = null,
    Object? customerFeedback = null,
    Object? ordersOfLastWeek = null,
  }) {
    return _then(
      _$GetHomeDataResturantResponseImpl(
        totalOrders:
            null == totalOrders
                ? _value.totalOrders
                : totalOrders // ignore: cast_nullable_to_non_nullable
                    as int,
        netRevenue:
            null == netRevenue
                ? _value.netRevenue
                : netRevenue // ignore: cast_nullable_to_non_nullable
                    as num,
        customerFeedback:
            null == customerFeedback
                ? _value.customerFeedback
                : customerFeedback // ignore: cast_nullable_to_non_nullable
                    as double,
        ordersOfLastWeek:
            null == ordersOfLastWeek
                ? _value._ordersOfLastWeek
                : ordersOfLastWeek // ignore: cast_nullable_to_non_nullable
                    as List<int>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GetHomeDataResturantResponseImpl
    implements _GetHomeDataResturantResponse {
  const _$GetHomeDataResturantResponseImpl({
    @JsonKey(name: 'total_orders') required this.totalOrders,
    @JsonKey(name: 'net_revenue') required this.netRevenue,
    @JsonKey(name: 'customer_feedback') required this.customerFeedback,
    @JsonKey(name: 'oders_of_last_week')
    required final List<int> ordersOfLastWeek,
  }) : _ordersOfLastWeek = ordersOfLastWeek;

  factory _$GetHomeDataResturantResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$GetHomeDataResturantResponseImplFromJson(json);

  @override
  @JsonKey(name: 'total_orders')
  final int totalOrders;
  @override
  @JsonKey(name: 'net_revenue')
  final num netRevenue;
  @override
  @JsonKey(name: 'customer_feedback')
  final double customerFeedback;
  final List<int> _ordersOfLastWeek;
  @override
  @JsonKey(name: 'oders_of_last_week')
  List<int> get ordersOfLastWeek {
    if (_ordersOfLastWeek is EqualUnmodifiableListView)
      return _ordersOfLastWeek;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ordersOfLastWeek);
  }

  @override
  String toString() {
    return 'GetHomeDataResturantResponse(totalOrders: $totalOrders, netRevenue: $netRevenue, customerFeedback: $customerFeedback, ordersOfLastWeek: $ordersOfLastWeek)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetHomeDataResturantResponseImpl &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            (identical(other.netRevenue, netRevenue) ||
                other.netRevenue == netRevenue) &&
            (identical(other.customerFeedback, customerFeedback) ||
                other.customerFeedback == customerFeedback) &&
            const DeepCollectionEquality().equals(
              other._ordersOfLastWeek,
              _ordersOfLastWeek,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalOrders,
    netRevenue,
    customerFeedback,
    const DeepCollectionEquality().hash(_ordersOfLastWeek),
  );

  /// Create a copy of GetHomeDataResturantResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetHomeDataResturantResponseImplCopyWith<
    _$GetHomeDataResturantResponseImpl
  >
  get copyWith => __$$GetHomeDataResturantResponseImplCopyWithImpl<
    _$GetHomeDataResturantResponseImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetHomeDataResturantResponseImplToJson(this);
  }
}

abstract class _GetHomeDataResturantResponse
    implements GetHomeDataResturantResponse {
  const factory _GetHomeDataResturantResponse({
    @JsonKey(name: 'total_orders') required final int totalOrders,
    @JsonKey(name: 'net_revenue') required final num netRevenue,
    @JsonKey(name: 'customer_feedback') required final double customerFeedback,
    @JsonKey(name: 'oders_of_last_week')
    required final List<int> ordersOfLastWeek,
  }) = _$GetHomeDataResturantResponseImpl;

  factory _GetHomeDataResturantResponse.fromJson(Map<String, dynamic> json) =
      _$GetHomeDataResturantResponseImpl.fromJson;

  @override
  @JsonKey(name: 'total_orders')
  int get totalOrders;
  @override
  @JsonKey(name: 'net_revenue')
  num get netRevenue;
  @override
  @JsonKey(name: 'customer_feedback')
  double get customerFeedback;
  @override
  @JsonKey(name: 'oders_of_last_week')
  List<int> get ordersOfLastWeek;

  /// Create a copy of GetHomeDataResturantResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetHomeDataResturantResponseImplCopyWith<
    _$GetHomeDataResturantResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
